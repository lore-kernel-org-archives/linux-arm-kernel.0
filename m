From: rogerq@ti.com (Roger Quadros)
Date: Tue, 23 Jul 2013 12:18:52 +0300
Subject: [PATCH 6/6] USB: ehci-omap: Implement suspend/resume
In-Reply-To: <Pine.LNX.4.44L0.1307221111410.1495-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1307221111410.1495-100000@iolanthe.rowland.org>
Message-ID: <51EE4A7C.2020709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 06:18 PM, Alan Stern wrote:
> On Mon, 22 Jul 2013, Roger Quadros wrote:
> 
>> Right, I understand it now. How does the below code look?
>>
>> +static int omap_ehci_suspend(struct device *dev)
>> +{
>> +       struct usb_hcd *hcd = dev_get_drvdata(dev);
>> +       bool do_wakeup = device_may_wakeup(dev);
>> +       int ret;
>> +
>> +       dev_dbg(dev, "%s may_wakeup %d\n", __func__, do_wakeup);
>> +
>> +       if (pm_runtime_status_suspended(dev)) {
> 
> You need to do this only when do_wakeup is false.

Right. Missed that.
> 
>> +               pm_runtime_get_sync(dev);
>> +               ehci_resume(hcd, false);
>> +               ret = ehci_suspend(hcd, do_wakeup);
>> +               pm_runtime_put_sync(dev);
> 
> It would be better to call pm_runtime_resume(dev) at the start instead
> of pm_runtime_get_sync(), and eliminate the last two lines.  Then the
> ehci_suspend() below could be moved outside the "if" statement.

Why do I find pm_runtime_* so confusing ;)

> 
> Alternatively, if you are able to turn off the wakeup setting without
> going through an entire resume/suspend cycle, that would be preferable.
> 

As we don't rely on the EHCI controller's interrupt any more after we
power it down, maybe ehci_resume/suspend cycle is not required at all on OMAP,
even if the wakeup setting is disabled during system suspend.

As the wakeup is controlled entirely by pad wakeup, all we need to do is make sure
the IO pad wakeup is configured correctly based on do_wakeup. How this is done
is still in transition but it might be turn out to be as simple as irq_set_irq_wake()

So IMHO, for ehci-omap this should suffice

static int omap_ehci_suspend(struct device *dev)
{
	struct usb_hcd *hcd = dev_get_drvdata(dev);
	bool do_wakeup = device_may_wakeup(dev);
	int ret = 0;

	if (!pm_runtime_status_suspended(dev))
		ret = ehci_suspend(hcd, do_wakeup);

	/* Not tested yet */
	irq_set_irq_wake(hcd->irq, do_wakeup);

	return ret;
}

What do you think?

As the OMAP IO pad wakeup management code [1] is still in transition, I'll wait till
that gets settled and then resend this series.

cheers,
-roger

[1] - http://thread.gmane.org/gmane.linux.ports.arm.omap/99010
