From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 17 Nov 2016 08:17:00 -0800
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <20161117150551.GA21742@leverpostej>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej> <20161116221002.GA19925@roeck-us.net>
 <CAOMZO5Bd2X3pVqExBtBw_uHReDDkf6J2VdMXnAXynCAHxoX60A@mail.gmail.com>
 <20161116224024.GA11821@roeck-us.net> <20161117105513.GA12273@leverpostej>
 <198d764e-1612-81b4-5f4e-0c221a23c8e0@roeck-us.net>
 <20161117150551.GA21742@leverpostej>
Message-ID: <2eaf84f9-ea00-d331-1875-56adafb62378@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 07:05 AM, Mark Rutland wrote:
> On Thu, Nov 17, 2016 at 06:44:55AM -0800, Guenter Roeck wrote:
>> On 11/17/2016 02:55 AM, Mark Rutland wrote:
>>> On Wed, Nov 16, 2016 at 02:40:24PM -0800, Guenter Roeck wrote:
>>>> On Wed, Nov 16, 2016 at 08:27:09PM -0200, Fabio Estevam wrote:
>>>>> Hi Guenter,
>>>>>
>>>>> On Wed, Nov 16, 2016 at 8:10 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> Anyway, I guess the problem is that the "official" dtb files no longer provide
>>>>>> the skeleton /chosen and /memory nodes (and maybe others), and qemu seems to
>>>>>> expect that they are provided. Is that correct ?
>>>>>
>>>>> imx6qdl-sabrelite.dtsi provides chosen and memory nodes.
>>>>
>>>> Yes, but not the 'device_type' property, which the kernel seems to expect.
>>>
>>> Memory nodes require this property per ePAPR and the devicetree.org
>>> spec, so the bug is that we didn't add those when removing the
>>> skeleton.dtsi include.
>>
>> The downside from qemu perspective is that the real hardware seems
>> to add the property unconditionally, or the boot failure would have
>> been seen there as well.
>>
>> I submitted https://patchwork.ozlabs.org/patch/695951/; we'll see how it goes.
>
> Sure, the firmare/bootlaoder you're using may add this automatically.
>
> My worry is that adding this to a generic file in QEMU only serves to
> mask this class of bug for other boards (i.e. they'll work fine in QEMU,
> but not on real HW using whatever bootlaoder happens ot be there).
>
Good point.

What would be the correct behavior for qemu ? Adding a chosen node if it does
not exist is one detail we already established. Also, I think a check if
/memory/device_type exists (and to bail out if it doesn't) would make sense.

What about the memory node ? Does it have to exist, or should it be added
(including the device_type property) if not ?

Thanks,
Guenter
