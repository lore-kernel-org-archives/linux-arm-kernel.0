From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 5 Mar 2012 12:09:13 -0600
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305174232.GA3852@pengutronix.de>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305174232.GA3852@pengutronix.de>
Message-ID: <CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is in the BSP but the BSP driver is trying to be way too fancy
with I2S settings on the imx-ssi driver you wrote (it works well for
AC97, but for SSI in I2S slave mode there are so many hacks upon hacks
"they" have presented, it'd never mainline)

Having the codec provide clocks in slave mode works great in fsl-ssi
because it doesn't set the chip up any other way, but I've had serious
problems here whereby playing back a 48khz, 16-bit audio stream and
recording in ANYTHING else seems to make the playback stream slow
motion, but I can't trace whether it's the SSI config (seems unlikely
as the only valid STXCCR bit in slave mode is the word length) or the
codec config. In theory the playback and capture should be serialized
by the driver, though, right? It wouldn't be possible to be a slave to
the codec if it had to run the clock two different rates at the same
time.. app1 sends a sample buffer, codec does dma, app2 requests
capture buffer, codec does dma, they can't happen at the same time,
maybe we are missing an important mutex or spinlock here that would
enforce this and stop the configuration changing mid-stream.. I'm far
from the ALSA expert though)

If adding capture support means having to make the SSI driver work in
I2S master mode and do the laborious work of actually dividing the SSI
clock, configuring the external PLL etc. so it can clock the codec
appropriately for this mode then that's what will have to be done, and
I agree with Sascha, whatever the solution it should be something that
gets done now (not least because I kind of want audio here.. :) along
with quite possibly adapting the current imx-ssi driver (as opposed to
the fsl-ssi driver) to be fsl-ssi-ac97 vs fsl-ssi-imx so we have
dedicated operation (which will make the AC97/FIQ select much easier
to determine).

While we're at it; did anyone patch arch/arm/mach-imx/ssi-fiq.S to be
compiled in .arm mode yet? I can't find it in a tree or the list but I
could be wrong. I am sure we mutually agreed (or at least Russell
decided) on this to get thumb kernels to build again since none of the
dependent processors/config selections are M-profile?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Mon, Mar 5, 2012 at 11:42 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:
>> This is the initial imx-sgtl5000 machine driver support with only
>> playback dai link implemented. ?More features can be added on top
>> of it later.
>
> Are there problems with capturing? It should be trivial to add and
> it would be much more confident that this series as a whole works as
> expected.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
