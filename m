From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 09:46:07 -0800
Subject: [PATCHV2 REPOST 5/7] ARM: OMAP3PLUS PM: Add IO Daisychain support
 via hwmod mux
In-Reply-To: <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
 (Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:15 +0530")
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
 <1323878477-21122-6-git-send-email-vishwanath.bs@ti.com>
Message-ID: <8739bnsb6o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).

...in addition to the triggering still happening in the idle path,
right?   IIUC, after this series, there's still a call in omap_sram_idle().

> Now devices can idle independent of the powerdomain, there can be a window where device
> is idled and corresponding powerdomain can be ON/INACTIVE state. In such situations,
> since both module wake up is enabled at padlevel as well as io daisychain sequence is
> triggered, there will be 2 PRCM interrupts (Module async wake up via swakeup and IO Pad
> interrupt). But as PRCM Interrupt handler clears the Module Padlevel WKST bit in the
> first interrupt, module specific interrupt handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

[...]

> +void omap_trigger_wuclk_ctrl(void)
> +{
> +	if (cpu_is_omap34xx())
> +		omap3_trigger_wuclk_ctrl();
> +
> +	if (cpu_is_omap44xx())
> +		omap4_trigger_wuclk_ctrl();
> +}

cpu_is_* usage is only acceptable at init time.  Please use a function
pointer initialized at init time for this.

Kevin
