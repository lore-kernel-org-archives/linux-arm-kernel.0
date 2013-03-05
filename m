From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Mar 2013 13:04:57 +0200
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-2-git-send-email-chao.xie@marvell.com>
 <20130304142143.GG3397@arwen.pp.htv.fi>
 <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
Message-ID: <20130305110457.GF7899@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 05, 2013 at 10:03:01AM +0800, Chao Xie wrote:
> >> +enum mv_usb2_phy_type {
> >> +     PXA168_USB,
> >> +     PXA910_USB,
> >> +     MMP2_USB,
> >> +};
> >
> >
> > ewww... you really don't need (and *shouldn't* use) u2o_set() or
> > u2o_clear(). They clearly prevent compiler from optimizing variable
> > usage and could cause pressure on your interconnect. By writing and
> > reading multiple times for no reason.
> >
> 
> The APIs defined here is for device operation. The device register
> read/write is not same as memory.
> When a silicon comes, it may not be stable, and will have done some
> workaround epecially for the device register read/write. to define the
> APIs for the register read/write will help to implement the workaround
> without changing phy init code every time.
> Now the only constrain is should read back the registers if you have
> writen to it.
> It will low down the performance, but it does not matter. Because phy
> init will only done once when you initialize it.
> I will think about reove the u2o_xxx APIs.

You didn't even understand what I meant. Seriously.

Anyway, details are as follows:

readl() and writel() always add a memory barrier around each operation.

This is good because it makes sure memory mapped I/O region is always
ordered, but your current usage will post reads and writes on the
interconnect over and over again for no reason. What you should do, with
any register access is:

reg = readl();

reg &= ~BITS_TO_DISABLE;
reg |= BITS_TO_ENABLE;

writel(reg);

Whereas your current code does:

reg = readl();
reg &= ~BITS_TO_DISABLE;
writel(reg);

reg = readl();
reg |= BITS_TO_ENABLE;
writel(reg);

You do that for each bit, in some cases.

> >> +static int _mv_usb2_phy_init(struct mv_usb2_phy *mv_phy)
> >> +{
> >> +     struct platform_device *pdev = mv_phy->pdev;
> >> +     unsigned int loops = 0;
> >> +     void __iomem *base = mv_phy->base;
> >> +
> >> +     dev_dbg(&pdev->dev, "phy init\n");
> >
> > remove this debugging message.
> >
> >> +     /* Initialize the USB PHY power */
> >> +     if (mv_phy->type == PXA910_USB) {
> >
> > you _do_ have a REVISION register. Are you 100% certain that revision is
> > the same on all your devices ? It seems to me that you should be doing
> > proper revision detection instead of adding the hacky enumeration of
> > yours.
> 
> We do not have revison registers and will do not want ot define
> #ifdef CPU_PXA910 or CPU_PXA_XXX
> or
> use is_cpu_pxa910 or cpu_pxa_xxx
> because it is not acceptable. for example, if we have new SOC and it
> use the same PHY as pxa910
> i have to change the USB driver code to support it. for example
> #ifdef CPU_PXA910 || CPU_XXX

what a load of crap.

*read your code!!!*

There is a UTMI_REVISION register defined at offset 0.

> So i have to depends on the device_id to do the work.
> >
> >> +     /* UTMI_IVREF */
> >> +     if (mv_phy->type == PXA168_USB)
> >> +             /* fixing Microsoft Altair board interface with NEC hub issue -
> >> +              * Set UTMI_IVREF from 0x4a3 to 0x4bf */
> >
> > wrong comment style. Run *ALL* your patches through checkpatch.pl
> > --strict and sparse.
> >
> 
> It seems that checkpatch.pl can not detect everything. I really use
> checpatch.pl for
> every patch i sent to maillist.
> sorry for that, i will fix it.

did you use --strict ?

> >> +static int _mv_usb2_phy_shutdown(struct mv_usb2_phy *mv_phy)
> >> +{
> >> +     void __iomem *base = mv_phy->base;
> >> +
> >> +     if (mv_phy->type == PXA168_USB)
> >> +             u2o_clear(base, UTMI_OTG_ADDON, UTMI_OTG_ADDON_OTG_ON);
> >> +
> >> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_RXBUF_PDWN);
> >> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_TXBUF_PDWN);
> >> +     u2o_clear(base, UTMI_CTRL, UTMI_CTRL_USB_CLK_EN);
> >> +     u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
> >> +     u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
> >
> > NAK, this is stupid, read once, clear bits you want to clear and write
> > only once.
> >
> 
> I will check with silicon design engineer. becuase all the phy init
> code is delivered by them.

right, but you need to be critical with any code you read. You can't
simply blindly make it compile on linux and hope that it'll work
efficiently.

I doubt your silicon validation evironment has support for the memory
barriers which are added on each readl()/writel() calls.

> I can not tell that if there are any speciall reason they will do so
> because the device register read/write is not same as normal memory.

seriously ? Read your documentation dude, there's nothing that will
require you to enable one bit in the register, then flush the write,
then write another bit, flush the write, write another bit, flush the
write and so on.

Those cases are extremely rare (MUSB has only *ONE* such case with
regards to DMA_MODE bit) and in 99% of the cases, you can write
everything to a variable and post a single write to your interconnect.

Stop trying to come up with nonsensical excuses that "register
read/write is not same as normal memory", of course it's not same as
normal memory, and that's why we have standardized I/O functions.

> >> +     return 0;
> >> +}
> >> +
> >> +static int mv_usb2_phy_init(struct usb_phy *phy)
> >> +{
> >> +     struct mv_usb2_phy *mv_phy = container_of(phy, struct mv_usb2_phy, phy);
> >> +     int i = 0;
> >> +
> >> +     mutex_lock(&mv_phy->phy_lock);
> >
> > what's this mutex for ?
> >
> >> +     if (mv_phy->refcount++ == 0) {
> >
> > can this device really be used simultaneously by multiple devices ?
> >
> 
> Sure, we have another EHCI device, it will share the PHY with this USB
> controller.

what is "this USB controller", current driver is for the PHY only. Do
you mean to say that PHY will be shared by EHCI and UDC ?

> So we will use refcount and mutext to protect the phy init.

in that case, it might be better to add a generic refcounting to the PHY
layer as a whole, instead of cooking your own private solutions.

> >> +     for (i = 0; i < mv_phy->clks_num; i++) {
> >> +             mv_phy->clks[i] = devm_clk_get(&pdev->dev,
> >> +                                             pdata->clkname[i]);
> >
> > *NEVER* pass clock names via platform_data, this is utterly wrong.
> >
> without device tree support, the only way we can get the clock is the pdata.
> the use phy have mutiple clocks.
> So what do you suggest to handle it?

clkdev

> >> +static struct platform_driver mv_usb2_phy_driver = {
> >> +     .probe  = mv_usb2_phy_probe,
> >> +     .remove = mv_usb2_phy_remove,
> >> +     .driver = {
> >> +             .name   = "pxa168-usb-phy",
> >> +     },
> >> +     .id_table = mv_usb2_phy_ids,
> >> +};
> >> +
> >> +static int __init mv_usb2_phy_driver_init(void)
> >> +{
> >> +     return platform_driver_register(&mv_usb2_phy_driver);
> >> +}
> >> +arch_initcall(mv_usb2_phy_driver_init);
> >
> > NAK, use module_platform_driver() like everybody else and handle
> > registration ordering with -EPROBE_DEFER.
> >
> 
> The reason i do not use module_platform_driver is the compiling
> sequence of each directory of driver/usb/
> the phy is compiled after otg/ehci. So it means that it can not find
> the usb phy, and will register fail.

it doesn't matter, you should teach EHCI about -EPROBE_DEFER. If it
can't grab the PHY, return -EPROBE_DEFER.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130305/6bef20d9/attachment.sig>
