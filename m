From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 30 Nov 2015 09:42:01 -0500
Subject: [PATCH V7 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151130082141.GB3901@localhost>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
 <20151130082141.GB3901@localhost>
Message-ID: <565C6039.6050404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 3:21 AM, Vinod Koul wrote:
> On Sun, Nov 22, 2015 at 09:28:24PM -0500, Sinan Kaya wrote:
> 
>> +++ b/Documentation/ABI/testing/sysfs-platform-hidma-mgmt
>> @@ -0,0 +1,97 @@
>> +What:		/sys/devices/platform/hidma-mgmt*/chan*/priority
>> +		/sys/devices/platform/QCOM8060:*/chan*/priority
>> +Date:		Nov 2015
>> +KernelVersion:	4.4
>> +Contact:	"Sinan Kaya <okaya@cudeaurora.org>"
>> +Description:
>> +		Contains either 0 or 1 and indicates if the DMA channel is a
>> +		low priority (0) or high priority (1) channel.
> 
> What is purpose of adding sysfs entries here ?
> 

The goal is to run hidma channels in the guest machines and have
management driver adjust the runtime characteristics of the channels
such as round robing weight, priority, max read request etc. All of
these are runtime configurable.

There will be a userspace application that will configure this on behalf
of the system administrator via sysfs. System administrator will decide
how to allocate hardware resources to the guest machines.


>> +
>> +#define QOS_N_OFFSET			0x300
>> +#define CFG_OFFSET			0x400
>> +#define MAX_BUS_REQ_LEN_OFFSET		0x41C
>> +#define MAX_XACTIONS_OFFSET		0x420
>> +#define HW_VERSION_OFFSET		0x424
>> +#define CHRESET_TIMEOUT_OFFSET		0x418
>> +
>> +#define MAX_WR_XACTIONS_MASK		GENMASK(4, 0)
>> +#define MAX_RD_XACTIONS_MASK		GENMASK(4, 0)
>> +#define WEIGHT_MASK			GENMASK(6, 0)
>> +#define MAX_BUS_REQ_LEN_MASK		GENMASK(15, 0)
>> +#define CHRESET_TIMEOUUT_MASK		GENMASK(19, 0)
>> +
>> +#define MAX_WR_XACTIONS_BIT_POS	16
>> +#define MAX_BUS_WR_REQ_BIT_POS		16
>> +#define WRR_BIT_POS			8
>> +#define PRIORITY_BIT_POS		15
>> +
>> +#define AUTOSUSPEND_TIMEOUT		2000
>> +#define MAX_CHANNEL_WEIGHT		15
> 
> These names are quite generic and prone to collide with generic names,
> please prefix them with your driver name
> 

OK

>> +}
>> +EXPORT_SYMBOL_GPL(hidma_mgmt_setup);
> 
> Why is this exported or rather who would be users of this?

This driver consists of two files as hidma_mgmt.c and hidma_mgmt_sys.c.
I'm calling hidma_mgmt_setup from the hidma_mgmt_sys.c file when a
parameter such as priority and weight is changed to reconfigure the
hardware. I got linker errors without this export as this function is in
hidma_mgmt.c file.

> 
>> +static int hidma_mgmt_probe(struct platform_device *pdev)
>> +{
>> +	struct hidma_mgmt_dev *mgmtdev;
>> +	struct resource *res;
>> +	void __iomem *virtaddr;
>> +	int irq;
>> +	int rc;
>> +	u32 val;
>> +
>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>> +	pm_runtime_use_autosuspend(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
> 
> at this time pm core will treat device as fully enabled and pm methods can
> be invoked, but you are not ready yet right. Typically these are done at the
> end of the probe unless you have a reason... 

I need it here because the clocks are declared as ACPI power resources.
The kernel is turning off all power resources during initialization. In
order for this code to touch the hardware, I need to call enable so that
clocks are enabled once again.

> 
>> +static ssize_t show_values(struct device *dev, struct device_attribute *attr,
>> +				char *buf)
> 
> Please fix the coding style here and other places as well. 

what's the problem here?

> Specifically
> please read Chapter 2
> 

Why is checkpatch not complaining about any of the coding style issues?
I'm checking my code with checkpatch before submitting. Is there any
other tool that would catch this?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
