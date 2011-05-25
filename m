From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Wed, 25 May 2011 14:16:28 +0100 (BST)
Subject: [RFC PATCH v3] ARM hibernation/suspend-to-disk support
Message-ID: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've cleaned this up by the suggestions in the previous thread; this is 
the result.

- now baselined against rmk/devel-stable
- didn't create the <asm/suspend.h> because Rafael is just removing
   that everywhere anyway
- Fixes re prev suggestion:
 	local_fiq_enable/disable bracketing
 	save only absolutely essential regs and let cpu_init do the rest
 	thumb2 clean assembly
 	allows mach hooks (but they're not defined by this code)

- Also: uses the "generic suspend/resume support" code
   (commit f6b0fa02e8b0708d17d631afce456524eadf87ff, rmk/devel-stable)

Via the latter, the previously-used hooks into machine-dependent code, 
__save/__restore_processor_state, have become unnecessary.

This now simply calls the cpu_do_suspend/resume utilities provided by the 
generic code.


I'm still figuring out how to best test a recent devel-stable kernel ...


Please let me know what you think,
Thanks in advance,

FrankH.


==============================================================================
Note on non-current kernels (older than 2.6.38):
==============================================================================
The use of generic CPU suspend/resume also ties the code to a 
sufficiently-recent kernel - it requires the code from:

http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=commitdiff;h=f6b0fa02e8b0708d17d631afce456524eadf87ff

Which is, for many that (want to) use the feature, a hurdle...

If you're using an older kernel (2.6.37 or below), try the "generic" part 
posted via:

https://patchwork.kernel.org/patch/809212/

and add a __save/__restore_processor_state for your CPU type, as mentioned 
here:

http://lists.arm.linux.org.uk/lurker/message/20110520.123937.760c528f.en.html
==============================================================================
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hibernate-arm.patch
Type: text/x-diff
Size: 6606 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110525/5a6747ff/attachment-0001.bin>
