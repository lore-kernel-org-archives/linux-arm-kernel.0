From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 1 Dec 2015 23:57:34 -0500
Subject: [PATCH V7 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151201031710.GK3901@localhost>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
 <20151130082141.GB3901@localhost> <565C6039.6050404@codeaurora.org>
 <20151201031710.GK3901@localhost>
Message-ID: <565E7A3E.1070207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2015 10:17 PM, Vinod Koul wrote:
> On Mon, Nov 30, 2015 at 09:42:01AM -0500, Sinan Kaya wrote:
> 
>>>> +static int hidma_mgmt_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct hidma_mgmt_dev *mgmtdev;
>>>> +	struct resource *res;
>>>> +	void __iomem *virtaddr;
>>>> +	int irq;
>>>> +	int rc;
>>>> +	u32 val;
>>>> +
>>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>>> +	pm_runtime_set_active(&pdev->dev);
>>>> +	pm_runtime_enable(&pdev->dev);
>>>
>>> at this time pm core will treat device as fully enabled and pm methods can
>>> be invoked, but you are not ready yet right. Typically these are done at the
>>> end of the probe unless you have a reason... 
>>
>> I need it here because the clocks are declared as ACPI power resources.
>> The kernel is turning off all power resources during initialization. In
>> order for this code to touch the hardware, I need to call enable so that
>> clocks are enabled once again.
> 
> The question is are you ready in your driver routines to be invoked by pm
> core?
> 

I don't have any support for suspend and resume PM APIs. The only PM
interface I support is PM runtime. PM can turn on/off the clocks based
on the reference counts it maintains after get/set APIs. Since PM is
turning off the clocks during power up before my driver load, I do need
to grab this lock to re-enable it during HW initialization. Then, let PM
turn off the clocks again after the AUTOSUSPEND_TIMEOUT when I'm done.

Is there any other interaction with the PM that I'm not aware of?

>>
>>>
>>>> +static ssize_t show_values(struct device *dev, struct device_attribute *attr,
>>>> +				char *buf)
>>>
>>> Please fix the coding style here and other places as well. 
>>
>> what's the problem here?
>>
>>> Specifically
>>> please read Chapter 2
>>>
>>
>> Why is checkpatch not complaining about any of the coding style issues?
>> I'm checking my code with checkpatch before submitting. Is there any
>> other tool that would catch this?
> 
> So did you read the Chapter 2.. Quoting here
> 

I did read the chapter 2. Maybe, my lack of native english speaking but
I don't get from this sentence that function parameters need to be
aligned to the opening paranthesis.

> Descendants are always substantially shorter than the parent
> and are placed substantially to the right. The same applies to function headers
> with a long argument list. 
> 

I ran Lindent and manually cleaned up the junk it introduced. The result
is this

static ssize_t show_values(struct device *dev, struct device_attribute
*attr,
			   char *buf)


> Your breaking lines is not placed substantially to the right..
> I do not think checkpatch is checking this..
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
