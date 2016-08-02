From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 2 Aug 2016 14:56:59 -0600
Subject: [PATCH V2 RFC 6/6] ARM: dts: bcm2835: Add Raspberry Pi Zero
In-Reply-To: <1427745143.15570.152fe5dd-527b-4ad6-b2fd-e4b0af6bc2a9.open-xchange@email.1und1.de>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
 <1469559213-16160-7-git-send-email-stefan.wahren@i2se.com>
 <597f3289-91c3-7c19-8992-d6b386d50c02@wwwdotorg.org>
 <1427745143.15570.152fe5dd-527b-4ad6-b2fd-e4b0af6bc2a9.open-xchange@email.1und1.de>
Message-ID: <14206e73-c7bc-0b19-ecc9-640292c2a0c4@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2016 01:29 PM, Stefan Wahren wrote:
> Hi Stephen,
>
>> Stephen Warren <swarren@wwwdotorg.org> hat am 2. August 2016 um 19:19
>> geschrieben:
>>
>>
>> On 07/26/2016 12:53 PM, Stefan Wahren wrote:
>>> The Raspberry Pi Zero is a minified version of model A+. It's
>>> notable there is no PWR LED and the ACT LED is inverted.
>>
>> Patches 3-6,
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>>
>>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
>>> b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
>>
>> The following comment format is a bit strange, but I'm not sure there's
>> anything objectively better...
>
> the idea behind that was to provide valid values for every dr_mode with minimum
> effort. I see 2 alternative solutions:
>   a) add different dr_mode examples to the dwc2 => doesn't work for all
> platforms
>   b) add comments to drivers/usb/dwc2/platform.c => harder to find
>
> At the end the solution here is already obsolete. This patch series doesn't
> contain an update for the bcm2835_defconfig which should set the following:
>
> CONFIG_NOP_USB_XCEIV=y
> CONFIG_USB_GADGET=y
>
> After enabling these options another issue is revealed. Currently the dr_mode
> for all the other bcm283x boards isn't defined, which means "otg" instead of
> intended "host". But the dwc2 driver ignores this as long as CONFIG_USB_GADGET
> is not defined. So we need to define the dr_mode for all bcm283x boards.

Do note that the existing DTs must work with any new kernel update; 
that's part of DT being an ABI. So, there should be no need to update 
any of the existing DTs. Rather, the driver must cope with missing 
properties and operate as best it can. Perhaps that means that even if 
dr_mode is unspecified and hence defaults to otg, then if properties 
that are mandatory for OTG to operate are missing, the driver falls back 
to host mode. I think that'd be completely backwards-compatible?

 > In
> order to avoid such massive copy & paste, we better define 3 dtsi files for each
> dr_mode.

3 DT files, with an appropriate one of those included in each RPi DT, 
sounds reasonable.

> The only catch about this solution is the modes "otg" and "peripheral"
> wouldn't be referenced.

That's probably OK; in this patch the properties for those modes are in 
a comment too, so essentially unreferenced. Perhaps on RPi platforms 
where a choice is possible (Zero, A), there could be a comment next to 
the include of the "host" or "otg" version that states the user might 
want to edit the DT and include the other version instead. Then, those 
files would be somewhat referenced.
