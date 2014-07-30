From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 30 Jul 2014 17:36:34 +0800
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAMJs5B8L8GBsYOUMvu36fNQDv+fEXrBYQYDhkAtJkFzS3VsdPQ@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>	<20140729112824.GM2576@leverpostej>	<CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>	<351673188.FxXsM7MvdA@wuerfel>	<20140729130823.GP2576@leverpostej>	<CAMJs5B8uk7GDfEOEuY8RWDxzhzTRBGszRDN+JRKwG-D_rgzFrw@mail.gmail.com>	<53D894F0.1060102@linaro.org>
 <CAMJs5B8L8GBsYOUMvu36fNQDv+fEXrBYQYDhkAtJkFzS3VsdPQ@mail.gmail.com>
Message-ID: <53D8BCA2.5020007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-30 15:14, Christoffer Dall wrote:
> On 30 July 2014 08:47, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> On 2014-7-29 21:31, Christoffer Dall wrote:
>>> On 29 July 2014 15:08, Mark Rutland <mark.rutland@arm.com> wrote:
>>>> On Tue, Jul 29, 2014 at 01:52:40PM +0100, Arnd Bergmann wrote:
>>>>> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
>>>>>>
>>>>>> For reference, Red Hat's current arguing point for ACPI in VMs is
>>>>>> hotplug of things like CPUs and memory for very large VMs, but I
>>>>>> haven't thought too carefully about this just yet, as I don't have a
>>>>>> 100+ core ARM 64-bit hardware lying around...
>>>>>
>>>>> I thought you could run guests with more virtual CPUs that you have
>>>>> physical CPUs on the host.
>>>>>
>>>>> Regarding CPU and memory hotplug, don't we already have PSCI and
>>>>> xen-balloon/virtio-balloon for that?
>>>>
>>>> PSCI (0.1) was there for guests from the start, and ACPI doesn't do
>>>> anything different w.r.t. PSCI other than requiring PSCI 0.2 (which can
>>>> be used by guests supporting only PSCI 0.1). So there's no magic for
>>>> CPU hotplug provided by ACPI.
>>>
>>> With PSCI you can only provide your VM a bunch of CPUs and say that
>>> they're all turned off, and then turn some of them on later.
>>
>> Yes, agreed.
>>
>>> I honestly don't know if you can do proper CPU hotplug with ACPI, but
>>> the RH guys seem to argue that you can.  Again, I didn't think too
>>> carefully about this.
>>
>> Yes, we can do proper CPU hotplug with ACPI based physical hotplug (named
>> dynamic device configuration in ACPI spec), you can refer to section 6.3
>> "Device Insertion, Removal, and Status Objects" in ACPI 5.1.
>>
>> There are mechanisms for handling dynamic insertion and removal of devices
>> and for determining device and notification processing status. When removing
>> a processor,
>>
>> a) we will call PSCI or similar interface to offline a CPU from OS, then
>>    OS will not use it any more;
>>
>> b) call ACPI API to trim the resources that allocated during device
>>    enumeration;
>>
>> c) Call ACPI method _EJ0 and then will notify firmware or hypervisor device
>>    will be removed, jump to firmware or hypervisor to remove the device
>>    from that level;
> 
> When you say notify hypervisor, would we really need a
> hypervisor-specific interface if you're running UEFI as your firmware?
>  Can you not just call whatever UEFI service to remove a CPU and let
> that UEFI implementation deal with the hypervisor/hardware interface?

Yes, it should work as you said, OS will notfy UEFI and then UEFI deal with
hypervisor interface, sorry, I didn't describe it clearly.

Thanks
Hanjun
