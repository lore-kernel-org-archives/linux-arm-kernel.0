From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 13 Mar 2018 23:23:38 +0200
Subject: [PATCH v2] staging: bcm2835-audio: Release resources on
 module_exit()
In-Reply-To: <20180313193414.11535-1-k.marinushkin@gmail.com>
References: <63ee611d-9fd7-a67a-45aa-229cc4a83ed2@gmail.com>
 <20180313193414.11535-1-k.marinushkin@gmail.com>
Message-ID: <CAHp75Ve9MRAgSu74Mzr2defd84umyeKpfvX51-Qhk4SvLx3Qng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 9:34 PM, Kirill Marinushkin
<k.marinushkin@gmail.com> wrote:
> In the current implementation, `rmmod snd_bcm2835` does not release
> resources properly. It causes an oops when trying to list sound devices.
>
> This commit fixes it.

Nice catch!

See my comments below.

>  static void snd_devm_unregister_child(struct device *dev, void *res)
>  {
>         struct device *childdev = *(struct device **)res;
> +       struct bcm2835_chip *chip = dev_get_drvdata(childdev);
> +       struct snd_card *card = chip->card;
> +
> +       snd_card_free(card);

> +       dev_set_drvdata(childdev, NULL);

AFAIU this is done by device core.

>         device_unregister(childdev);
>  }

> +static void snd_devm_release(struct device *dev)
> +{
> +       struct bcm2835_chip *chip = dev_get_drvdata(dev);
> +
> +       kfree(chip);
> +}


>  /* chip-specific constructor
> @@ -122,7 +136,7 @@ static int snd_bcm2835_create(struct snd_card *card,
>
>         err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
>         if (err) {
> -               snd_bcm2835_free(chip);
> +               kfree(chip);

Do you call device_register() inside snd_device_new()?
In this case you might need put_device() here instead of simple kfree().

>                 return err;
>         }

-- 
With Best Regards,
Andy Shevchenko
