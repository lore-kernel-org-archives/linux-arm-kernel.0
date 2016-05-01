From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 1 May 2016 13:55:43 -0400
Subject: [PATCH V3 1/3] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <4981390.J9tsJr16lM@wuerfel>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
 <147496989.L43SVC7xRY@wuerfel>
 <8f766d081b33d91f196e7bd5e13b6f33@codeaurora.org>
 <4981390.J9tsJr16lM@wuerfel>
Message-ID: <5726431F.7070106@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/2016 8:44 AM, Arnd Bergmann wrote:
>>  can certainly drop patch #3 and push the reset responsibility to acpi.
>> > 
>> > I never liked having a fragmented sw design across multiple drivers.
>> > 
>> > I need something for patch #1. Compatible is a DT property not ACPI.but 
>> > then, I won't have a reset driver anymore.
>> > 
>> > If we think about how vfio pci works, we pass the pci vendor and device 
>> > id to new_id file to find out which pci device needs to be pass thru.
>> > 
>> > I can go to a similar route. This time we pass the object id through 
>> > new_id and I call reset method on this object.
>> > 
>> > Let me know what you think?
> It would certainly be nice to make it work more like PCI VFIO does
> here, where you can assign any device as long as it has an IOMMU
> (and a _rst method in this case).
> 
> 	Arnd

I looked at the code today. This doesn't have to be as convoluted as PCI is. 
The VFIO platform driver already has a pointer to the actual object in
vdev->pdev.dev.

This is really as simple as calling _RST method on the passed oject at the last
step below. We don't need to create a dynamic list like PCI does. 

This is how the driver gets called. 

echo vfio-platform | tee -a /sys/bus/platform/devices/QCOM8061:00/driver_override
echo QCOM8061:00 | tee -a  /sys/bus/platform/devices/QCOM8061:00/driver/unbind
echo QCOM8061:00 |tee -a /sys/bus/platform/drivers_probe

I'll post a patch as soon as I test it.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
