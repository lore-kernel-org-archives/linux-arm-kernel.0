From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 1 Oct 2014 12:06:51 +0530
Subject: 3.17-rc6 on ODROID: ERROR: Bad of_node_put() on
 /ehci@12580000/port@1
In-Reply-To: <CAD8Lp45qyHpHqRnUy4T9Sm8zV4XJBDp=cLYXjtcxmVrS8GSjbg@mail.gmail.com>
References: <CAD8Lp45qyHpHqRnUy4T9Sm8zV4XJBDp=cLYXjtcxmVrS8GSjbg@mail.gmail.com>
Message-ID: <CAFp+6iGwB3XuzSuYPzO=5MacPO2LGFDnh9oS5rAL3Ne26wb9Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,


On Sat, Sep 27, 2014 at 5:54 AM, Daniel Drake <drake@endlessm.com> wrote:
> Hi,

it's always good to keep the relevant mailing list also in CC (linux-usb).
Also added Alan here.

>
> Booting 3.17-rc6 on ODROID-U2, I see this message:
>
> ERROR: Bad of_node_put() on /ehci at 12580000/port at 1
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.17.0-rc6-00376-g85cd8fd #1031
> [<c0016418>] (unwind_backtrace) from [<c0011f00>] (show_stack+0x10/0x14)
> [<c0011f00>] (show_stack) from [<c08213fc>] (dump_stack+0x84/0xc4)
> [<c08213fc>] (dump_stack) from [<c02dacc0>] (kobject_cleanup+0x58/0x6c)
> [<c02dacc0>] (kobject_cleanup) from [<c0608718>]
> (of_get_next_available_child+0x78/0x98)
> [<c0608718>] (of_get_next_available_child) from [<c05673c8>]
> (exynos_ehci_probe+0x254/0x424)
> [<c05673c8>] (exynos_ehci_probe) from [<c03ce700>]
> (platform_drv_probe+0x2c/0x5c)
> [<c03ce700>] (platform_drv_probe) from [<c03ccd00>]
> (driver_probe_device+0xe8/0x234)
> [<c03ccd00>] (driver_probe_device) from [<c03ccef8>] (__driver_attach+0x68/0x8c)
>
> This repeats for all of the ehci and ohci ports.
>
> Haven't had time to dig deeper. Is this a known issue?

I don't think it's a known issue, atleast i don't see it on exynos5250-smdk5250.

One reason i doubt why it could be coming is because we are
specifically putting the
child after doing everything with it.

When we are getting the child node using for_each_available_child_of_node(),
which calls for of_get_next_available_child(). So of_get_next_available_child()
does a of_node_put() on the "prev" node, in case we have siblings to the child.

Can you see if the below change helps ?

------------------------------------------------------------------------------------------------------------
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 7189f2e..1b726bf 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -74,7 +74,6 @@ static int exynos_ehci_get_phy(struct device *dev,

                phy = devm_of_phy_get(dev, child, NULL);
                exynos_ehci->phy[phy_number] = phy;
-               of_node_put(child);
                if (IS_ERR(phy)) {
                        ret = PTR_ERR(phy);
                        if (ret == -EPROBE_DEFER) {
------------------------------------------------------------------------------------------------------------


This is on top of usb-next.
If you are testing on rc6 only, then probably you will have to cherrypick two
patches each for ehci-exynos and ohci-exynos:
usb: host: ehci-exynos: Remove unnecessary usb-phy support
usb: host: ohci-exynos: Remove unnecessary usb-phy support



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
