From: rob.lee@linaro.org (Rob Lee)
Date: Fri, 9 Mar 2012 16:26:00 -0600
Subject: linux-next: manual merge of the cpuidle-cons tree with the
 arm-soc tree
In-Reply-To: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
References: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
Message-ID: <CAMXH7KE5En7U-2zydT3MfJ7C7B164-zsQuBoHMUqzD-Kb_nh1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

Yes, your resolution looks correct to me.

Thanks,
Rob Lee


On Fri, Mar 9, 2012 at 1:37 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Rob,
>
> Today's linux-next merge of the cpuidle-cons tree got a conflict in
> arch/arm/mach-at91/cpuidle.c between commit 00482a4078f4 ("ARM: at91:
> implement the standby function for pm/cpuidle") from the arm-soc tree and
> commit 7a1f6e72dce1 ("ARM: at91: Consolidate time keeping and irq
> enable") from the cpuidle-cons tree.
>
> I fixed it up (I think - see below) and can carry the fix as necessary.
> --
> Cheers,
> Stephen Rothwell ? ? ? ? ? ? ? ? ? ?sfr at canb.auug.org.au
>
> diff --cc arch/arm/mach-at91/cpuidle.c
> index 555d956,d40b3f3..0000000
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@@ -37,23 -33,15 +33,8 @@@ static int at91_enter_idle(struct cpuid
> ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_driver *drv,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? int index)
> ?{
> - ? ? ? struct timeval before, after;
> - ? ? ? int idle_time;
> -
> - ? ? ? local_irq_disable();
> - ? ? ? do_gettimeofday(&before);
> - ? ? ? if (index == 0)
> - ? ? ? ? ? ? ? /* Wait for interrupt state */
> - ? ? ? ? ? ? ? cpu_do_idle();
> - ? ? ? else if (index == 1)
> - ? ? ? ? ? ? ? at91_standby();
> ?- ? ? ?u32 saved_lpr;
> ?-
> ?- ? ? ?__asm__("b 1f; .align 5; 1:\n"
> ?- ? ? ?" ? ? ? mcr p15, 0, r0, c7, c10, 4"); ? /* drain write buffer */
> ?-
> ?- ? ? ?saved_lpr = sdram_selfrefresh_enable();
> ?- ? ? ?cpu_do_idle();
> ?- ? ? ?sdram_selfrefresh_disable(saved_lpr);
> ++ ? ? ?at91_standby();
>
> - ? ? ? do_gettimeofday(&after);
> - ? ? ? local_irq_enable();
> - ? ? ? idle_time = (after.tv_sec - before.tv_sec) * USEC_PER_SEC +
> - ? ? ? ? ? ? ? ? ? ? ? (after.tv_usec - before.tv_usec);
> -
> - ? ? ? dev->last_residency = idle_time;
> ? ? ? ?return index;
> ?}
>
