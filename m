From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Wed, 23 Feb 2011 19:58:39 -0800
Subject: Compilation error in ARM NOMMU kernel due to fixup_smp change
Message-ID: <4D65D76F.4000006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I am seeing the following compilation error in arch/arm/kernek/module.c 
when trying to compile an ARM NOMMU kernel (using Linus's tree as of an 
hour ago):

arch/arm/kernel/built-in.o: In function `module_finalize':
~/linux-2.6/arch/arm/kernel/module.c:337: undefined reference to `fixup_smp'
make: *** [.tmp_vmlinux1] Error 1

It looks like you have added fixup_smp to head.S but not to 
head-nommu.S, which is what gets used when building a NOMMU kernel. I 
have tried to find the original thread for that patch, but I was not 
able to find it, so I am just sending it here. I believe this was 
introduced by the commit below:

commit 4a9cb360197684a861bc06f06d33d5fcc8ffcbf5
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Thu Feb 10 15:25:18 2011 +0000

     ARM: fixup SMP alternatives in modules

     With certain configurations, we inline the unlock functions in modules,
     which results in SMP alternatives being created in modules.  We need to
     fix those up when loading a module to prevent undefined instruction
     faults.

     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I am not sure how you would want to go about fixing this (put the proper 
things into head-nommu.S, or just wrap the offending code in #ifdef 
CONFIG_MMU), but I thought I would bring this to your attention.

Thanks
Steve

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
