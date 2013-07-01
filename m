From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 16:14:14 -0300
Subject: [alsa-devel] [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
In-Reply-To: <201307011943.27489.marex@denx.de>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <20130701153327.GX13206@S2101-09.ap.freescale.net>
 <CAOMZO5B5jh1XciO4K1u3yBcHHDAgi8hA3GcywnJd11M7=aOPxA@mail.gmail.com>
 <201307011943.27489.marex@denx.de>
Message-ID: <CAOMZO5DtgahX3WLdM-P9=ODhJVMTRHFuS9=6zHQiS9-3wCJcmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jul 1, 2013 at 2:43 PM, Marek Vasut <marex@denx.de> wrote:

> I think you can just disable the PIO mode altogether (around line 500 ... if
> (msg->len < 8) ... replace this with if (0) ) and then the problem should not be
> there (if it's a PIO problem).

Yes, this is a good suggestion.

This is what I did on 3.10 kernel:

- Booted a 3.10 kernel, audio is probed correctly

- Enabled touchscreen:

--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -181,6 +181,7 @@

                        lradc at 80050000 {
                                status = "okay";
+                               fsl,lradc-touchscreen-wires = <4>;
                        };


Then audio fails to probe:

[    3.854263] sgtl5000 0-000a: Device with ID register 0 is not a sgtl5000
[    5.875286] sgtl5000 0-000a: ASoC: failed to probe CODEC -19
[    5.881522] mxs-sgtl5000 sound.12: ASoC: failed to instantiate card -19
[    5.891010] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-19)

- Removed PIO from i2c, then audio probes again

--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -494,7 +494,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter
*adap, struct i2c_msg *msg,
         * based on this empirical measurement and a lot of previous frobbing.
         */
        i2c->cmd_err = 0;
-       if (msg->len < 8) {
+       if (0) {
                ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
                if (ret)
                        mxs_i2c_reset(i2c);

Really don't know why enabling the touchscreen triggers the i2c error
during the codec reading though.
