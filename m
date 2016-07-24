From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 24 Jul 2016 10:38:11 -0400
Subject: [PATCH 10/10] dmaengine: qcom_hidma: add MSI support for
 interrupts
In-Reply-To: <20160724064256.GA9681@localhost>
References: <1468867177-15007-1-git-send-email-okaya@codeaurora.org>
 <1468867177-15007-11-git-send-email-okaya@codeaurora.org>
 <20160724064256.GA9681@localhost>
Message-ID: <e6560c8b-e18e-9e32-5b51-c1c12d8551ce@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 7/24/2016 2:42 AM, Vinod Koul wrote:
> On Tue, Jul 19, 2016 at 12:09:37AM +0530, Sinan Kaya wrote:
> 
>> @@ -567,6 +578,98 @@ static int hidma_create_sysfs_entry(struct hidma_dev *dev, char *name,
>>         return device_create_file(dev->ddev.dev, attrs);
>>  }
>>
>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
> 
> This can be true on machine with your older HW, so I would be bit more
> careful here..

Correct, I tested the patch with new and old HW. The old HW won't attempt calling this function
since msi flag will be false.

> 
>> +       if (rc)
>> +               dev_warn(&pdev->dev,
>> +                        "failed to request MSI irq, falling back to wired IRQ\n");
>> +       return rc;
>> +#else
>> +       return -EINVAL;
> 
> -EINVAL doesnt sound apt here..

What should I use? -ENOENT ?

> 
>> +       struct acpi_device *adev = ACPI_COMPANION(dev);
>> +       const char *of_compat;
>> +       int ret;
>> +
>> +       if (!adev || acpi_disabled) {
>> +               ret = device_property_read_string(dev, "compatible",
>> +                                                 &of_compat);
>> +               if (ret)
>> +                       return false;
>> +
>> +               ret = strcmp(of_compat, "qcom,hidma-1.1");
>> +       } else {
>> +               ret = strcmp(acpi_device_hid(adev), "QCOM8062");
> 
> Okay if you ahve a device ID then why do we need new binding? This device as
> you said implies the support for MSI interrupts.


Yes, I do have a new device ID for platforms with MSI capability. 

Which new binding are you referring to?

> 
> Thanks
> 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
