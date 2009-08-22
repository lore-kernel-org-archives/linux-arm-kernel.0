From: manuel.lauss@googlemail.com (Manuel Lauss)
Date: Sat, 22 Aug 2009 10:16:38 +0200
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <200908220713.20637.elendil@planet.nl>
References: <200908220223.50588.marek.vasut@gmail.com>
	<200908220713.20637.elendil@planet.nl>
Message-ID: <f861ec6f0908220116x1322b65cs79695f54b97d8381@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sat, Aug 22, 2009 at 7:13 AM, Frans Pop<elendil@planet.nl> wrote:
> Marek Vasut wrote:
>> +static struct dev_pm_ops cm710_mmc_pm_ops = {
>> + ? ? ? .suspend = cb710_mmc_suspend,
>> + ? ? ? .resume = cb710_mmc_resume,
>> +};
>
> This is almost certainly wrong (same for the other drivers you converted)
> as they now no longer support hibernation, which requires different ops.
> Please see: http://lkml.org/lkml/2009/7/25/118.
>
> You also seem to have handled the #ifndef CONFIG_PM case incorrectly.
> See http://lkml.org/lkml/2009/8/3/253 for an example how it can be done.

In addition to what Frans said, at least for platform drivers you could
avoid adding (mostly) unused platform_device temp vars like these

+       struct platform_device *pdev = to_platform_device(dev);
        struct au1xmmc_host *host = platform_get_drvdata(pdev);

by simply doing
-        struct au1xmmc_host *host = platform_get_drvdata(pdev);
+        struct au1xmmc_host *host = dev_get_drvdata(dev);

What do you think?

Thanks!
      Manuel Lauss
