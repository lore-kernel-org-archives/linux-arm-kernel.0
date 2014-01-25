From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 25 Jan 2014 12:03:16 +0100
Subject: [PATCH] sunxi: dts: add a note that memory size is adjusted by
 boot loader.
In-Reply-To: <1390578114.13513.13.camel@kazak.uk.xensource.com>
References: <1390572852-15027-1-git-send-email-ijc@hellion.org.uk>	
 <52E2874F.10703@redhat.com>
 <1390578114.13513.13.camel@kazak.uk.xensource.com>
Message-ID: <52E399F4.1040300@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/24/2014 04:41 PM, Ian Campbell wrote:
> On Fri, 2014-01-24 at 16:31 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01/24/2014 03:14 PM, Ian Campbell wrote:
>>> I had to spend a couple of minutes proving to myself that this was the case on
>>> cubietruck, so add a comment to save the next guy some effort.
>>
>> Seems like a good idea to me, one small nitpick though see comments inline.
>>
>>> Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
>>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-sunxi at googlegroups.com
>>> ---
>>> This patch applies cleanly against v3.13 and Hans' sunxi-devel branch.
>>>
>>> A plausible alternative would be to pull the memory node out of the dtsi files
>>> and into the board specific files. I didn't go straight to that since I'd have
>>> to research all the various boards ;-)
>>
>> That won't help, some boards ie the original cubieboard and the mele-a1000 come
>> in both 512 MB and 1024 MB versions, and I don't think we want to start maintaining
>> 2 different dts files just for that.
>
> I didn't mean to suggest that u-boot should stop updating the dtb, so
> e.g. I would have put a 512MB reg in the cubieboard dts, with a similar
> comment.

Hmm, I've no idea what the default / preferred way of handling this is,
I assume Maxime knows, so lets wait for his input on this.

> But in cases where there is only one variant (e.g. the cubietruck) I'd
> have put a 2GB reg and no comment, even though u-boot would in reality
> rewrite the 2GB there.
>
>>> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
>>> index 3e60883..9ba0beb 100644
>>> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
>>> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
>>> @@ -30,6 +30,7 @@
>>>    	};
>>>
>>>    	memory {
>>> +		/* 1GB by default, will be updated by U-Boot */
>>>    		reg = <0x40000000 0x80000000>;
>>>    	};
>>>
>>
>> The comment says 1GB, but the range says 2GB, note 2GB is consistent with what the
>> datasheet claims as max RAM.
>
> Oops, I must have missed that.
>
>>
>>> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
>>> index 0376c50..d12ed7e 100644
>>> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
>>> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
>>> @@ -27,6 +27,7 @@
>>>    	};
>>>
>>>    	memory {
>>> +		/* 512MB by default, will be updated by U-Boot */
>>>    		reg = <0x40000000 0x20000000>;
>>>    	};
>>>
>>
>> This seems wrong (copy paste from A13 error) I've a10s boards with 1G, and the data
>> sheet claims 2GB max RAM.
>
> I had expected these values to contain the minimum -- i.e. the one which
> would work everywhere, so it would work if for some reason u-boot wasn't
> updating correctly. Better to boot with only some of the RAM than to
> crash randomly.

Then all the other values would be wrong, we've A10 boards with only 512M, A13
boards with only 256, etc.

Anyways as said before lets wait for Maxime's input on this.

Regards,

Hans
