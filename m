From: yeasah@comrex.com (Yeasah Pell)
Date: Wed, 02 Dec 2009 09:40:41 -0500
Subject: strange, spurious seeming vector exception on pxa300
In-Reply-To: <f17812d70912012207x28178b1bh98fbf560b6da536@mail.gmail.com>
References: <4B159524.2020408@comrex.com>
	<f17812d70912012200m4532317eue21baf5e10925455@mail.gmail.com>
	<f17812d70912012207x28178b1bh98fbf560b6da536@mail.gmail.com>
Message-ID: <4B167C69.6060903@comrex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> On Wed, Dec 2, 2009 at 2:00 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>   
>> On Wed, Dec 2, 2009 at 6:13 AM, Yeasah Pell <yeasah@comrex.com> wrote:
>>     
>>> Has anybody ever seen vector exceptions happen on an ARM (xscale, pxa300)
>>> without 26-bit mode being used? I have some application and kernel code
>>> which appears to work on most hardware, but we have at least one board which
>>> causes periodic messages:
>>>
>>> Unhandled fault: vector exception (0x010) at 0x412c8a90
>>>
>>> (I also fudged the fault handler a bit to dump the SPSR: 0x80000010)
>>>       
>> Never had such exceptions. This is weird, SPSR[4] == 1 indicates a 32-bit mode.
>>     
>
> When the processor is in a 32-bit configuration (PROG32 is active) and
> in a 26-bit mode (CPSR[4] == 0),
> data access (but not instruction fetches) to the exception vectors
> (address 0x0 to 0x1f) causes a data abort.
> This is known as a vector exception.
>
> This is what explained in the manual, seems something related to 26-bit mode.
> What's your compiling environment and flags for your application?
>   

Hi, Eric -- thanks for the reply.

It's a crosstool-ng generated toolchain w/gcc 4.3.2. The optimization 
flags are '-mcpu=xscale -funroll-loops -O3', but it has been observed on 
debug builds which lack these flags as well.

There's no 26-bit code in the system that I'm aware of, certainly not in 
the application where the exception occurs. As you can see from the 
saved CPSR, the processor isn't in 26-bit mode at the time of the 
exception anyway. And even if it was, the load is from 0x412c8a90 
(etc.), not 0x0-0x1f. From what I've seen in the ARM architecture manual 
(mostly the part that you've copied above), this operation should not be 
able to cause such an exception, so I'm wondering if there is some 
alternate condition that can lead to this kind of exception.

In gdb, things look like this (after the SEGV from the fault is received 
by the target):

(gdb) info registers
r0             0x0    0
r1             0x412c8a04    1093437956
r2             0x0    0
r3             0x401c57f8    1075599352
r4             0x4029457c    1076446588
r5             0x9    9
r6             0x40390000    1077477376
r7             0x412c94e0    1093440736
r8             0x40390150    1077477712
r9             0x3d0f00    4001536
r10            0x4037a6bc    1077388988
r11            0x412c8b84    1093438340
r12            0x401d6c20    1075670048
sp             0x412c8a2c    0x412c8a2c
lr             0x4029603c    1076453436
pc             0x400ec47c    0x400ec47c <f1+172>
fps            0x0    0
cpsr           0x60000010    1610612752
(gdb) disassemble 0x400ec47c
Dump of assembler code for function f1:
0x400ec3d0 <f1+0>:    mov    r12, sp
0x400ec3d4 <f1+4>:    push    {r4, r5, r6, r7, r8, r9, r10, r11, r12, 
lr, pc}
0x400ec3d8 <f1+8>:    ldr    r4, [pc, #3508]    ; 0x400ed194 <f1+3524>
0x400ec3dc <f1+12>:    sub    r11, r12, #4    ; 0x4
0x400ec3e0 <f1+16>:    ldr    lr, [pc, #3504]    ; 0x400ed198 <f1+3528>
0x400ec3e4 <f1+20>:    ldr    r12, [pc, #3504]    ; 0x400ed19c <f1+3532>
0x400ec3e8 <f1+24>:    add    r3, pc, r4
0x400ec3ec <f1+28>:    sub    sp, sp, #304    ; 0x130
0x400ec3f0 <f1+32>:    str    r3, [r11, #-296]
0x400ec3f4 <f1+36>:    ldr    r4, [r3, r12]
0x400ec3f8 <f1+40>:    add    lr, r3, lr
0x400ec3fc <f1+44>:    ldr    r12, [r11, #-296]
0x400ec400 <f1+48>:    ldr    r3, [pc, #3480]    ; 0x400ed1a0 <f1+3536>
0x400ec404 <f1+52>:    str    r0, [r11, #-244]
0x400ec408 <f1+56>:    sub    r0, r11, #40    ; 0x28
0x400ec40c <f1+60>:    add    r3, r12, r3
0x400ec410 <f1+64>:    sub    r12, r11, #140    ; 0x8c
0x400ec414 <f1+68>:    str    r4, [r11, #-148]
0x400ec418 <f1+72>:    str    lr, [r11, #-144]
0x400ec41c <f1+76>:    stmib    r12, {r3, sp}
0x400ec420 <f1+80>:    str    r0, [r11, #-140]
0x400ec424 <f1+84>:    sub    r0, r11, #172    ; 0xac
0x400ec428 <f1+88>:    str    r1, [r11, #-248]
0x400ec42c <f1+92>:    str    r2, [r11, #-252]
0x400ec430 <f1+96>:    bl    0x400e1c60 <_init+1048>

0x400ec434 <f1+100>:    ldr    r1, [r11, #-248] ; beginning of "actual" 
function code
0x400ec438 <f1+104>:    cmp    r1, #0    ; 0x0 ; this is expected to be 
always unequal
0x400ec43c <f1+108>:    streq    r1, [r11, #-228]
0x400ec440 <f1+112>:    beq    0x400ec47c <f1+172>
0x400ec444 <f1+116>:    ldr    r3, [pc, #3416]    ; 0x400ed1a4 <f1+3540>
0x400ec448 <f1+120>:    ldr    r2, [r11, #-296]
0x400ec44c <f1+124>:    ldr    lr, [pc, #3412]    ; 0x400ed1a8 <f1+3544>
0x400ec450 <f1+128>:    mov    r0, r1
0x400ec454 <f1+132>:    ldr    r1, [r2, r3]
0x400ec458 <f1+136>:    mov    r3, #0    ; 0x0
0x400ec45c <f1+140>:    ldr    r2, [r2, lr]
0x400ec460 <f1+144>:    bl    0x400e3370 <_init+6952>
0x400ec464 <f1+148>:    cmp    r0, #0    ; 0x0 ; this is expected to be 
always equal
0x400ec468 <f1+152>:    ldrne    r12, [r11, #-244]
0x400ec46c <f1+156>:    movne    r3, #1    ; 0x1
0x400ec470 <f1+160>:    str    r0, [r11, #-228]
0x400ec474 <f1+164>:    strne    r3, [r12, #16]
0x400ec478 <f1+168>:    strne    r3, [r12, #8]

0x400ec47c <f1+172>:    ldr    r1, [r11, #-244] ; this throws an 
exception once in many thousand iterations
0x400ec480 <f1+176>:    ldr    r0, [r1, #16]
...

The compare at 0x400ec434 is expected to be unequal (and the register 
state shown above confirms this at the time of the exception), and the 
compare at 0x400ec464 is expected to be equal (again the register state 
confirms this). So we know the path of execution must have included for 
example 0x400ec448, which is a substantially similar operation to the 
one which causes the exception: a plain register load from the same page 
in memory.

I noticed that the instruction that throws the exception is a branch 
target (from 0x400ec430). Inserting a nop at the location the exception 
is thrown appears to avoid the problem at any timescale that I can 
detect (many hours at least, versus up to a few minutes that it takes to 
fail without it) -- but inserting a nop at any other location in the 
function doesn't seem effective. Perhaps I will try running this test 
with branch prediction disabled -- assuming that doesn't hurt 
performance so much that the test cannot be run.
