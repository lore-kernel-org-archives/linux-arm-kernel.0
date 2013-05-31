From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 31 May 2013 10:48:03 -0700
Subject: [PATCH 1/2] rtc: omap: add option to indicate wakeup support
 through DT
In-Reply-To: <1369982005-8572-2-git-send-email-gururaja.hebbar@ti.com> (Hebbar
 Gururaja's message of "Fri, 31 May 2013 12:03:24 +0530")
References: <1369982005-8572-1-git-send-email-gururaja.hebbar@ti.com>
 <1369982005-8572-2-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <87wqqf11nw.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hebbar Gururaja <gururaja.hebbar@ti.com> writes:

> Even though RTC-IP is wakeup capable, Not all Boards support it.
>
> For example
> The rtc alarm wakeup is available in rtc-ip since omap1 days but alarm
> was not wired properly in previous ompa1 boards.
>
> 	commit fa5b07820fe3a0fc06ac368516e71f10a59b9539
> 	Author: Sekhar Nori <nsekhar@ti.com>
> 	Date:   Wed Oct 27 15:33:05 2010 -0700
>
> 	rtc: omap: let device wakeup capability be configured from chip
> 	init logic
>
> 	The rtc-omap driver currently hardcodes the RTC wakeup
> 	capability to be "not capable".  While this seems to be true for
> 	existing OMAP1 boards which are not wired for this, the
> 	DA850/OMAP-L138 SoC, the RTC can always be wake up source from
> 	its "deep sleep" mode.
>
> Current rtc-omap driver expects the rtc module wake-up capabilities to
> be set up by board specific code. However, in case of DT, this is not
> possible.
>
> So, add a DT property "ti,wakeup_capable" to indicate that the module is
> wake-up capable.

Why is this a TI-specific property?  

Also, I think we can do this without a new DT property.Did you see this
patch from Tony which is already queued for v3.11:

    http://marc.info/?l=linux-omap&m=136917244530612&w=2

I think this is the right way to go.  Platforms that don't want/need
wakeup support can disable it from userspace via:

    echo disabled > /sys/devices/.../power/wakeup

Kevin
