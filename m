From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Feb 2018 07:46:22 -0800
Subject: [PATCH 0/9] Some OMAP2+ legacy hwmod data cleanup
In-Reply-To: <20180213013243.8378-1-s-anna@ti.com>
References: <20180213013243.8378-1-s-anna@ti.com>
Message-ID: <20180213154622.GE6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [180213 01:33]:
> Hi Tony,
> 
> The following series cleans up some legacy dev_attr data associated
> with OMAP DMTimer, I2C, McBSP, McSPI and GPIO modules and removes
> roughly ~500 lines. Patches are based on v4.16-rc1. I have build tested
> for both omap2plus and omap1 defconfigs, and booted on a few OMAP4+
> boards that I have on my desk.

Hey that's great :)

> Here is the patch summary:
>  1. First two patches fixes header inclusion in omap-dmaengine.h and
>     hsmmc-omap.h as I am getting build errors on subsequent patches when
>     I removed some of the platform_data header files.
>  2. Patches 3 through 7 remove the .dev_attr data for the above modules
>     from various hwmod data files and some macros from McSPI & McBSP
>     platform data header files
>  3. Patch 8 moves the plat-omap/include/plat/i2c.h into mach-omap1
>     folder as there is no common i2c code in plat-omap folder anymore.
>  4. Last patch is a minor cleanup of gpio headers from couple of files.
> 
> Some important notes/comments:
>  - The DMTimer patch cleanup will conflict with Keerthy's current dmtimer->
>    clocksource series, but ideally he wouldn't need to convert the plat/dmtimer.h
>    into a clocksource header with the removal of the plat/dmtimer.h inclusion
>    from the hwmod data files.

OK. It seems that we should do the clean up first if it just means
leaving out unused header files.

>  - I found some gaps w.r.t DMTimers on DM814x/DM816x platforms, and haven't
>    fixed them. Both seems to have DMTimer1 through 8, but only DMTimers 1, 2
>    and 3 are defined in dm814x.dtsi, while dm816x.dtsi is missing DMTimer8.
>    DMTimer3 hwmod is not in the dm814x hwmod list, while DMTimer8 is left out
>    altogther. The timer capabilities are also different between the hwmod
>    data files (lists always-on) which is missing from corresponding dts files.
>    Not sure which one is correct.

OK we should fix them. The capabilities can be seen by looking at
the hardware and clockdomains. The always-on timers are of sysc
type 1 (ti,sysc-omap2-timer) and in a always on power domain. The
others are of sysc type 2 (ti,sysc-omap4-timer). We should get
warnings for those from ti,sysc driver eventually if they don't
match :)

> This leaves the hsmmc-omap and omap-dma pieces still using the .dev_attr. The
> former is only used by one OMAP3 board, so can be cleaned up if we limit the
> init code just for that one board.

I think Nikolaus had patches coming for removing the last user
of mmc pdata?

I think all we need to do is have pandora_wl1251_init_card
initialized in the MMC driver based on a compatible value..

Regards,

Tony
