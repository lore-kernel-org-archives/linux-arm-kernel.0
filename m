From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 15:19:56 +0100
Subject: Armada XP Internal registers
In-Reply-To: <CAFJTrDsaq-NjLhcwHBuN1Q_zu-Q-yJkWLMUER1zVzc1=AFNM=Q@mail.gmail.com>
References: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
 <20131021174339.GA27284@localhost>
 <20131021184219.GA24520@titan.lakedaemon.net>
 <20131022152950.40171b36@skate>
 <CAFJTrDtKw0ANh55Y6xQtFzGtvmZOJ-ZC6cFuKV62L0tmmhT3uA@mail.gmail.com>
 <20131022181141.3f567273@skate>
 <CAFJTrDsaq-NjLhcwHBuN1Q_zu-Q-yJkWLMUER1zVzc1=AFNM=Q@mail.gmail.com>
Message-ID: <20131106151956.1fbdb4e4@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Matthew Minter,

On Wed, 6 Nov 2013 13:58:18 +0000, Matthew Minter wrote:

> I am sorry for the exceedingly long delay before replying, I have had
> a number of unrelated problems which have prevented me from working
> on this issue.
> 
> The version of u-boot which caused this issue was Marvell's Q2-2013
> release. I used this with a 3.12 rc1 and a 3.12 rc3 kernel, both
> receiving the errors I have mentioned above. I have ensured my low
> level debugging configuration is correct, it is indeed mapped
> correctly to the new register range and I do not believe this to be
> the problem, particularly as it crashes well after the early printk
> has begun giving output.
> 
> Unfortunately I cannot find the log file from the kernel at this
> stage as it appears to have been filled and overwritten, I however
> did look into this further and Marvell have (since when I raised the
> problem) given me a patched u-boot which is no longer causing the
> issue (the patch seems to be dated mid October 2013), unfortunately I
> cant post the change log of the patch but it does appear the problem
> was caused by a buggy u-boot release (or at least that it is fixed
> with the patched version). I have since tested the new version with
> kernels 3.12 rc3 to 3.12 rc6 and none of them have any issues with
> booting. Here is a full diff of the change I made to the device tree
> file (dont mind the bogus timestamps)
> 
> --- arch/arm/boot/dts/armada-xp-gp.dts.old    2013-11-06
> 13:39:17.440000000 +0000
> +++ arch/arm/boot/dts/armada-xp-gp.dts    2013-11-05
> 17:32:16.160001348 +0000
> @@ -39,7 +39,7 @@
>      };
> 
>      soc {
> -        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> +        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000

Yeah, classical old bootloaders vs. new bootloaders problem.

>                MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>                MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
> 
> I think the issue therefore may not be a kernel issue after all and
> should likely not be worried about. However on a related matter, I
> had thought the kernel was supposed to have some kind of detection
> for the register location using cp15? Why does the device tree
> describe the register address staticly if this is the case?

There is no such thing as a CP15 register that contains the base
address of the internal registers.

The base address of the internal registers is defined through a
register, which is itself part of the internal registers. So to set or
retrieve the base address of the internal registers, you have to know
what is the base address of the internal registers :-)

We've gone through /huge/ discussions about this on the list. I did
propose to use a spare CP15 bit somewhere to let the bootloader
indicate that the internal registers have been remapped to 0xf1, or
have been left at 0xd0. But this has been rejected by the ARM kernel
people, who considered it to be an ugly extension of the boot protocol
(i.e the interface between the bootloader and the kernel), which is
indeed a valid argument.

> Ultimately I think the specific errors I was getting (along with the
> exact error being variable dependant on seemingly random factors)
> made the specific errors a red herring and the problem was due to a
> faulty initialisation by the bootloader. However if there is any
> other information I can give or if anyone is interested I may be able
> to find out more.

What were the errors? From a quick read of the e-mail thread, I only
seem to see discussion about 0xd0 vs. 0xf1, which is a well known
problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
