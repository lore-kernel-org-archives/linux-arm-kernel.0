From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 8 Aug 2012 15:52:12 +0900
Subject: [PATCH] ARM: formalize an IPI for CPU wake-ups
In-Reply-To: <5016D03D.8010607@codeaurora.org>
References: <alpine.LFD.2.02.1206111152190.23555@xanadu.home>
 <20120611155716.GA18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111241470.23555@xanadu.home>
 <20120611165115.GB18267@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1206111307550.23555@xanadu.home>
 <4FD62DBB.8070407@codeaurora.org>
 <20120611192519.GF18267@n2100.arm.linux.org.uk>
 <4FE1FB15.3090305@codeaurora.org>
 <0e0201cd5f2f$2c2f6e60$848e4b20$%kim@samsung.com>
 <5016D03D.8010607@codeaurora.org>
Message-ID: <CANqRtoQ9BCPhQPi38vK__61G2yAY=g9s17NG3LhSnrxdOYnkDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 3:19 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/10/12 23:34, Kukjin Kim wrote:
>> Stephen Boyd wrote:
>>> Great. Kukjin Kim, can exynos use SGI0? It looks like exynos is the only
>>> one left to move to SGI0.
>>>
>> Yeah, EXYNOS can use SGI0 instead of SGI1 :)
>>
>>
>
> Russell, can we apply something like this?
>
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 36c3984..090e32b 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -139,7 +139,7 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>
>                 __raw_writel(virt_to_phys(exynos4_secondary_startup),
>                         CPU1_BOOT_REG);
> -               gic_raise_softirq(cpumask_of(cpu), 1);
> +               gic_raise_softirq(cpumask_of(cpu), 0);
>
>                 if (pen_release == -1)
>                         break;
>
>
> I see we have another user of SGI1. Magnus/Rafael, can we move
> smp-emev2.c to use SGI0 instead of SGI1?

So I finally managed to try this out on my KZM9D board. The SMP bring
up code continues to work as expected, so it seems that SGI0 can be
used instead of SGI1 on EMEV2. Let's just say that the boot protocol
implemented by the mask ROM is rather poorly documented. Anyway, to
test I used the following patch on top of linux git 42a579a.

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2012-08-08 15:42:54.000000000 +0900
@@ -82,7 +82,7 @@ int __cpuinit emev2_boot_secondary(unsig
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));

-	gic_raise_softirq(cpumask_of(cpu), 1);
+	gic_raise_softirq(cpumask_of(cpu), 0);
 	return 0;
 }

So if/where needed, please add my:

Acked-by: Magnus Damm <damm@opensource.se>

Thanks,

/ magnus
