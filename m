From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 09 Jun 2017 11:13:17 -0700
Subject: [PATCH 1/3] clk: meson: meson8b: add compatibles for Meson8 and
 Meson8m2
In-Reply-To: <1496606325.3552.16.camel@baylibre.com> (Jerome Brunet's message
 of "Sun, 04 Jun 2017 21:58:45 +0200")
References: <20170604183341.21417-1-martin.blumenstingl@googlemail.com>
 <20170604183341.21417-2-martin.blumenstingl@googlemail.com>
 <1496606325.3552.16.camel@baylibre.com>
Message-ID: <m2lgp19ghu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Sun, 2017-06-04 at 20:33 +0200, Martin Blumenstingl wrote:
>> The clock controller on Meson8, Meson8b and Meson8m2 is very similar
>> based on the code from the Amlogic GPL kernel sources. Add separate
>> compatibles for each SoC to make sure that we can easily implement
>> all the small differences for each SoC later on.
>> 
>> In general the Meson8 and Meson8m2 seem to be almost identical as they
>> even share the same mach-meson8 directory in Amlogic's GPL kernel
>> sources.
>> The main clocks on Meson8, Meson8b and Meson8m2 are very similar,
>> because they are all using the same PLL values, 90% of the clock gates
>> are the same (the actual diffstat of the mach-meson8/clock.c and
>> mach-meson8b/clock.c files is around 30 to 40 lines, when excluding
>> all commented out code).
>> The difference between the Meson8 and Meson8b clock gates seem to be:
>> - Meson8 has AIU_PCLK, HDMI_RX, VCLK2_ENCT, VCLK2_ENCL, UART3,
>> ? CSI_DIG_CLKIN gates which don't seem to be available on Meson8b
>> - the gate on Meson8 for bit 7 seems to be named "_1200XXX" instead
>> ? of "PERIPHS_TOP" (on Meson8b)
>> - Meson8b has a SANA gate which doesn't seem to exist on Meson8 (or
>> ? on Meson8 the same bit is used by the UART3 gate in Amlogic's GPL
>> ? kernel sources)
>> None of these gates is added for now, since it's unclear whether these
>> definitions are actually correct (the VCLK2_ENCT gate for example is
>> defined, but only used in some commented block).
>> 
>> The main difference between all three SoCs seem to be the video (VPU)
>> clocks. Apart from different supported clock rates (according to vpu.c
>> in mach-meson8 and mach-meson8b from Amlogic's GPL kernel sources) the
>> most notable difference is that Meson8m2 has a GP_PLL clock and a mux
>> (probably the same as on the Meson GX SoCs) to support glitch-free
>> (clock rate) switching.
>> None of these VPU clocks are not supported by our mainline meson8b
>> clock driver yet though.
>> 
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>> ?.../devicetree/bindings/clock/amlogic,meson8b-clkc.txt????????| 11 +++++++---
>
> I think you should split the binding documentation and clk changes into separate
> patches.
>
>> -
>> ?drivers/clk/meson/Kconfig?????????????????????????????????????|??6 +++---
>> ?drivers/clk/meson/meson8b.c???????????????????????????????????|??5 ++++-
>
> The change being more platform than clock related, I'd prefer if Kevin or Carlo
> ack it before we apply it.

Acked-by: Kevin Hilman <khilman@baylibre.com>
