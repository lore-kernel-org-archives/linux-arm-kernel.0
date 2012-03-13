From: tim.bird@am.sony.com (Tim Bird)
Date: Tue, 13 Mar 2012 12:10:04 -0700
Subject: RFC: Stack overrun detector on ARM - ideas?
Message-ID: <4F5F9B8C.2060105@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello smart ARM people...

I've been asked to forward port a patch that Sony was using in previous
kernel versions, for detecting stack overruns on ARM processors.
I'm having trouble getting it working on current kernels, and
was wondering if this was the best approach anyway.  I just wanted
to get some feedback and see if there were possibly other ideas
for approaches that would work for this purpose.  This has been
primarily used for our group using 4K stacks, for testing
prior to product shipment. But it might be useful in other
circumstances, so hopefully there is some interest in the feature.

What we did in the past:
1) Add a config option to map all kernel pages individually (as
4K units)
2) Add a config option to support marking individual pages as
non-readable (or absent), so that if ever accessed they would
result in a kernel fault.
3) Add code to mark the bottom page of each kernel stack as
non-readable, thus creating a guard page.
4) Add a config option to put the thread info at the top of stack
rather than at the bottom.  This allows the stack to grow down
and hit the guard page, without overruning the threadinfo struct.
5) Add a config value to allow specifying the start size of
the kernel stack, to allow experimentation with different stack
sizes.  (That is, the stack could be initialized at 4K above the
guard page, or 6k, or 8k, etc.)

The main idea is to allow the product team to get a fault on a
stack overrun for a selectable value of stack size.

I have most of the code working (parts 3-5), but 1-2 seems to
be a problem. In reading this thread:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/084899.html
and
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086955.html

it appears that 4K kernel mappings is not supported, and would
be hard to re-instate.  (I have a patch that worked in previous
kernels, but frankly I'm having a hard time understanding it - I'm
not an ARM memory management guru.)

My questions are - Did the kernel used to map memory with 4K section
mappings, or has it been 1MB for a long time?
How hard would it be to implement 4K mappings (ie get my patch
working again)?  Is there another way to do this that would be
better?  I was thinking of maybe setting a hardware breakpoint
region below the stack, rather than using a guard page.  It seems
like these are limited in number, so I would have to change them with
context switches to reflect each newly active stack.  This stack monitoring
feature is not turned on in products - it is only used for internal
testing - so performance impact is not an issue.

In looking at the ARM hardware debug capabilities, they appear to
be quite complex.  Has anyone done something with per-task
hardware breakpoints before, or is there some place I can look
for an example?

Any other ideas for ways to detect stack overruns?

Note that we already use static stack analysis
on the kernel executable image, as well as runtime stack monitoring
using tracers.  The former doesn't catch runtime-nested stack depth,
and the latter doesn't catch leaves with deep stack usage very well.
Possibly I could create a table of leaf function depths, or do
runtime scanning of the function prefix, to make the tracer-based
stack monitoring more accurate.

Thanks for any help, ideas or pointers you can provide.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================
