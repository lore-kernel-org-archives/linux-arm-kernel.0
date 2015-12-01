From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 1 Dec 2015 08:47:10 +0530
Subject: [PATCH V7 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <565C6039.6050404@codeaurora.org>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
 <20151130082141.GB3901@localhost> <565C6039.6050404@codeaurora.org>
Message-ID: <20151201031710.GK3901@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 09:42:01AM -0500, Sinan Kaya wrote:

> >> +static int hidma_mgmt_probe(struct platform_device *pdev)
> >> +{
> >> +	struct hidma_mgmt_dev *mgmtdev;
> >> +	struct resource *res;
> >> +	void __iomem *virtaddr;
> >> +	int irq;
> >> +	int rc;
> >> +	u32 val;
> >> +
> >> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> >> +	pm_runtime_use_autosuspend(&pdev->dev);
> >> +	pm_runtime_set_active(&pdev->dev);
> >> +	pm_runtime_enable(&pdev->dev);
> > 
> > at this time pm core will treat device as fully enabled and pm methods can
> > be invoked, but you are not ready yet right. Typically these are done at the
> > end of the probe unless you have a reason... 
> 
> I need it here because the clocks are declared as ACPI power resources.
> The kernel is turning off all power resources during initialization. In
> order for this code to touch the hardware, I need to call enable so that
> clocks are enabled once again.

The question is are you ready in your driver routines to be invoked by pm
core?

> 
> > 
> >> +static ssize_t show_values(struct device *dev, struct device_attribute *attr,
> >> +				char *buf)
> > 
> > Please fix the coding style here and other places as well. 
> 
> what's the problem here?
> 
> > Specifically
> > please read Chapter 2
> > 
> 
> Why is checkpatch not complaining about any of the coding style issues?
> I'm checking my code with checkpatch before submitting. Is there any
> other tool that would catch this?

So did you read the Chapter 2.. Quoting here

"Statements longer than 80 columns will be broken into sensible chunks,
unless
exceeding 80 columns significantly increases readability and does not hide
information. Descendants are always substantially shorter than the parent
and
are placed substantially to the right. The same applies to function headers
with a long argument list. However, never break user-visible strings such as
printk messages, because that breaks the ability to grep for them."

Your breaking lines is not placed substantially to the right..
I do not think checkpatch is checking this..

-- 
~Vinod
