From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 23:49:00 +0100
Subject: [PATCHv3 1/5] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <54BAE0AE.5060705@cogentembedded.com>
References: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
 <1421529942-18437-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421529942-18437-2-git-send-email-sylvain.rochet@finsecur.com>
 <54BAE0AE.5060705@cogentembedded.com>
Message-ID: <20150117224900.GA22439@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,


On Sun, Jan 18, 2015 at 01:22:38AM +0300, Sergei Shtylyov wrote:
> 
>    There's little inconsistency in your patch subjects: you're using
> '_' but the files you're modifying are named using '-'...

Indeed.


> >@@ -187,6 +217,8 @@ static struct platform_driver ehci_atmel_driver = {
> >  	.probe		= ehci_atmel_drv_probe,
> >  	.remove		= ehci_atmel_drv_remove,
> >  	.shutdown	= usb_hcd_platform_shutdown,
> >+	.suspend	= ehci_atmel_drv_suspend,
> >+	.resume		= ehci_atmel_drv_resume,
> 
>    I think you should use 'struct dev_pm_ops' now.

This way ?

static int ehci_atmel_drv_suspend(struct device *dev)
{
	struct usb_hcd *hcd = dev_get_drvdata(dev);
(...)


static SIMPLE_DEV_PM_OPS(ehci_atmel_pm_ops, ehci_atmel_drv_suspend, ehci_atmel_drv_resume);

(...)
	.driver         = {
		.pm     = &ehci_atmel_pm_ops,
	}
(...)


Should I send a v4 or can I send this change separately on top of the 
previous change ?


Sylvain
