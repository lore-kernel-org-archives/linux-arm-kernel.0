From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 31 Jan 2012 12:27:15 +0530
Subject: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to
 pwrdm_clear_all_prev_pwrst()
In-Reply-To: <878vkopw2o.fsf@ti.com>
References: <20120130093931.11027.31048.stgit@dusk>
 <20120130094312.11027.31050.stgit@dusk> <878vkopw2o.fsf@ti.com>
Message-ID: <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 5:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
>> pwrdm_pre_transition(), which appears a few lines after these calls,
>> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's no
>> need to do it twice.
>
> It looks like these two for OMAP4 are surpurfluous since the immediately
> follow a call to pwrdm_pre_transition() as well.
>
> Santosh/Rajendra, please confirm/ack.
>
> Kevin
>
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 1d5d010..bbabe1d 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -263,12 +263,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> ? ? ? ? * In MPUSS OSWR or device OFF, interrupt controller ?contest is lost.
> ? ? ? ? */
> ? ? ? ?mpuss_clear_prev_logic_pwrst();
> - ? ? ? pwrdm_clear_all_prev_pwrst(mpuss_pd);
> ? ? ? ?if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
> ? ? ? ? ? ? ? ?(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
> ? ? ? ? ? ? ? ?save_state = 2;
>
> - ? ? ? clear_cpu_prev_pwrst(cpu);
> ? ? ? ?cpu_clear_prev_logic_pwrst(cpu);
> ? ? ? ?set_cpu_next_pwrst(cpu, power_state);
> ? ? ? ?set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));

The power domain pre-transition and post transition calls were kept
under the CONFIG_PM_DEBUG in the first few versions of the patches.
These pre and post
transition use to take lot of time once in while when measurement were
done and the only
useful thing they were doing was the counter updates. Later I removed
the PM_DEBUG as
per your suggestion.

As per Pauls comment they are optimised, so that should be good.

In this code the need is to clear only CPU and MPUPD, and hence they are
explicitly cleared since the pre/post transition calls can be moved to PM_DEBUG
in production kernels.

But as you stated in current mainline kernel they are superfluous since the
pre/post calls are not under PM debug. So I am ok either way

Regards
Santosh
