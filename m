From: liuwei@actions-semi.com (=?utf-8?B?5YiY54Kc?=)
Date: Mon, 3 Jul 2017 16:13:34 +0800
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for
 S500
In-Reply-To: <a7360245-5a65-7146-f295-0e90fb428173@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
 <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
 <CAK8P3a3Pg2rm8nSPUm_E61F7+zSr3gWV6sNqhC0Et3Zh2xPtmA@mail.gmail.com>
 <6d9d0d63-113e-b050-a54e-62746ebc6013@suse.de>
 <DC4E6E803E914F4B8AFE57F1456019F1035B7C89@srv-mail-02.actions.com.cn>
 <a7360245-5a65-7146-f295-0e90fb428173@suse.de>
Message-ID: <DC4E6E803E914F4B8AFE57F1456019F10364478E@srv-mail-02.actions.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andreas

Actually the owl_v7_invalidate_l1 is not needed, and the headsmp-owl.S file can be removed if pen release staff is not used. The CPUx can jump to secondary_startup directly by setting OWL_CPUx_ADDR register.

Because S900 is aarch64 architecture, it cannot boot CPUx simply by setting SPS register. It depends on the low-level arm-trusted-firmware. Linux kernel can boot up CPUx by PSCI interface, and the arm-trusted-firmware will power on CPUx, initialize EL3 register and jump to EL2 entry in Linux kernel.

Best Regards,
David Liu

-----Original Message-----
From: Andreas F?rber [mailto:afaerber at suse.de] 
Sent: Sunday, July 02, 2017 3:57 AM
To: ??
Cc: Arnd Bergmann; Thomas Liau; Linux ARM; mp-cs; ???; ???; 96boards at ucrobotics.com; support at lemaker.org; Linux Kernel Mailing List; Russell King
Subject: Re: ??: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500

Hi David,

Am 01.07.2017 um 06:42 schrieb ??:
> OWL_CPUx_ADDR is the physical address of CPUx wakeup function.
> OWL_CPUx_FLAG is a valid flag of OWL_CPUx_ADDR. 
> 
> After CPUxs are wakeuped by SEV instruction, they will check their own OWL_CPUx_FLAG register. If the register vlaue is 0x55aa, CPUx will jump to OWL_CPUx_ADDR to boot up, otherwize go to sleep by WFE.
> 
> So the pen release staff is not necessary, you can remove these code safely.

Thank you for the quick confirmation!

I have just tested a patch, and it appears to work.

Is owl_v7_invalidate_l1 necessary? mach-sunxi (that Arnd pointed to as
example) uses secondary_startup directly, without custom assembler code.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/mach-actions/headsmp.S

> BTW: CPU2/3 must exit the power gate state before wakeup, and CPU1 is always power on and has no power gate control.

Yes, the S500 SPS was luckily documented in the manual. The power-gating
for CPU2/3 is already implemented:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm/mach-actions/platsmp.c

For S900 however SPS is sadly not documented... If you know who at
Actions Semi could help there, please also take a look at:
https://github.com/96boards/documentation/issues/59

Best regards,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
