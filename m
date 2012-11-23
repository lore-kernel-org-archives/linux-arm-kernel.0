From: padma.kvr@gmail.com (Padma Venkat)
Date: Fri, 23 Nov 2012 17:01:52 +0530
Subject: [RFC PATCH] ASoC: Samsung: Register the audio platform device
In-Reply-To: <1352894960-17434-2-git-send-email-padma.v@samsung.com>
References: <1352894960-17434-1-git-send-email-padma.v@samsung.com>
 <1352894960-17434-2-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-Bct96a_G=7Da6VseTgqzAymPkHsWK8o7OetKG0Khgp0Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc'ing Mark Brown

On Wed, Nov 14, 2012 at 5:39 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> Audio platform device is not a hardware peripherial.
> So this device can't be added in the dt devices list.
> So expanded the module_platform_driver and registered
> this device using "platform_device_register_simple".
>
> Also added the soc-core pm ops structure in the audio
> platform driver.
>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  sound/soc/samsung/smdk_wm8994.c |   31 ++++++++++++++++++++++++++++++-
>  1 files changed, 30 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
> index 48dd4dd..7f97969 100644
> --- a/sound/soc/samsung/smdk_wm8994.c
> +++ b/sound/soc/samsung/smdk_wm8994.c
> @@ -173,16 +173,45 @@ static int __devexit smdk_audio_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static struct platform_device *smdk_audio_device;
> +
>  static struct platform_driver smdk_audio_driver = {
>         .driver         = {
>                 .name   = "smdk-audio",
>                 .owner  = THIS_MODULE,
> +               .pm     = &snd_soc_pm_ops,
>         },
>         .probe          = smdk_audio_probe,
>         .remove         = __devexit_p(smdk_audio_remove),
>  };
>
> -module_platform_driver(smdk_audio_driver);
> +static int __init smdk_audio_init(void)
> +{
> +       int ret;
> +
> +       ret = platform_driver_register(&smdk_audio_driver);
> +       if (ret) {
> +               pr_err("unable to register driver\n");
> +               return ret;
> +       }
> +
> +       smdk_audio_device = platform_device_register_simple("smdk-audio", -1, NULL, 0);
> +       if (IS_ERR(smdk_audio_device)) {
> +               platform_driver_unregister(&smdk_audio_driver);
> +               return PTR_ERR(smdk_audio_device);
> +       }
> +
> +       return 0;
> +}
> +
> +static void __exit smdk_audio_exit(void)
> +{
> +       platform_device_unregister(smdk_audio_device);
> +       platform_driver_unregister(&smdk_audio_driver);
> +}
> +
> +module_init(smdk_audio_init);
> +module_exit(smdk_audio_exit);
>
>  MODULE_DESCRIPTION("ALSA SoC SMDK WM8994");
>  MODULE_LICENSE("GPL");
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
