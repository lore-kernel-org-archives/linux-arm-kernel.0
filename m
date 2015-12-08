From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 8 Dec 2015 09:36:02 -0500
Subject: [PATCH V7 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <20151205075826.GI1854@localhost>
References: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
 <1448245707-27499-3-git-send-email-okaya@codeaurora.org>
 <20151130082141.GB3901@localhost> <565C6039.6050404@codeaurora.org>
 <20151201031710.GK3901@localhost> <565E7A3E.1070207@codeaurora.org>
 <20151205075826.GI1854@localhost>
Message-ID: <5666EAD2.1060408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2015 2:58 AM, Vinod Koul wrote:
> On Tue, Dec 01, 2015 at 11:57:34PM -0500, Sinan Kaya wrote:
>> On 11/30/2015 10:17 PM, Vinod Koul wrote:
>>> On Mon, Nov 30, 2015 at 09:42:01AM -0500, Sinan Kaya wrote:
>>>
>>>>>> +static int hidma_mgmt_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +	struct hidma_mgmt_dev *mgmtdev;
>>>>>> +	struct resource *res;
>>>>>> +	void __iomem *virtaddr;
>>>>>> +	int irq;
>>>>>> +	int rc;
>>>>>> +	u32 val;
>>>>>> +
>>>>>> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
>>>>>> +	pm_runtime_use_autosuspend(&pdev->dev);
>>>>>> +	pm_runtime_set_active(&pdev->dev);
>>>>>> +	pm_runtime_enable(&pdev->dev);
>>>>>
>>>>> at this time pm core will treat device as fully enabled and pm methods can
>>>>> be invoked, but you are not ready yet right. Typically these are done at the
>>>>> end of the probe unless you have a reason... 
>>>>
>>>> I need it here because the clocks are declared as ACPI power resources.
>>>> The kernel is turning off all power resources during initialization. In
>>>> order for this code to touch the hardware, I need to call enable so that
>>>> clocks are enabled once again.
>>>
>>> The question is are you ready in your driver routines to be invoked by pm
>>> core?
>>>
>>
>> I don't have any support for suspend and resume PM APIs. The only PM
>> interface I support is PM runtime. PM can turn on/off the clocks based
>> on the reference counts it maintains after get/set APIs. Since PM is
>> turning off the clocks during power up before my driver load, I do need
>> to grab this lock to re-enable it during HW initialization. Then, let PM
>> turn off the clocks again after the AUTOSUSPEND_TIMEOUT when I'm done.
>>
>> Is there any other interaction with the PM that I'm not aware of?
> 
> No this is fine. The the runtime_resume will be onvoked and it will request
> resources are those set before you enable the device?
> 

Yes, the only resource that this device needs for power management is
the ACPI power resources. The device does not support suspend/resume via
traditional _PS0 and _PS3 calls. ACPI power resources are initialized
during power up while ACPI is being enumerated.

The probing of the HIDMA driver happens much afterwards.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
