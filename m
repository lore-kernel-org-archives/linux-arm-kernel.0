From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 22 Jul 2013 11:18:46 -0400 (EDT)
Subject: [PATCH 6/6] USB: ehci-omap: Implement suspend/resume
In-Reply-To: <51ED30A8.10200@ti.com>
Message-ID: <Pine.LNX.4.44L0.1307221111410.1495-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Roger Quadros wrote:

> Right, I understand it now. How does the below code look?
> 
> +static int omap_ehci_suspend(struct device *dev)
> +{
> +       struct usb_hcd *hcd = dev_get_drvdata(dev);
> +       bool do_wakeup = device_may_wakeup(dev);
> +       int ret;
> +
> +       dev_dbg(dev, "%s may_wakeup %d\n", __func__, do_wakeup);
> +
> +       if (pm_runtime_status_suspended(dev)) {

You need to do this only when do_wakeup is false.

> +               pm_runtime_get_sync(dev);
> +               ehci_resume(hcd, false);
> +               ret = ehci_suspend(hcd, do_wakeup);
> +               pm_runtime_put_sync(dev);

It would be better to call pm_runtime_resume(dev) at the start instead
of pm_runtime_get_sync(), and eliminate the last two lines.  Then the
ehci_suspend() below could be moved outside the "if" statement.

Alternatively, if you are able to turn off the wakeup setting without
going through an entire resume/suspend cycle, that would be preferable.

> +
> +       } else {
> +               ret = ehci_suspend(hcd, do_wakeup);
> +       }
> +
> +       return ret;
> +}
> +
> +static int omap_ehci_resume(struct device *dev)
> +{
> +       struct usb_hcd *hcd = dev_get_drvdata(dev);
> +       int ret;
> +
> +       dev_dbg(dev, "%s\n", __func__);
> +
> +       ret = ehci_resume(hcd, false);
> +       if (!ret) {
> +               /*
> +                * Controller was powered ON so reflect state
> +                */
> +               pm_runtime_disable(dev);
> +               pm_runtime_set_active(dev);
> +               pm_runtime_enable(dev);
> +       }
> +
> +       return ret;
> +}

All good.

Alan Stern
