From: carlo@caione.org (Carlo Caione)
Date: Sun, 12 Oct 2014 18:10:41 +0200
Subject: [PATCH 1/3] ARM: meson: reset: Add reset controller for MesonX
 SoCs
In-Reply-To: <20141012160339.GA16293@gmail.com>
References: <1413125679-24443-1-git-send-email-carlo@caione.org>
 <1413125679-24443-2-git-send-email-carlo@caione.org>
 <20141012160339.GA16293@gmail.com>
Message-ID: <CAOQ7t2b=94dzC4WS8A3eQhZvwfBgri_QtjHgE9Wr7x71EGx=JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 12, 2014 at 6:03 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> Hi Carlo,

Hi Beniamino,

>> [...]
>> +
>> +static int meson_reset_probe(struct platform_device *pdev)
>> +{
>> +     struct meson_reset_data *data;
>> +     struct resource *res;
>> +
>> +     /*
>> +      * The binding was mainlined without the required property.
>> +      * Do not continue, when we encounter an old DT.
>> +      */
>> +     if (!of_find_property(pdev->dev.of_node, "#reset-cells", NULL)) {
>> +             dev_err(&pdev->dev, "%s missing #reset-cells property\n",
>> +                     pdev->dev.of_node->full_name);
>> +             return -EINVAL;
>> +     }
>
> Probably the above comment was taken from another driver but is not
> relevant here.

Right. Lazy copy and paste with brain off

>> +
>> +static int meson_reset_remove(struct platform_device *pdev)
>> +{
>> +     struct meson_reset_data *data = platform_get_drvdata(pdev);
>
> Don't you need to call platform_set_drvdata() in the probe() function
> for this to be valid?

Yes. Even though I believe the remove can never happen.

>> +
>> +     reset_controller_unregister(&data->rcdev);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id meson_reset_dt_ids[] = {
>> +     { .compatible = "amlogic,meson6-rst-mgr-ao", },
>> +     { /* sentinel */ },
>> +};
>> +
>> +static struct platform_driver meson_reset_driver = {
>> +     .probe  = meson_reset_probe,
>> +     .remove = meson_reset_remove,
>> +     .driver = {
>> +             .name           = "meson-reset",
>> +             .owner          = THIS_MODULE,
>
> I believe you can drop the owner field.

I will.

Thank you for your review,

-- 
Carlo Caione
