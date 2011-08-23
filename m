From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 15:52:25 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
Message-ID: <20051.48809.945431.800543@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're looking into porting Xen to the ARM A15 architecture.  In this
context, it's necessary to arrange for the Xen hypervisor to be
entered from the boot loader in an appropriate processor mode.

KVM needs to deal with the same problem, of course.  And any future
Linux kernel feature which uses the Secure State does too.

We are currently working with ARM's "Fast Model" of the Cortex A15, a
software emulator.  We're using it in the mode where you feed it an
ELF and it loads it into simulated RAM and starts executing at the
ELF entrypoint.  It does this in the CPU's defined startup mode, which
is Kernel mode in the Secure state.

It seems that this environment is what the nascent KVM-on-A15
developers [1] are using too.  There is modified version of the tiny
boot wrapper (the normal version of which just emulates the proper
calling API for the kernel); it sets up a trampoline security monitor.

We need to define a correct calling convention for the kernel which is
compatible with old systems, but which also allows the booted kernel
(Linux, perhaps KVM-enabled, or indeed a hypervisor like Xen) use of
all the available facilities.  The correct approach does seem to be to
have Linux set itself up a trivial trampoline which allows the kernel
to later regain the elevated privilege.

There are a couple of things with the existing KVM ARM approach with
the trivial boot wrapper which need to be fixed, though: firstly,
there should be separate trampolines for hypervisor mode and for
secure state.  That allows the two features to be used independently.
Secondly, the trivial trampolines should be part of the kernel proper
and their lifetime should not extend across the bootloader interface.

At first I thought that the best thing to do would be to boot the
kernel in any suitable mode, and have the kernel automatically detect
the starting mode.  I started writing code in linux's head.S to do
this.  However, detecting whether we are in secure state is very
difficult: it involves deliberately risking an undefined instruction
trap.  The code for this was getting rather long and involved.

Also, unconditionally starting a kernel in hypervisor mode seems
rather unfriendly.  At the moment we unconditionally start it in the
secure state and indeed in the current setup it seems to run entirely
in secure state.  It seems to me that the kernel should mostly run in
non-secure state.

So I propose the following approach:

 1. The kernel will advertise via ELF notes what modes it may be
    started in.  The possible modes will be:
       (i)   secure monitor mode
       (ii)  non-secure hypervisor mode
       (iii) non-secure kernel mode

 2. The bootloader will select the first mode from the three listed
    above which is supported by both the processor and the kernel to
    be loaded, and transition the processor to that mode.  If this
    involves dropping out of secure or hypervisor mode, it will put
    those modes permanently beyond use.

 3. The kernel will examine CPSR to determine which of the three
    possibilities above has happened, and:
   (a) If started in monitor mode:
       * Grant access to everything to non-secure state
       * Set the non-secure copies of the various CP15 registers
         which don't have a sane value on cpu reset
       * Install a trivial monitor vector which unconditionally
         copies r0 to MVBAR and returns
       * Switch to non-secure Hyp mode (if available) and do (b),
         or non-secure Kernel mode (if Hyp mode not supported).         
   (b) If started in Hyp mode:
       * Install a trivial hypervisor vector which unconditionally
         copies r0 to HVBAR and returns
   (c) Rest of startup.

Questions:

 1. What do people think ?  If this seems plausible I will prepare
    an RFC patch for Linux and the boot-wrapper.git.

 2. This cpu startup process must happen very early - before paging
    is enabled, in any case, so before RAM is really available.
    However, it produces two bits of information: 1. does the
    kernel own secure state; 2. does the kernel own hyp mode.
    Where should this information be stored ?

 3. Is Linux allowed to assume that the secondary CPUs have the
    same properties as the boot CPU ?  If not, where do I store the
    availability of the secure/hyp modes for the secondary cpus ?
    Perhaps that ought to be in the device tree.

 4. I'm not very familiar with the KVM on ARM code.  How much would
    have to be changed to existing KVM on ARM to make it conform to
    the above scheme ?  In particular it would have to not use SMC to
    adjust the HVBAR; instead, it would have to take control of HVBAR
    once per CPU.

Opinions welcome.

Thanks,
Ian.

[1] http://wiki.ncl.cs.columbia.edu/wiki/KVMARM:Guides:Development_Environment
