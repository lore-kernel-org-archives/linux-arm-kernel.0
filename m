From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 18 Nov 2011 15:21:30 -0800
Subject: ARM SWP/SWPB emulation support
Message-ID: <4EC6E87A.4070501@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have two questions regarding the following patch:

commit 64d2dc384e41e2b7acead6804593ddaaf8aad8e1
Author: Leif Lindholm<leif.lindholm@arm.com>
Date:   Thu Sep 16 18:00:47 2010 +0100
ARM: 6396/1: Add SWP/SWPB emulation for ARMv7 processors

First, the Kconfig text for the patch says the following:

  "In some older versions of glibc [<=2.8] SWP is used during futex
   trylock() operations with the assumption that the code will not
   be preempted. This invalid assumption may be more likely to fail
   with SWP emulation enabled, leading to deadlock of the user
   application."

I see that the SWP emulation is done using LDREX / STREX instructions, so it
looks like the SWP emulation should happen in an atomic manner with respect to
loading the previous value at the address being swapped with, and storing the
new value. Does this text simply imply that the old glibc implementation of
futex trylock() is incorrect in the specific way it uses SWP instructions, or
does it mean that there is a specific atomicity problem within the SWP emulation
code itself?

Second, I noticed that the SWP emulation code does not look@the condition
code for the SWP instruction being emulated. From my understanding of the ARM
architecture, the CPU may raise an undefined instruction exception regardless
of the condition code that may appear in the relevant bits of the underfined
instruction. Thus, with the SWP emulation code as-is, it is possible that a
conditional SWP/SWPB instruction may raise an undefined instruction exception
(and thus trigger the swp emulation code to run) even though the condition for
that instruction may not have been met in CPSR. As a result, conditional SWP
instructions may be emulated as if they had not been conditional. I have a patch
to add condition code checking to the SWP emulation code and if this seems right
to you, I could send it out. What do you think?

Thanks
Steve

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
