From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Aug 2016 20:15:41 +0530
Subject: [PATCH v3 1/4] ARM: davinci: da8xx-dt: Add ti-aemif lookup for
 clock matching
In-Reply-To: <20160816223338.20776-2-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <20160816223338.20776-2-kbeldan@baylibre.com>
Message-ID: <9e47844e-413b-4f85-5fbc-6b73cdd7fade@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 August 2016 04:03 AM, Karl Beldan wrote:
> Many davinci boards (da830 and da850 families) don't have their clocks
> in DT yet and won't be successful in getting an unnamed aemif clock

Actually none of DaVinci platforms have clocks in DT yet.

> without explicitly registering them via clk_lookups, failing the
> ti-aemif memory driver probe.

I am happy with the patch itself. But I think the terminology used in
the commit message can be made more accurate. clk_get() does not look up
a clock by name. It looks up a clock by consumer device and a consumer
id (used for multiple clocks used by same consumer device). The AEMIF
clock in DaVinci has a name already. Its assigned in da850.c as "aemif".
But the clock name itself does not matter in clock lookup.

So, IMO, saying "won't be successful in getting an unnamed aemif clock"
is inaccurate.

> The current aemif lookup entry resolving to the same clock:
>     'CLK(NULL,               "aemif",        &aemif_clk)'
> remains, as it is currently used (davinci_nand is getting a named clock
> "aemif").

So the existing look-up does not recognize the AEMIF as a device (NULL
device name) and is using a "global" consumer id to look-up
"device-less" clocks. As you noted, this entry should remain for non-DT
mode and for backward compatibility.

> This change will allow to switch from the mach-davinci aemif code to
> the ti-aemif memory driver.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>

Thanks,
Sekhar
