From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 May 2014 18:33:05 -0300
Subject: [alsa-devel] The resume of sgtl5000 causes kernel Oops
In-Reply-To: <20140522174818.GN12304@sirena.org.uk>
References: <20140522145650.GD32184@dragon>
 <20140522174818.GN12304@sirena.org.uk>
Message-ID: <CAOMZO5CCFnZSz_jaipe4Fz0sTxXOajp7QRPiaM5f5wg_Di0ftA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, May 22, 2014 at 2:48 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 22, 2014 at 10:56:51PM +0800, Shawn Guo wrote:
>> The suspend/resume test on imx51-babbage board discovers a kernel Oops
>> caused by sgtl5000_resume().  I believe it happens due to commit
>> e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly).  After
>> the commit, it seems that the codec->reg_cache in function
>> sgtl5000_restore_regs() becomes invalid.  It looks that the register
>> restoring in the function requires some strict sequence, I'm not sure
>> what the correct fix is.
>
> Yes, reg_cache isn't there if we're not using ASoC level caching.  The
> fix should just be to replace the direct cache references with
> snd_soc_read()s which will end up in a cache lookup if the register is
> cached.

Do you mean like this?

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 9626ee0..437751a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1075,7 +1075,6 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec)
  */
 static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
 {
-    u16 *cache = codec->reg_cache;
     u16 reg;

     /* restore regular registers */
@@ -1089,12 +1088,12 @@ static int sgtl5000_restore_regs(struct
snd_soc_codec *codec)
             reg == SGTL5000_CHIP_REF_CTRL)
             continue;

-        snd_soc_write(codec, reg, cache[reg]);
+        snd_soc_write(codec, reg, snd_soc_read(codec, reg));
     }

     /* restore dap registers */
     for (reg = SGTL5000_DAP_REG_OFFSET; reg <
SGTL5000_MAX_REG_OFFSET; reg += 2)
-        snd_soc_write(codec, reg, cache[reg]);
+        snd_soc_write(codec, reg, snd_soc_read(codec, reg));

     /*
      * restore these regs according to the power setting sequence in
@@ -1110,19 +1109,19 @@ static int sgtl5000_restore_regs(struct
snd_soc_codec *codec)
      *    prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
      */
     snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
-            cache[SGTL5000_CHIP_LINREG_CTRL]);
+            snd_soc_read(codec, SGTL5000_CHIP_LINREG_CTRL));

     snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
-            cache[SGTL5000_CHIP_ANA_POWER]);
+            snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER));

     snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
-            cache[SGTL5000_CHIP_CLK_CTRL]);
+            snd_soc_read(codec, SGTL5000_CHIP_CLK_CTRL));

     snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
-            cache[SGTL5000_CHIP_REF_CTRL]);
+            snd_soc_read(codec, SGTL5000_CHIP_REF_CTRL));

     snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
-            cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
+            snd_soc_read(codec, SGTL5000_CHIP_LINE_OUT_CTRL));
     return 0;
 }

This avoids the crash in suspend, but I get different errors now:

root@freescale /$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
random: nonblocking pool is initialized
PM: suspend of devices complete after 15.210 msecs
PM: suspend devices took 0.010 seconds
PM: late suspend of devices complete after 4.435 msecs
PM: noirq suspend of devices complete after 4.691 msecs
Disabling non-boot CPUs ...
PM: noirq resume of devices complete after 3.931 msecs
PM: early resume of devices complete after 5.724 msecs
sgtl5000 1-000a: Failed to restore cache: -5
sgtl5000 1-000a: Failed to restore cache: -5
sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
sgtl5000 1-000a: Failed to restore cache: -5
sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
sgtl5000 1-000a: Failed to restore cache: -5
sgtl5000 1-000a: ASoC: Failed to turn on bias: -5
PM: resume of devices complete after 62.349 msecs
PM: resume devices took 0.060 seconds
Restarting tasks ... done.
