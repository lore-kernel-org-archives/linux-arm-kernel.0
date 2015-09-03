From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 3 Sep 2015 15:35:04 +0200
Subject: [PATCH v2 5/7] staging: board: Add support for devices with
 complex dependencies
In-Reply-To: <CAPDyKFqouMeTKuXyyohH-VDmWXH+TiLNDT-7MKFa_-TqeF2WSw@mail.gmail.com>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
 <1434530336-15073-6-git-send-email-geert+renesas@glider.be>
 <CAPDyKFqouMeTKuXyyohH-VDmWXH+TiLNDT-7MKFa_-TqeF2WSw@mail.gmail.com>
Message-ID: <CAMuHMdUiH+WZnPtnM-HNs-SpZ8ZxULiKeAiTC1ONTJoP3YMXKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, Sep 3, 2015 at 2:53 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 17 June 2015 at 10:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> Add support for easy registering of one ore more platform devices that
>> may:
>>   - need clocks that are described in DT,
>>   - be part of a PM Domain.

>> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
>> index 8712f566b31196e0..29d456e29f38feac 100644
>> --- a/drivers/staging/board/board.c
>> +++ b/drivers/staging/board/board.c

>> +int __init board_staging_register_device(const struct board_staging_dev *dev)
>> +{
>> +       struct platform_device *pdev = dev->pdev;
>> +       unsigned int i;
>> +       int error;
>> +
>> +       pr_debug("Trying to register device %s\n", pdev->name);
>> +       if (board_staging_dt_node_available(pdev->resource,
>> +                                           pdev->num_resources)) {
>> +               pr_warn("Skipping %s, already in DT\n", pdev->name);
>> +               return -EEXIST;
>> +       }
>> +
>> +       board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
>> +
>> +       for (i = 0; i < dev->nclocks; i++)
>> +               board_staging_register_clock(&dev->clocks[i]);
>> +
>> +       error = platform_device_register(pdev);
>> +       if (error) {
>> +               pr_err("Failed to register device %s (%d)\n", pdev->name,
>> +                      error);
>> +               return error;
>> +       }
>> +
>> +       if (dev->domain)
>> +               __pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
>
> Urgh, this managed to slip through my filters.
>
> It seems like we almost managed to remove all users of the
> "..._name_add..." APIs for genpd. If hasn't been for $subject patch.
> :-)
>
> Now, I realize this is already too late here, but let's try to fix
> this before it turns into a bigger issue.
>
> Geert, do you think it's possible to convert into using the non-named
> bases APIs?

That will be difficult. This code is meant to use drivers that are not yet
DT-aware on DT-based systems. Hence it uses platform devices with named PM
domains, while the PM domains are described in DT.
I don't think there's another way to look up a PM domain by name, is there?

This code is meant to go away, once all drivers are converted to DT, or
considered obsolete.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
