From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 11 Sep 2015 21:38:40 +0900
Subject: [RFC] stack tracer on arm64
Message-ID: <55F2CB50.3040109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Junseok's bug report[1] about stack tracer on arm64 has exposed additional
issues to me. I tried to fix them for the last few weeks, and submitted
several RFC/patches.  But the problems seem to be more complicated than
I first imagined.

So, before taking further steps, I'd like you to have time to read
the following document and give me your thoughts on it.

Some of my ideas, particularly a function prologue analyzer, are difficult
to implement, and may have no guarantee to handle all the cases correctly.
Some may have impact on code size (and extra instructions at runtime).
I think that we should find out the balance of accuracy/conveniences of
this tool (stack tracer) and added complexities/open issues.

-Takahiro AKASHI

Table of Contents
=================
I.  basic flow of stack tracer

II. issues on the naive implementation

III.my approach and open issues


I.  basic flow of stack tracer
------------------------------
Every C function invokes a ftrace hook routine, _mcount or ftrace_caller,
in its function prologue.

    step-1.If the current stack pointer indicates that we have a new record
           of maximum stack usage, then do the followings.
    step-2.call arch-specific save_stack_trace() to collect a list of functions
           in current call chains (we name it a stack dump list here.)
    step-3.For each function in a stack dump list, compare it against
           every 4bytes of integer on the stack data.
    step-4.If matched, we recognize the matched location in the stack as
           a current stack pointer for this function
           (for example, idxB for func_B:pcB)
    step-5.calculate a "stack index" for this function as
               <top address of stack> - <stack pointer>
           and record the value into dump_stack_index[].

LOW     |        |
rspA    |        |
         |  ... <----------- static/dynamic local variables in func_A
         |        |
rbpA    +--------+   func_A (pcA, rbpA, rspA)
         |  rbpB  |
    idxB +--------+
         |  pcB   |
         |  ... <----------- extra function args to func_A
rspB    + - - - -+
         |        |
         |  ... <----------- static/dynamic local variables in func_B
         |        |
rbpB    +--------+   func_B (pcB, rbpB, rspB)
         |  rbpC  |
    idxC +--------+
         |  pcC   |
         |  ... <----------- extra function args to func_B
rspC    + - - - -+
         |        |
         |  ... <----------- static/dynamic local variables in func_C
         |        |
rbpC    +--------+   func_C (pcC, rbpC, rspC)
         |        |
         |  ...   |
top     + - - - -+
HIGH
	* In the figure above, rbp(frame pointer) and rsp(stack
           pointer) point to respective addresses@the time after
           a function prologue has been done but before a callee function
           is called.

Later on, "cat /sys/kernel/debug/tracing/stack_trace" shows the latest list
of stack dump with sizes for each function.
     - stack size for func_B, for example, is calculated as
            <stack size> = (top - idxB) - (top - idxC)


II. issues on the naive implementation
--------------------------------------
By "naive implementation," I mean how the mainline kernel without any
modification behaves with ftrace-based stack tracer.
(Currently, there is no arch-specific code on arm64 regarding stack tracer.)

1) slurping stack

    Assume that a given function A was invoked, and it was invoked again in
    another context, then it called another function B which allocated a large
    length of local variable on the stack, but it has not modified the variable
    yet.
    When stack tracer, in step-3, examines the stack looking for B, then A,
    we may have a chance to accidentally find a staled, not current, stack
    frame for A because the old frame might reside on the memory for
    the variable which has not been overwritten.

     a. The stack_trace output may have staled entries.

2) differences between x86 and arm64

    On x86, "call" instruction automatically pushes a return address on
    the top of the stack and decrements a stack pointer. Then child function
    allocates its local variables on the stack.

    On arm64, a child function decreases reserve memory for local variables,
    pushes a return address (LR) and old frame pointer then updates a frame
    pointer to stack pointer.

    So step-3/4 seems OK on x86, but on arm64, an estimated stack pointer,
    idxB in the picture below, is not appropriate for our purpose because it
    contains child function's "local variables."
    We should instead use spB, if possible, for better result.

     a. Stack size for a function in stack_trace output is inaccurate,
        or rather wrong.
        (It seems as if <Size> field is one-line offset against <Location>.)

LOW     |  ...   |
fpA     +--------+   func_A (pcA, fpA, spA)
         |  fpB   |
    idxB + - - - -+
         |  pcB   |
         |  ... <----------- static local variables in func_A
         |  ...   |             and extra function args to func_A
spB     + - - - -+
         |  ... <----------- dynamically allocated variables in func_B
fpB     +--------+   func_B (pcB, fpB, spB)
         |  fpC   |
    idxC + - - - -+
         |  pcC   |
         |  ... <----------- static local variables in func_B
         |  ...   |             and extra function args to func_B
spC     + - - - -+
         |  ...   |
fpC     +--------+   func_C (pcC, fpC, spC)
HIGH    |        |

3) Interrupted frame
    We miss one or two functions when an interrupt occurs.
    Assume that func_D calls func_C, func_C calls func_B, func_B is
    interrupted by a device, el1_irq calls func_A, and so on.

      a.Since el1_irq (and other exception vectors) doesn't update a frame
        pointer (x29), the current wind_stackframe() tracks only
            func_A -> el1_irq -> func_C -> func_D
        and always misses func_B in a stack dump list.

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpB   |
         |  pcI   |
         |  ...   |
spI     +--------+   el1_irq (pcI, fpB, spI)
         |        |
         |  ...   |
         |        |
         |  fpB   |
         |  spB   |
         |  pcB   |
         |  ...   |
fpB,spB +--------+   func_B (pcB, fpB, spB)
         |  fpC   |
         |  pcC   |
         |  ...   |
fpC,spC +--------+   func_C (pcC, fpC, spC)
         |  fpD   |
         |  pcD   |
         |  ...   |
fpD,spD +--------+   func_D (pcD, fpD, spD)
HIGH    |        |

      b.Even worse, if an interrupt occurs in a function prolog of func_B,
        a stack frame can be uncompleted and a frame pointer may still
        points to one of func_C (fpC).
        In this case, we also miss func_C in a stack dump list.
      c.As a result, stack sizes for functions around el1_irq are wrong.

4) functions under function_graph tracer

    To catch an event of function return, function_graph tracer rewrites
    LR register saved in a stack frame to a hook function, return_to_handler.
    An original value is saved in current->ret_stack[] on entry and restored
    later on exit by ftrace_return_to_handler() called in return_to_handler.

     a. With function_graph tracer on, unwind_stackframe() will return lots of
        bogus entries, "return_to_handler-0x4."

    Apart from stack tracer, fixing this issue might make more sense, say,
    for panic cases because panic_stack_dump() also uses unwind_frame().

5) leaf function

    gcc (on arm64) will, by default, optimize a leaf function by removing
    a stack frame. This causes several issues:

     a.we always miss a case of maximum stack size whenever a leaf function
       is at the top of call chains because a stack tracer code will never
       be executed against it.
     b.When an interrupt occurs during a leaf function (func_B), we miss its
       parent function (func_C) in a stack dump list because func_B has no
       stack frame and elr_el1 still points to func_C's frame.
       (This is a variant case as described in "interrupted frame" section.)

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpB   |
         |  pcI   |
         |  ...   |
spI     +--------+   el1_irq (pcI, fpC, spI)
         (pt_regs)|
         |  ...   |
         |  fpC   |
         |  spB   |
         |  pcB   |
spB     +--------+   func_B (pcB, fpC, spB)
         |  ...   |
fpC,spC +--------+   func_C (pcC, fpC, spC)
HIGH    |        |

6) KVM
    (T.B.D.)


III.my approach and open issues
-------------------------------

1) slurping stack, and
2) differences between x86 and arm64

    Instead of slurping stack data like at step-3/4, we extend save_stack_trace()
    /wind_stackframe() to collect a list of stack pointers for all call chains.
    Since arm64 ABI does not save a stack pointer in a stack frame, we try to
    calculate that value from callee's stack frame.

    For example, in the following case, a value of stack point when func_B
    calls func_A is calculated as:

         spB = fpA + (XX -- YY)

    where XX and YY are determined by a "function prologue analyzer" described
    in "interrupted frame" section.

LOW     |  ...   |
fpA     +--------+   func_A (pcA, fpA, spA)
         |  fpB   |
         |  pcB   |
         |  ... <----------- static local variables in func_A
         |  ...   |             and extra function args to func_A
spB     + - - - -+
         |  ... <----------- dynamically allocated variables in func_B
fpB     +--------+   func_B (pcB, fpB, spB)
         |  fpC   |
         |  pcC   |
         |  ... <----------- static local variables in func_B
         |  ...   |             and extra function args to func_B
spC     + - - - -+
         |  ...   |
fpC     +--------+   func_C (pcC, fpC, spC)
HIGH    |        |

         open issue-0: This fix also depends on function prologue analyzer
                  being available.

3) interrupted frame

    First of all, we should update a frame pointer even in exception vector
    code so that unwind_frame() can dereference stack frames.
    Since exception handlers place data of 'struct pt_regs' instead of
    'struct stackframe' in *normal* functions, we will take special
    care of this case.

	open issue-1: should we use the same form of stack frame here?

    This way, we will see an additional entry, func_B in the figure above,
    in a stack dump list but we still have a chance to miss func_C.

    My idea here is to analyze a function prologue and determine where
    an interrupt is actually taken, then to re-build a stack frame if necessary.

         open issue-2: it seems to be very difficult to implement such a parser
                  for all the possible patterns of function prologue. This is
                  partly because gcc doesn't use a fixed template to generate
                  a function prologue code, and partly because "instruction
                  scheduling" may mess up a function prologue and a body.

    According to comments from some toolchain guy, using libunwind with
    compiler-generated "unwind tables" information would be most promising
    for implementing an function prologue analyzer.
    It seems, however, that any previous attempts to merge libunwind into
    the kernel has been abandoned[2].

    So, in the followings, I try to describe an outline of my own prototype
    (simple) analyzer and how it is utilized in order to find out func_C.

    My analyzer recognizes two patterns of function prologue, (A) and (B),
    which I think cover most cases, and identifies a location of interrupt,
    1, 2, 3 and 0 (a normal case).

    function prologues
    ------------------
    (A)
          sub sp, sp, #XX
          stp x29, x30, [sp, #YY]
          add x29, sp, #YY
          ...
    (B)
          stp x29, x30, [sp, #-XX]
          mov x29, sp
          ...

    Due to gcc's instruction scheduling, we may see other instructions
    between those assembler lines of function prologue.

    location of interrupt
    ---------------------
          (A)                     (B)
    loc-1
  	 sub sp, sp, #XX         stp, x29, x30, [sp, #-XX]
    loc-2
          stp x29, x30, [sp, #YY]
    loc-3
          add x29, sp, #YY        mov x29, sp
    loc-0
          <function body>         <function body>

    Here,
           loc-1: SP not updated, FP/LR not saved, FP not updated
           loc-2: SP updated, FP/LR not saved, FP not updated
           loc-3: SP updated, FP/LR saved, FP not updated
           loc-0: SP updated, FP/LR saved, FP updated

    Re-build a stack frame for func_B and func_C
    --------------------------------------------
    The following figures illustrate how we can re-build a stack frame for
    func_B and func_C based on available data on the stack.

    (loc-0)

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpI   |
         |  pcI   |
         |  ...   |
fpI,spI +--------+   el1_irq (pcI, fpI, spI)
         |        |
         |  ...   |
         |        |
         |  fpB   |
         |  spB   |
         |  pcB   |
         |  ...   |
fpB,spB +--------+   func_B (pcB, fpB, spB)
         |  fpC   |
         |  pcC   |
         |  ...   |
fpC,spC +--------+   func_C (pcC, fpC, spC)
         |  fpD   |
         |  pcD   |
         |  ...   |
fpD,spD +--------+   func_D (pcD, fpD, spD)
HIGH    |        |

    => calculate
              frame B: sp: *(spI + S_SP)
                       fp: *(spI + S_FP)
                       pc: *(spI + S_PC)

    (loc-3)

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpI   |
         |  pcI   |
         |  ...   |
fpI,spI +--------+   el1_irq (pcI, fpI, spI)
         |        |
         |  ...   |
         |        |
         |  fpC   |
         |  spB   |
         |  pcB   |
         |  ...   |
spB     +--------+   func_B (pcB, fpC, spB)
         |  fpC   |
         |  pcC   |
         |  ...   |
fpC,spC +--------+   func_C (pcC, fpC, spC)
         |  fpD   |
         |  pcD   |
         |  ...   |
fpD,spD +--------+   func_D (pcD, fpD, spD)
HIGH    |        |

    => calculate
              frame B: sp: *(spI + F_SP)
                       fp: *(spI + F_FP)
                       pc: *(spI + F_PC)
              frame C: sp: spB + XX
                       fp: fpB'
                       pc: *(spB + YY + 0x8)

    (loc-2)

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpI   |
         |  pcI   |
         |  ...   |
fpI,spI +--------+   el1_irq (pcI, fpI, spI)
         |        |
         |  ...   |
         |        |
         |  fpC   |
         |  spB   |
         |  pcB   |
         |  ...   |
spB     +--------+   func_B (pcB, fpC, spB)
         |   x    |
         |   x    |
         |  ...   |
fpC,spC +--------+   func_C (pcC, fpC, spC)
         |  fpD   |
         |  pcD   |
         |  ...   |
fpD,spD +--------+   func_D (pcD, fpD, spD)
HIGH    |        |

    => calculate
              frame B: sp: *(spI + F_SP)
                       fp: *(spI + F_FP)
                       pc: *(spI + F_PC)
              frame C: sp: spB + XX
                       fp: fpB'
                       pc: "branch dest at pcD"

    (loc-1)

LOW     |        |
fpA,spA +--------+   func_A (pcA, fpA, spA)
         |  fpI   |
         |  pcI   |
         |  ...   |
fpI,spI +--------+   el1_irq (pcI, fpI, spI)
         |        |
         |  ...   |
         |        |
         |  fpC   |
         |  spC   |
         |  pcB   |
         |  ...   |   func_B (pcB, fpC, spC)
fpC,spC +--------+   func_C (pcC, fpC, spC)
         |  fpD   |
         |  pcD   |
         |  ...   |
fpD,spD +--------+   func_D (pcD, fpD, spD)
HIGH    |        |

    => calculate
              frame B: sp: *(spI + F_SP)
                       fp: *(spI + F_FP)
                       pc: *(spI + F_PC)
              frame C: sp: spB'
                       fp: fpB'
                       pc: "branch dest at pcD"

         In the case of loc-1 or loc-2,
         open issue-3: PC derived from parent's bl instruction (pcC) is
                  an entry address of the function, not the exact place
                  when an interrupt is taken.
         open issue-4: If parent's bl instruction is "blr", we have no way
                  to identify a branch destination address.
         open issue-5: Each tack pointer is determined from child to parent,
                  so PC for func_C cannot be fixed within wind_stackframe().

4) functions under function_graph tracer

    Unwind_frame() tries to replace "frame->pc" with an original value by
    looking it up in current->ret_stack[].

    Unfortunately, saving a value to this array, incrementing an array index,
    current->curr_ret_index, and updating memory on the stack are not done
    atomically because ftrace does not disable interrupts.
    So if an interrupt occurs and succeeding functions are also traced,
    recovering a stack dump list (stack_trace->entries) from ret_stack[]
    may result in a wrong list being created.

         open issue-6: wrong replacement
                  Assume that func_C calls func_B, func_B is interrupted, and
                  el1_irq calls func_A. Depending on when an interrupt is taken
                  during func_B, wind_stackframe() may return one of following
                  stack dump lists:
                  (please note that ftrace related functions are *not* traced.)

                 (A) interrupt during a function prologue
                         ...
                         return_to_handler(for A)
                         el1_irq
                         ...
                         ftrace_push_return_trace
                         prepare_ftrace_return
                         ftrace_caller
                         func_B
                         return_to_handler(for C)

                   we have pushed func_B in ret_stack[], but LR in a stack frame
                   has not yet been rewritten to return_to_handler.
                   since ret_stack[] has func_A, func_B and func_C, we replace
                         return_to_handler(for A) to func_A
                         return_to_handler(for C) to func_B
                   and so on.

                 (B) interrupt during a return hook
                         ...
                         return_to_handler(for A)
                         el1_irq
                         ...
                         ftrace_pop_return_trace
                         ftrace_return_to_handler
                         return_to_handler(for B)
                         return_to_handler(for C)

                   we may already have popped func_B from ret_stack[], and we
                   replace
                         return_to_handler(for A) to func_A
                         return_to_handler(for B) to func_C
                   and so on.

    In fact, there are more variant cases as pushing/popping against ret_stack[]
    is not an atomic operation and so data in this array and its index,
    current->ret_stack_index, may get inconsistent.

5) leaf function

    Adding arch-specific gcc option, -mno-omit-leaf-frame-pointer, to
    KBUILD_CFLAGS will assure that all the C functions have its own stack
    frame (after its function prologue).
    Then, issue 1-b will fall into issue-2.

         open issue-7: This fix will increase the code size of the kernel and
                  add extra instructions at runtime.


---
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354126.html
[2] https://lkml.org/lkml/2012/2/10/129
