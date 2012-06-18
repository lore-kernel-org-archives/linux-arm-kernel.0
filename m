From: olof@lixom.net (Olof Johansson)
Date: Sun, 17 Jun 2012 18:10:16 -0700
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <20120611051502.GA24030@july>
References: <20120611051502.GA24030@july>
Message-ID: <CAOesGMgGQMwQTUy2g-XSYFrQ-p+x9g2q8kAd-ZYq=TBgVFu0Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 10:15 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
>
> Some boards can use the trustzone but others can't use trustzone.
> However we need to build it simultaneously. To address this issue,
> introduce arm trustzone support and use it at each board files.
>
> e.g., In boot_secondary at mach-exynos/platsmp.c
>
> ? ? ? ?__raw_writel(virt_to_phys(exynos4_secondary_startup),
> ? ? ? ? ? ? ? ?CPU1_BOOT_REG);
>
> ? ? ? ?if (trustzone_enabled()) {
> ? ? ? ? ? ? ? ?/* Call Exynos specific smc call */
> ? ? ? ? ? ? ? ?/* exynos_smc(SMC_CMD_CPU1BOOT, cpu, 0, 0); */
> ? ? ? ?}
>
> ? ? ? ?gic_raise_softirq(cpumask_of(cpu), 1);
>
> ? ? ? ?if (pen_release == -1)

I would prefer to see this handled by using the smp_ops patchset that
Marc Zyngier has been posting instead, replacing the boot_secondary
function pointer during early boot depending on whether trustzone is
enabled or not.


-Olof
