From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 26 Nov 2013 12:32:23 +0100
Subject: [PATCH 1/2] ASoC: atmel: sam9x5_wm8731: fix oops when unload
 module
In-Reply-To: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
References: <1385439472-23352-1-git-send-email-voice.shen@atmel.com>
Message-ID: <CACQ1gAh3W3vyTpFv8CkbO8hFJtU_SDjVuh2pRSFWCbUZPmidsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/26 Bo Shen <voice.shen@atmel.com>:
> As the priv is not assigned to card->drvdata, it is NULL, so when
> unload module, it will cause NULL pointer oops.
> Assign priv to card->drvdata to fix this issue.
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  sound/soc/atmel/sam9x5_wm8731.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/atmel/sam9x5_wm8731.c b/sound/soc/atmel/sam9x5_wm8731.c
> index 992ae38..6dc33ac 100644
> --- a/sound/soc/atmel/sam9x5_wm8731.c
> +++ b/sound/soc/atmel/sam9x5_wm8731.c
> @@ -99,6 +99,7 @@ static int sam9x5_wm8731_driver_probe(struct platform_device *pdev)
>
>         card->dev = &pdev->dev;
>         card->owner = THIS_MODULE;
> +       card->drvdata = priv;
>         card->dai_link = dai;
>         card->num_links = 1;
>         card->dapm_widgets = sam9x5_dapm_widgets;
> --
> 1.7.9.5
>
There's no oops any more !

Tested-by: Richard Genoud <richard.genoud@gmail.com>

This should also go in -stable don't you think ?

Maybe it's a bug on my kernel, but did you try to reload the module
and play something ?
On my board once I unload/reload it, there's no sound comming out
(at least, it's better than a oops ! :) )

Richard.
