From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Feb 2012 16:24:06 -0800
Subject: [PATCH 3/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
In-Reply-To: <1330003320-17400-4-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Thu, 23 Feb 2012 15:21:57 +0200")
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
 <1330003320-17400-4-git-send-email-t-kristo@ti.com>
Message-ID: <87pqczst3t.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
>
> Now devices can idle independent of the powerdomain, there can be a
> window where device is idled and corresponding powerdomain can be
> ON/INACTIVE state. In such situations, since both module wake up is
> enabled at padlevel as well as io daisychain sequence is triggered,
> there will be 2 PRCM interrupts (Module async wake up via swakeup and
> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> Padlevel WKST bit in the first interrupt, module specific interrupt
> handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

My review comments from the last version of this patch were not
answered/addressed:

   http://marc.info/?l=linux-omap&m=132621832120535&w=2

[...]

> @@ -64,6 +65,12 @@ static void omap2_init_processor_devices(void)
>  	}
>  }
>  
> +void omap_trigger_wuclk_ctrl(void)
> +{
> +	if (cpu_is_omap44xx())
> +		omap4_trigger_wuclk_ctrl();
> +}

Subject says OMAP3+, but clearly this only works on OMAP4.

Also, no cpu_is* checks at runtime please.  Instead, at init time, use
cpu_is_* to initialize a function pointer.

Kevin
