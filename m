From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 19 Nov 2013 15:15:58 +0800
Subject: UEFI Clock
In-Reply-To: <CAPw-ZT=rNKhbD+omXHSuzHVhtmhvJ8e6GogyNFE4qYYaPdjCEA@mail.gmail.com>
References: <5289993F.5020905@linaro.org>
 <CAPw-ZT=rNKhbD+omXHSuzHVhtmhvJ8e6GogyNFE4qYYaPdjCEA@mail.gmail.com>
Message-ID: <528B102E.3020302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-18 13:57, Loc Ho wrote:
> Hi,
> 
>>>> I will be looking into covering the clock driver to support UEFI.
>>>> Before I do this, can someone explain to me how x86 system handle each
>>>> IP clock as I don't see such thing?
>>>
>>> UEFI is completely unrelated to the clock drivers, it is only a firmware
>>> interface for the OS loader. UEFI mostly disappears after Linux is
>>> loaded. Are you perhaps asking about ACPI?
>>>
>>> There isn't such a thing on x86. This is entirely new territory. On x86
>>> as far as I know any clock manipulation that does need to be done would
>>> be performed by an ACPI method, but there is no concept of an IP clock
>>> in the ACPI namespace, and so no standard way of describing them.
>>
>> Yes, there is no standard way (ACPI device object or ACPI table) to
>> describe clocks for x86 in ACPI spec, but there is a table called GTDT
>> (Generic Timer Description Table) for ARM which contains information
>> for arch timer initialization.
>>
>> you can refer to ACPI spec 5.0 chapter 5.2.24:
>> http://www.acpi.info/spec50.htm
> [Loc Ho]
> Do you know how an IP (such as SATA controller) clock is enabled for
> x86? Or x86 is mostly PCIe and the clock is handled inside the driver

Sorry, I have no idea about this :(

> itself. Another related question would be how x86 enables the PCIe
> controller clock? Is that too handled inside the host controller
> driver itself or by some standard method within ACPI?

AFAIK, there is a HPET table for x86 for timer init, but there is
no standard method within ACPI to get timer for devices in DSDT.

> 
>>>
>>> You'd be much better of talking to Al Stone and Grame Gregory about what
>>> their plans are for clock support in ACPI and to post your question to
>>> the ACPI mailing list.
>>
>> We already finished the implementation of convert fixed clock and arch
>> timer to ACPI, and I had already post the RFC patch set for review now:
>>
>> http://marc.info/?l=linaro-acpi&m=138450991609818&w=2
> [Loc Ho]
> Looked over this one. We will take this patch into our kernel.

It is RFC, still needs some update, I will send another version soon.
I will send to linaro-acpi at lists.linaro.org, it is a public mailing
list.

> 
>> http://marc.info/?l=linaro-acpi&m=138198249622451&w=2
> [Loc Ho]
> From what I can tell with DT, the only reason that an IP would need
> this would be an common clock interface for framework to enable an IP
> clock. If the framework expected an clock instance and one isn't
> available, it will fail. Other than that, if an IP can handle its
> clock initialization, do we really need this at all. For reference
> clock and a few others, this is required if an IP clock is scaled from
> an reference clock for say. I would like an agreement on the IP clock
> itself. Is it required or they will be handled by the IP driver
> itself?
> 
> Please be aware of the following limitation that we (at APM) ran into
> and looking for an fix:
> 
> 1. The fixed 32-bit memory resource can NOT be overlapped with another
> memory resource with kernel version below 3.12. Don't know if this
> limitation still existed in 3.12 kernel. May be this limit is removed
> if one use 64-bit resource address but hasn't tried yet.
> 2. Overlap memory resource may be required if the same clock resource
> combined other reset fields into the same registers. For this, one can
> NOT use the standard _CRS as the same region may be defined with the
> IP driver. Don't see an solution besides to use an non-standard
> address. Then, what do one put in the _CRS as the ACPI expect one. If
> you use an empty entry with 0 for address and 0 for length, other OS
> vendor will complaint as well.

I didn't catch up with the limitation clearly, if any specific example,
that would be great.

Thanks
Hanjun
