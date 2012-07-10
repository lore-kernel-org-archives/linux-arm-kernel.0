From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 10 Jul 2012 12:18:24 +0530
Subject: [PATCH v1 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
In-Reply-To: <D958900912E20642BCBC71664EFECE3E6DDAD9FF96@BGMAIL02.nvidia.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
 <1340884267-28908-2-git-send-email-kishon@ti.com>
 <4FFBC1D0.5030506@ti.com>
 <D958900912E20642BCBC71664EFECE3E6DDAD9FF96@BGMAIL02.nvidia.com>
Message-ID: <CAAe_U6Kx8o6sHgpev3UEAou7tuNDt9iL0+hcyOVDb0WsCsSwKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 10, 2012 at 11:33 AM, Venu Byravarasu
<vbyravarasu@nvidia.com> wrote:
>> > +
>> > +#ifdef CONFIG_PM
>
> Should it not be CONFIG_PM_SLEEP instead of just CONFIG_PM?

Why? I think we should have CONFIG_PM_SLEEP only when we have
*suspend*, *resume* hooks. But this driver has only *runtime_suspend*
and *runtime_resume* hooks.
>
>> > +
>> > +static int omap_usb2_runtime_suspend(struct device *dev)
>> > +{
>> > +   struct platform_device  *pdev = to_platform_device(dev);
>> > +   struct omap_usb *phy = platform_get_drvdata(pdev);
>> > +
>
>
>> > +static int __init usb2_omap_init(void)
>> > +{
>> > +   return platform_driver_register(&omap_usb2_driver);
>> > +}
>> > +arch_initcall(usb2_omap_init);
>> > +
>> > +static void __exit usb2_omap_exit(void)
>> > +{
>> > +   platform_driver_unregister(&omap_usb2_driver);
>> > +}
>> > +module_exit(usb2_omap_exit);
>> > +
>
> Do you really need arch_initcall here?
> If not, then you can replace above two function calls with module_platform_driver().

I indeed want it to be arch_initcall. When the module is built-in, I
want this module to loaded before twl6030-usb.c

Thanks
Kishon
