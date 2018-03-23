From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 23 Mar 2018 18:23:54 +0200
Subject: [PATCH v4] staging: bcm2835-audio: Release resources on
 module_exit()
In-Reply-To: <20180322213722.31822-1-k.marinushkin@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
 <20180322213722.31822-1-k.marinushkin@gmail.com>
Message-ID: <CAHp75VdYiySBzu99MYoBAZ8tORGP1R43z9d+=VRdktg+U=_ZDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2018 at 11:37 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:


> +static void snd_devm_release(struct device *dev)
> +{
> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
> +
> +       kfree(chip);
> +}

> +       device->release = snd_devm_release;

This is not devm function, so, it would be rather called
snd_bcm2835_release().

>  static struct snd_card *snd_devm_card_new(struct device *dev)
>  {
>         struct snd_card *card;
>         int ret;
>
>         ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
> +       if (ret)
>                 return ERR_PTR(ret);
>
>         return card;
>  }

Same here. You removed anything related to devm here, so, please make
function name consistent.

After addressing above, FWIW,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
