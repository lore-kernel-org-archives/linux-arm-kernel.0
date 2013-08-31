From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 13:17:06 +0100
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <20130831135519.6ab0e163@armhf>
References: <20130828113521.35c53365@armhf> <521DCD80.9010105@gmail.com>
 <20130831125128.0e3a23c7@armhf>
 <20130831112430.GD6617@n2100.arm.linux.org.uk>
 <20130831135519.6ab0e163@armhf>
Message-ID: <20130831121705.GE6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 01:55:19PM +0200, Jean-Francois Moine wrote:
> The last case was "when using the two audio controllers with different
> sample rates" (I should have added "in the set [44.1, 48, 96 kHz]").
> Then, with or without the availability of external clocks, both
> controllers will set the unique DCO to two different rates.

Ah, yes.  The documentation is rather confusing too.  In one part, it
does indeed say that there is only one DCO which is shared between the
two blocks.

However, each block has its own DCO register which allows it to be set
to a different frequency - maybe it accesses the same physical register.

In which case, it probably would be better that we use the external clock
for everything when it is available - Rabeeh's kernel already does that,
as does the kernel which I run on my Cubox.  I'll pull that patch over to
the series for mainline later today:

a402fa7 ASoC: kirkwood: prefer external clock over internal clock

(This is copy'n'pasted with gpm, so is white-space damaged).
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 1c8177b..92cd467 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -222,20 +222,20 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 {
        uint32_t clks_ctrl;

-       if (rate == 44100 || rate == 48000 || rate == 96000) {
-               /* use internal dco for supported rates */
-               dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
-                       __func__, rate);
-               kirkwood_set_dco(priv->io, rate);
-
-               clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
-       } else if (!IS_ERR(priv->extclk)) {
+       if (!IS_ERR(priv->extclk)) {
                /* use optional external clk for other rates */
                dev_dbg(dai->dev, "%s: extclk set rate = %lu -> %lu\n",
                        __func__, rate, 256 * rate);
                clk_set_rate(priv->extclk, 256 * rate);

                clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
+       } else if (rate == 44100 || rate == 48000 || rate == 96000) {
+               /* use internal dco for supported rates */
+               dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
+                       __func__, rate);
+               kirkwood_set_dco(priv->io, rate);
+
+               clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
        }
        writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
 }
