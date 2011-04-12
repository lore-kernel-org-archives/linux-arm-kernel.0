From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Tue, 12 Apr 2011 17:30:27 +0100 (BST)
Subject: [RFC PATCH] Current status, suspend-to-disk support on ARM
In-Reply-To: <20110412055958.GA3507@ucw.cz>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412055958.GA3507@ucw.cz>
Message-ID: <alpine.DEB.2.00.1104121636460.29883@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011, Pavel Machek wrote:

> Hi!
>
>> There's one ugly thing in this set - I've changed a generic kernel
>> header, <linux/suspend.h> to #define save/restore_processor_state()
>> on ARM so that it only does preempt_disable/enable(). It's
>> surprising that this isn't the default behaviour; all platforms need
>> swsusp_arch_suspend/resume anyway so why force the existance of
>> _two_ arch-specific hooks ?
>
> Can you submit separate patch cleaning it up?

How about the attached ?

It's for discussion, and hence not tested (admittedly, I need an x86 test 
system ...).

The diff is against RMK's devel-stable tree, as of commit 
5f183860d5007ec76ea36bfa6c36d66e37f0dbcf


There's a few hurdles here:

a) who knows all assembly calling conventions for all architectures
    supported by linux ?

    This applies to SH and S390; save/restore_processor_state on those
    are primitive and should be inlined within swsusp_arch_suspend/resume,
    just like the attached patch does for the powerpc variants.

    I've done a bounce call within S390 but don't know enough about SH3
    for arch/sh/kernel/cpu/sh3/swsusp.S - i.e. add a call in assembly to
    init_cpu(current), and then ditch save_processor_state.

b) some architectures do things _beyond_ register/state saving in those
    two functions, and hence rely on them being called paired.

c) CONFIG_KEXEC_JUMP (ab-)uses them. I don't know that subsystem at all,
    but this sort of re-use means the symbols can't just be ditched.
    They become arch-dependent though, no non-arch/ code calls them
    anymore.

What I've attached might break SH3 swsusp, as save_processor_state 
is no longer called there (it stores FPU state).




I've also been wondering:
The comments in kernel/power/hibernate.c mention the need to get preempt 
counts "right" as major motivator to call save/restore_processor_state.
effect" of save/restore_processor_state).

But then on all architectures in kernels as far back as 2.6.32 it doesn't 
look like save/restore_processor state are actually adjusting the preempt 
count; nowhere do they call preempt_enable/disable.

What is and what is not necessary, really ?


Finally, on things like e.g. the floating point context saves: Wouldn't 
this happen as part of freezing processes (in the early stages of 
suspend), and/or as part of device quiesce ?
I wonder why e.g. powerpc does it explicitly; not doing so on ARM doesn't 
seem to cause problems.



>
>> @@ -195,6 +195,14 @@ config VECTORS_BASE
>>  	help
>>  	  The base address of exception vectors.
>>
>> +config ARCH_HIBERNATION_POSSIBLE
>> +	bool
>> +	help
>> +	  If the machine architecture supports suspend-to-disk
>> +	  it should select this automatically for you.
>> +	  Otherwise, say 'Y' at your own peril.
>> +
>
> Good for debugging, but not good for mainline.

How would this be done better ?

FrankH.

>
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: remove-save_processor_state.patch
Type: text/x-diff
Size: 10417 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110412/6de02f2b/attachment.bin>
