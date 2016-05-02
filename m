From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 02 May 2016 12:49:16 +0200
Subject: [RFT PATCH 1/3] usb: misc: usb3503: Fix HUB mode after bootloader
 initialization
In-Reply-To: <57272298.50701@samsung.com>
References: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
 <1461927591-7864-2-git-send-email-k.kozlowski@samsung.com>
 <20160429113059.GX3217@sirena.org.uk> <57234BA2.6020304@samsung.com>
 <20160429164448.GY3217@sirena.org.uk> <57272298.50701@samsung.com>
Message-ID: <572730AC.4030602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 11:49 AM, Krzysztof Kozlowski wrote:
> On 04/29/2016 06:44 PM, Mark Brown wrote:
>> On Fri, Apr 29, 2016 at 01:55:14PM +0200, Krzysztof Kozlowski wrote:
>>> On 04/29/2016 01:30 PM, Mark Brown wrote:
>>
>>>> Supplies are only optional if they may be physically absent.  In this
>>>> case it's possible that on device regulators may be used instead, a
>>>> pattern more like that used for arizona-ldo1 where we represent those
>>>> regulators might be better as it's more clearly describing the
>>>> situation.  I'm just wondering if the supply lookup stuff there should
>>>> be factored out as this is not an uncommon pattern..
>>
>>>> It should at least be clearly stated what's going on, ignoring failure
>>>> to get supplies is generally a bug and people will tend to blindly cut
>>>> and paste things (witness all the breakage in graphics drivers with
>>>> this).
>>
>>> The VDD33 is really optional. The device can work in different
>>> configuration, e.g. only on VBAT. How the reset logic would work then? I
>>> don't know... I would suspect that it could be exactly the same (just
>>> replace VDD33 with VBAT) but I am not sure.
>>
>> What the Arizona example I mentioned does is look for the property
>> specifying an external supply in DT and if there isn't one assumes that
>> it must be using the internal regulator.  That's a bit icky but it does
>> the right thing and is much simpler from a user point of view.
> 
> Okay, that indeed looks similar... in case of lack of external supplies
> the usb3503 pins should be tied to the internal regulators.
> 
> However it seems I was wrong at the beginning. We've been looking here
> at the schematics and the datasheet. The design is unfortunately a
> little bit confusing but finally I think we got the impression how does
> it work.
> 
> This VDD regulator supply actually is not a usb3503 USB HUB regulator
> supply... but a supply to the LAN attached to this HUB. Regulator off/on
> is needed for LAN to show up. The hub will show up with typical reset
> (which is also missing before my patchset btw).
> 
> The LAN, as a USB device, is auto-probed so it cannot take the regulator
> and play with it. The simplest idea I have is to add it as "external
> supply"  to the parent: usb3503.

I run some more tests which adds more confusion. If the usb3503 hub does
not turn off/on the supply (LAN regulator supply in reality) it usually
does not show up as USB device (lsusb) neither. In such case sometimes
it is present, sometimes not.

"Hardware" reset with regulator fixes all the problems: with LAN and
with USB hub... It really does not match the schematics but apparently
usb3503 also needs the regulator.

Best regards,
Krzysztof
