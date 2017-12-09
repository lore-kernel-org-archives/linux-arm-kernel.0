From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 8 Dec 2017 20:54:15 -0500
Subject: [PATCH V3] ACPI / GED: unregister interrupts during shutdown
In-Reply-To: <CAJZ5v0iqXz-zBb5Lg_f1FU54-H5hiWcfg-1Qa3hDdbUz=hZD0g@mail.gmail.com>
References: <1512708033-28180-1-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iqXz-zBb5Lg_f1FU54-H5hiWcfg-1Qa3hDdbUz=hZD0g@mail.gmail.com>
Message-ID: <158410c8-2861-a2c9-1246-9604ab9a8e91@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/8/2017 8:54 AM, Rafael J. Wysocki wrote:
>> static int ged_remove(struct platform_device *pdev)
>> +{
>> +       struct acpi_ged_device *geddev = platform_get_drvdata(pdev);
>>
>> +       ged_cleanup_irq(geddev);
> Do you really need this duplication?  You may as well call
> ged_shutdown() from here.
> 
> And the local variable is redundant too.
> 
> I guess it would be better to just fold ged_cleanup_irq() into
> ged_shutdown() and call that from ged_remove().
> 

I originally tried to make these two APIs as common as possible and tried
calling shutdown from remove. However, the calling convention of shutdown
and remove are different. 

Shutdown returns void; whereas, remove returns an integer. That's why, I
created a common function and called from both places. 

I can probably make the calling parameter of ged_cleanup_irq() a pdev and
get rid of the additional casting in these two different functions. 

Let me know if you have a better idea.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
