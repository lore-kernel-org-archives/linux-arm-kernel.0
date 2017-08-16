From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 16 Aug 2017 16:50:58 -0700
Subject: [PATCH v2 1/3] ASoC: rockchip: Parse dai links from dts
In-Reply-To: <5994CD58.7030406@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com>
 <20170816215909.GC109008@google.com>
 <5994CD58.7030406@rock-chips.com>
Message-ID: <20170816235058.GA173745@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Aug 17, 2017 at 06:55:20AM +0800 jeffy ha dit:

> hi matthias,
> 
> thanks for your suggestion.
> 
> On 08/17/2017 05:59 AM, Matthias Kaehlcke wrote:
> >El Thu, Aug 10, 2017 at 12:54:56PM +0800 Jeffy Chen ha dit:
> >
> >>>Refactor rockchip_sound_probe, parse dai links from dts instead of
> >>>hard coding them.
> >Mark doesn't seem to be overly convinced that 'rockchip,codec-names'
> >is a good idea (https://lkml.org/lkml/2017/8/10/511).
> >
> >How about using something like this instead:
> >
> >static const char *dailink_compat[] = {
> >	[DAILINK_MAX98357A] = "maxim,max98357a",
> >	[DAILINK_RT5514] = "realtek,rt5514",
> >	[DAILINK_DA7219] = "dlg,da7219",
> >};
> i've thought about this too, but i'm working on converting rt5514
> dsp(spi) from codec name matching to of_node, and it would have the
> same compatible with rt5514(i2c)

Bummer!

I wonder if a relatively inoffensive DT hack would be an appropriate
solution in this case, since the conflicting compatible string is a
somewhat special case and this change only affects the DT and the
driver/glue of a specific device (family).

The hack would consist in adding an additional 'compatible' entry to
the DT entry of the codec, which is ignored by the rt5514 driver, and
only used by the sound glue to identify it:

--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -671,7 +671,7 @@ ap_i2c_mic: &i2c1 {
        i2c-scl-rising-time-ns = <300>;
 
        headsetcodec: rt5514 at 57 {
-               compatible = "realtek,rt5514";
+               compatible = "realtek,rt5514", "realtek,rt5514-i2c";


And then use "realtek,rt5514-i2c" in dailink_compat.

Mark, would you prefer a hack like this over the list of codec names
or do you have any other suggestions?

Matthias
