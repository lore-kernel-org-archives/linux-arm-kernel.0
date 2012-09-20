From: ola.o.lilja@stericsson.com (Ola Lilja)
Date: Thu, 20 Sep 2012 11:03:34 +0200
Subject: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP
 probe rather than as a device
In-Reply-To: <20120919133343.GH25694@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
Message-ID: <505ADBE6.6080509@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Ola,

> 
> As requested:
> 
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Tue Jul 31 14:06:19 2012 +0100
> 
>     ASoC: Ux500: Initialise PCM from MSP probe rather than as a device
>     
>     The PCM is a pseudo-device. It doesn't have any of it's own registers
>     or hardware. It rather acts as a layer of abstraction for DMA
>     transfers. Hence, instead of classifying it as a device in its own
>     right, we call the initialisation from the MSP driver.
>     
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
> index 31c4d26..9707f4a 100644
> --- a/sound/soc/ux500/mop500.c
> +++ b/sound/soc/ux500/mop500.c
> @@ -32,7 +32,7 @@ struct snd_soc_dai_link mop500_dai_links[] = {
>  		.stream_name = "ab8500_0",
>  		.cpu_dai_name = "ux500-msp-i2s.1",
>  		.codec_dai_name = "ab8500-codec-dai.0",
> -		.platform_name = "ux500-pcm.0",
> +		.platform_name = "ux500-msp-i2s.1",
>  		.codec_name = "ab8500-codec.0",
>  		.init = mop500_ab8500_machine_init,
>  		.ops = mop500_ab8500_ops,
> @@ -42,7 +42,7 @@ struct snd_soc_dai_link mop500_dai_links[] = {
>  		.stream_name = "ab8500_1",
>  		.cpu_dai_name = "ux500-msp-i2s.3",
>  		.codec_dai_name = "ab8500-codec-dai.1",
> -		.platform_name = "ux500-pcm.0",
> +		.platform_name = "ux500-msp-i2s.3",
>  		.codec_name = "ab8500-codec.0",
>  		.init = NULL,
>  		.ops = mop500_ab8500_ops,
> diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c

>
> Lee Jones - Sept. 19, 2012, 12:29 p.m.
> On Thu, Aug 23, 2012 at 01:59:04PM +0100, Mark Brown wrote:
> > On Thu, Aug 23, 2012 at 01:20:03PM +0100, Lee Jones wrote:
> > > > I say I don't understand the motivation for this change.  All the modern
> > > > DT bindings are perfectly happy handling this without an explicit shim
> > > > in the device tree to bodge things for Linux, adding them in seems like
> > > > it'd be a retrograde step.  What benefit do you believe this brings?
> >
> > > How do the all the other DT:ed audio drivers handle the PCM then? More
> > > importantly, how would you like to see it handled? Ola has NACKed this
> > > patch and explained why:
> >
> > They instantiate the PCM driver dynamically from the DAI when it's
> > probed which is pretty much what you're patch is doing.
>
> Can we have some closure on this patch please, as it's blocking the
> patch-set? I'm fairly sure the patch is doing the correct thing, as
> seconded by Mark.

I still don't like this. It is the dai_link-struct that bothers me. We have
"ux500-msp-i2s.1" as name of the platform AND the cpu_dai. The MSP I2S-block is
not the platform and it is certainly not both platform and cpu-DAI at the same time.
Mark: Did you have a solution for this? Couldn't we just put NULL on the
platform_name instead?
