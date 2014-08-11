From: cmetcalf@tilera.com (Chris Metcalf)
Date: Mon, 11 Aug 2014 02:38:43 +0000
Subject: [PATCH 2/5] char: tile-srom: Remove reference to platform_bus
In-Reply-To: <1407515691.31897.26.camel@hornet>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
 <1406298233-27876-2-git-send-email-pawel.moll@arm.com>
 <53DAA605.2030500@tilera.com> <1406913678.22529.46.camel@hornet>
 <53E139C8.9000502@tilera.com>,<1407515691.31897.26.camel@hornet>
Message-ID: <16873F3E-2114-41B6-A2F1-EF87D4DA01D2@tilera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the code and comments. I'm out on vacation till mid next week but I'll look at this when I get back.
Chris

> On Aug 8, 2014, at 12:35 PM, "Pawel Moll" <pawel.moll@arm.com> wrote:
> 
> On Tue, 2014-08-05 at 21:08 +0100, Chris Metcalf wrote:
>>>> In addition, we also have user binaries
>>>> in the wild that know to look for /sys/devices/platform/srom/ paths,
>>>> so I'm pretty reluctant to change this path without good reason.
>>> So what is the srom class for then if not for device discovery? And why
>>> do they look for them in the first place? To get relevant character
>>> device's data, if I understand it right?
>>> 
>>> Maybe you could just register a simple "proper" platform device for all
>>> the sroms and then hang the class devices from it? I can type some code
>>> doing this if it sound reasonably?
>> 
>> I'm not sure exactly what you mean by device discovery here.  
> 
> 
> 
>> The
>> subdirectories under /sys/devices/platform/srom/ correspond to partitions
>> in the SPI-ROM, which are software constructs created by the Tilera hypervisor.
>> By default we have three, where the first holds boot data that the chip
>> can use to boot out of hardware, and the other two are smaller partitions
>> for boot- and user-specific data.  We use the /sys files primarily to get the
>> page size and sector size for the sroms, and also export other interesting
>> information like the total size of the particular srom device.
>> 
>> Thank you for volunteering to write a bit of code; if that's the best
>> way to clarify this for us, fantastic, or else pointing us at existing
>> good practices or documentation would be great too.
> 
> I was thinking about something like the following (warning, untested)
> 
> 8<-------------------------------------------
> From c53f0a2492d6cd38d1f82d57916a6528b071e8a8 Mon Sep 17 00:00:00 2001
> From: Pawel Moll <pawel.moll@arm.com>
> Date: Fri, 8 Aug 2014 16:32:58 +0100
> Subject: [PATCH] char: tile-srom: Add real platform bus parent
> 
> Add a real platform bus device as a parent for
> the srom class devices, to prevent non-platform
> devices hanging from the bus root.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> drivers/char/tile-srom.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tile-srom.c b/drivers/char/tile-srom.c
> index bd37747..7fb0fd5 100644
> --- a/drivers/char/tile-srom.c
> +++ b/drivers/char/tile-srom.c
> @@ -76,6 +76,7 @@ MODULE_LICENSE("GPL");
> 
> static int srom_devs;            /* Number of SROM partitions */
> static struct cdev srom_cdev;
> +static struct platform_device *srom_parent;
> static struct class *srom_class;
> static struct srom_dev *srom_devices;
> 
> @@ -350,7 +351,7 @@ static int srom_setup_minor(struct srom_dev *srom, int index)
>               SROM_PAGE_SIZE_OFF, sizeof(srom->page_size)) < 0)
>        return -EIO;
> 
> -    dev = device_create(srom_class, &platform_bus,
> +    dev = device_create(srom_class, srom_parent,
>                MKDEV(srom_major, index), srom, "%d", index);
>    return PTR_ERR_OR_ZERO(dev);
> }
> @@ -415,6 +416,13 @@ static int srom_init(void)
>    if (result < 0)
>        goto fail_chrdev;
> 
> +    /* Create a parent device */
> +    srom_parent = platform_device_register_simple("srom", -1, NULL, 0);
> +    if (IS_ERR(srom_parent)) {
> +        result = PTR_ERR(srom_parent);
> +        goto fail_pdev;
> +    }
> +
>    /* Create a sysfs class. */
>    srom_class = class_create(THIS_MODULE, "srom");
>    if (IS_ERR(srom_class)) {
> @@ -438,6 +446,8 @@ fail_class:
>        device_destroy(srom_class, MKDEV(srom_major, i));
>    class_destroy(srom_class);
> fail_cdev:
> +    platform_device_unregister(srom_parent);
> +fail_pdev:
>    cdev_del(&srom_cdev);
> fail_chrdev:
>    unregister_chrdev_region(dev, srom_devs);
> @@ -454,6 +464,7 @@ static void srom_cleanup(void)
>        device_destroy(srom_class, MKDEV(srom_major, i));
>    class_destroy(srom_class);
>    cdev_del(&srom_cdev);
> +    platform_device_unregister(srom_parent);
>    unregister_chrdev_region(MKDEV(srom_major, 0), srom_devs);
>    kfree(srom_devices);
> }
> -- 
> 1.9.1
> 8<-------------------------------------------
> 
> Would that work for you? Note that it will move the srom class devices
> one level deeper in /sys/devices/... hierarchy.
> 
> Pawe?
> 
