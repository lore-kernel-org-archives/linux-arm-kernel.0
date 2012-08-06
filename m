From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Aug 2012 12:44:02 +0300
Subject: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
In-Reply-To: <CAAe_U6LhfrRk7PP-Td7BTXPngo7+chvTp4LwwKR_GbsjE4jNJQ@mail.gmail.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-2-git-send-email-kishon@ti.com>
 <20120803132708.GC8269@arwen.pp.htv.fi>
 <CAAe_U6K15Nm5aNs2Vn71G7ELZWka1zB2E3VGZWTc0VjyViJ6Yw@mail.gmail.com>
 <20120806084928.GD17551@arwen.pp.htv.fi>
 <CAAe_U6LhfrRk7PP-Td7BTXPngo7+chvTp4LwwKR_GbsjE4jNJQ@mail.gmail.com>
Message-ID: <20120806094401.GI17551@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 03:14:42PM +0530, ABRAHAM, KISHON VIJAY wrote:
> >> >> +static int omap_usb2_runtime_resume(struct device *dev)
> >> >> +{
> >> >> +     u32 ret = 0;
> >> >> +     struct platform_device  *pdev = to_platform_device(dev);
> >> >> +     struct omap_usb *phy = platform_get_drvdata(pdev);
> >> >> +
> >> >> +     ret = clk_enable(phy->wkupclk);
> >> >> +     if (ret < 0)
> >> >> +             dev_err(phy->dev, "Failed to enable wkupclk %d\n", ret);
> >> >> +
> >> >> +     return ret;
> >> >> +}
> >> >> +
> >> >> +static const struct dev_pm_ops omap_usb2_pm_ops = {
> >> >> +     SET_RUNTIME_PM_OPS(omap_usb2_runtime_suspend, omap_usb2_runtime_resume,
> >> >> +             NULL)
> >> >
> >> > only runtime ? What about static suspend ? We need this to work also
> >> > after a traditional echo mem > /sys/power/state ;-)
> >>
> >> The static suspend case is handled by users of this phy using
> >> set_suspend hooks.
> >
> > I'm not sure if that's too wise, what if your user enabled USB, but
> > for whatever reason loaded only the phy driver and not musb or dwc3. It
> > will fail, right ?
> 
> The enabling and disabling of phy is solely governed by usb controller
> driver (musb/dwc3). So if you dont have musb/dwc3 loaded, the phy will
> be for sure disabled.

fair enough... that's ok then ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120806/890a3afc/attachment.sig>
