From: dansharon@nanometrics.ca (Dan Sharon)
Date: Tue, 18 Jan 2011 14:02:21 -0500
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
Message-ID: <AANLkTi=X3KRngiNz5iQzojh_-h4W-iRDsbq8Hvy6Lm1x@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches apply cleanly to 'v2.6.37'
3c0eee3fe6a3a1c745379547c7e7c904aa64f6d5
of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git.

The kernel was built with the 'da8xx_omapl_defconfig' from the omap-l1tree,
and 'make menuconfig' to enable ASoC (the defconfig already has
CONFIG_REGULATOR=y, CONFIG_REGULATOR_DUMMY=y, and
CONFIG_REGULATOR_TPS6507X=y).

Testing was done on a da850evm by tftp'ing the kernel into ram, and using
the
SPI-flash-based rootfs from the PSP that shipped with the board.

Using 'arecord -r 48000 -c 2 -f S32_BE -t raw -v -d 1 > /tmp/arecord.cap'
produced
a file of 384000 bytes (48000 x 2 x 4 bytes/sample).
'arecord -r 48000 -c 2 -f S32_BE -t raw -v > /dev/null' ran flawlessly for
several hours.

I was not able to reproduce Sudhakar's problems with 'arecord -f dat | aplay
-f dat'.

Tested-by: Dan Sharon <dansharon at nanometrics.ca <bengardiner@nanometrics.ca>
>

Regards,
Dan Sharon


On Mon, Jan 17, 2011 at 11:43 PM, Rajashekhara, Sudhakar <
sudhakar.raj@ti.com> wrote:

> Resending with proper $SUBJECT...
>
> Hi,
>
> I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
> at [1] and found that audio is broken. Below patch fixes the issue.
>
> ---
> From: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
>
> davinci: fixes for audio on da850/omap-l138/am18x
>
> On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
> But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
> has the wrong AIC3x codec slave address. This patch fixes this issue.
>
> Also, this patch registers the platform device for davinci-pcm-audio.
>
> Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
> ---
>  arch/arm/mach-davinci/devices-da8xx.c |   12 ++++++++++++
>  sound/soc/davinci/davinci-evm.c       |    2 +-
>  2 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c
> b/arch/arm/mach-davinci/devices-da8xx.c
> index 9eec630..17c0dbc 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -473,6 +473,11 @@ static struct resource da850_mcasp_resources[] = {
>        },
>  };
>
> +struct platform_device davinci_pcm_device = {
> +       .name   = "davinci-pcm-audio",
> +       .id     = -1,
> +};
> +
>  static struct platform_device da850_mcasp_device = {
>        .name           = "davinci-mcasp",
>        .id             = 0,
> @@ -480,8 +485,15 @@ static struct platform_device da850_mcasp_device = {
>        .resource       = da850_mcasp_resources,
>  };
>
> +static void davinci_init_pcm(void)
> +{
> +       platform_device_register(&davinci_pcm_device);
> +}
> +
>  void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
>  {
> +       davinci_init_pcm();
> +
>        /* DA830/OMAP-L137 has 3 instances of McASP */
>        if (cpu_is_davinci_da830() && id == 1) {
>                da830_mcasp1_device.dev.platform_data = pdata;
> diff --git a/sound/soc/davinci/davinci-evm.c
> b/sound/soc/davinci/davinci-evm.c
> index bc9e6b0..07db881 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -224,7 +224,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
>        .stream_name = "AIC3X",
>        .cpu_dai_name= "davinci-mcasp.0",
>        .codec_dai_name = "tlv320aic3x-hifi",
> -       .codec_name = "tlv320aic3x-codec.0-001a",
> +       .codec_name = "tlv320aic3x-codec.1-0018",
>        .platform_name = "davinci-pcm-audio",
>        .init = evm_aic3x_init,
>        .ops = &evm_ops,
> ---
>
> Also, I found that either CONFIG_REGULATOR should not be defined or if
> CONFIG_REGULATOR is defined then CONFIG_REGULATOR_DUMMY should also be
> defined. Without this menuconfig fix, Soundcard does not get detected.
>
> With the above fixes, arecord and aplay does not work for the first time.
> Couple of times I get the below error:
>
> root at da850-omapl138-evm:~# arecord -f dat | aplay -f dat
> arecord: main:608: audio open error: Invalid argument
> aplay: playback:2297: read error
> root at da850-omapl138-evm:~# arecord -f dat | aplay -f dat
> aplay: main:608: audio open error: Invalid argument
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
>
> Third time arecord and aplay work normally.
>
> Has anyone seen such issues on DA850 or any other platform?
>
> I am currently debugging this issue. I'll submit the above patch to
> community
> once the issue of fixed.
>
> [1]
> http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary
>
> Regards,
> Sudhakar
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110118/b0eb32dc/attachment-0001.html>
