From: okaya@codeaurora.org (okaya at codeaurora.org)
Date: Tue, 29 Mar 2016 06:59:15 -0400
Subject: [PATCH V3 1/3] vfio, platform: add support for ACPI while
 detecting the reset driver
In-Reply-To: <98854818.NJS35fvhsb@wuerfel>
References: <1459172124-6730-1-git-send-email-okaya@codeaurora.org>
 <1459172124-6730-2-git-send-email-okaya@codeaurora.org>
 <98854818.NJS35fvhsb@wuerfel>
Message-ID: <e736f6bc775cdca8a4bb0dab20654823@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-29 05:25, Arnd Bergmann wrote:
> On Monday 28 March 2016 09:35:22 Sinan Kaya wrote:
>> The code is using the compatible DT string to associate a reset driver 
>> with
>> the actual device itself. The compatible string does not exist on ACPI
>> based systems. HID is the unique identifier for a device driver 
>> instead.
>> The change allows a driver to register with DT compatible string or 
>> ACPI
>> HID and then match the object with one of these conditions.
>> 
>> Rules for loading the reset driver are as follow:
>> - ACPI HID needs match for ACPI systems
>> - DT compat needs to match for OF systems
>> 
>> Tested-by: Eric Auger <eric.auger@linaro.org> (device tree only)
>> Tested-by: Shanker Donthineni <shankerd@codeaurora.org> (ACPI only)
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> 
> 
> 
> This really feels wrong for two reasons:
> 
> * device assignment of non-PCI devices is really special and doesn't
>   seem to make sense on general purpose servers that would be the 
> target
>   for ACPI normally


Why is it special? Acpi is not equal to pci. Platform devices are first 
class devices too. Especially, _cls was introduced for this reason.


> 
> * If there is indeed a requirement for ACPI to handle something like 
> this,
>   it should be part of the ACPI spec, with a well-defined method of 
> handling
>   reset, rather than having to add a device specific hack for each
>   device separately.
> 

I see. Normally, this is done by calling _rst method. AFAIK, Linux 
doesn?t support _rst. I can check its presence and call it if it is 
there.



> 	Arnd
