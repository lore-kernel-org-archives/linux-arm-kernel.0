From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 20:50:44 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <555CB499.7060600@free.fr>
References: <20150514144239.GZ2067@n2100.arm.linux.org.uk>
 <20150518115452.GV2067@n2100.arm.linux.org.uk> <555CB499.7060600@free.fr>
Message-ID: <12867692.bB1EJHiPzq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 May 2015 18:21:45 Mason wrote:
> 
> On 18/05/2015 13:54, Russell King - ARM Linux wrote:
> 
> > For a SoC where WFI is not programmed to cause anything other than
> > the architecture specified dormant behaviour, WFI will not cause the
> > TWD to stop.
> 
> According to the hardware engineers, my SoC does not support any
> low-power modes.
> 
> But I didn't see the "clean" way to make the kernel aware of this.
> Is this an acceptable patch? (I have my doubts.)

No, this is clearly broken.

> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index 6591e26..300f13a 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -295,6 +295,10 @@ static void twd_timer_setup(void)
>         clk->name = "local_timer";
>         clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>                         CLOCK_EVT_FEAT_C3STOP;
> +#ifdef CONFIG_TANGOX
> +       /*** Tango does not implement low power modes ***/
> +       clk->features &= ~CLOCK_EVT_FEAT_C3STOP;
> +#endif
>         clk->rating = 350;
>         clk->set_mode = twd_set_mode;
>         clk->set_next_event = twd_set_next_event;

This will disable the feature on all machines that are configured 
in the kernel. You have to make a run-time decision instead, e.g.
based on a boolean DT property of the twd node.

	Arnd
