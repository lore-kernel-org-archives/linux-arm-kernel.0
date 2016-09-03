From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 3 Sep 2016 13:33:50 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i-q8-common: Add support for SDIO wifi
 controllers
In-Reply-To: <20160901203733.GI20462@lukather>
References: <20160826145236.30210-1-hdegoede@redhat.com>
 <20160826145236.30210-4-hdegoede@redhat.com> <20160829065620.GC7612@lukather>
 <724a6222-36e3-e230-5071-a7cb23c51697@redhat.com>
 <20160901203733.GI20462@lukather>
Message-ID: <1efbd549-a05b-713e-cbe2-7a5458beaaeb@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 01-09-16 22:37, Maxime Ripard wrote:
> Hi Hans,
>
> On Mon, Aug 29, 2016 at 11:46:14AM +0200, Hans de Goede wrote:
>> On 29-08-16 08:56, Maxime Ripard wrote:
>>> On Fri, Aug 26, 2016 at 04:52:36PM +0200, Hans de Goede wrote:
>>>> Most of the sun8i q8 boards have an usb wifi controller, on the
>>>> variants which use an USB wifi controller, this will result in a
>>>> couple of error msg-s in dmesg when proving the sdio bus and
>>>> an used mmc controller.
>>>>
>>>> The best way to deal with wifi on this boards really is to simply
>>>> let the kernel auto-detect usb or sdio wifi controllers, so we
>>>> will just have to live with the few errors in dmesg.
>>>
>>> No, because that grabs PINs that might or might not be supposed to be
>>> used for that, it leaves clocks and regulators enabled, which draw
>>> power, to no end. And that's even worth since most boards will not use
>>> it.
>>>
>>> You can put the definition of the nodes in the DTSI, but the final
>>> status will have to be in the (relevant) DTS.
>>
>> This is again the q8-tablet thing where china produces a new variant
>> every 2 weeks. So we've sun8i-a23-q8-tablet.dts and sun8i-a33-q8-tablet.dts
>> which try to be generic dts files for these tablets, since creating
>> a custom dts per variant is madness.
>
> This is almost unrelated, and probably some wishful thinking, but I'd
> really prefer to support *one* board properly, with all its features,
> rather than supporting every random Allwinner device with half baked
> support, because no one ever updated the DT, or there's simply no
> driver. But hey, I can't force you to work on something either :)

The q8 tablets are somewhat special, to the end consumer they
are one board, but they differ a lot per badge. These are 40 (or less)
usd tablets, which get whatever wifi / touchscreen-controller /
accelerometer which is cheapest on the Chenzen market when the
badge gets produces.

For the end user to actually figure out what is in there requires
opening the tablet, or poking around with adb to learn the exact
internals / drivers used by android.

I actually own 10 of these (3 a13, 5 a23, 2 a33) and have access
to 2 more a33 models which friends of me have, and they are *all*
different. For a list of all tablets I've see:
https://github.com/jwrdegoede/sunxi-fedora-scripts/blob/master/hansg-tablet-info

Given the price of these they are really nice to thinker with /
turn into a little normal linux touch device, so I would like to
support them as best as we can in a somewhat user-friendly
way. Also see the RFC patch for the q8-hardwaremgr I posted
recently. In the end these tablets are the "*one* board"
which I'm trying to support properly, except that they are
only one board on the outside not on the outside.

TL;DR: q8 tablets are special, but also quite popular and
I would like to support them properly, which requires
some special handling.

>> This commit puts the node in sun8i-q8-common.dtsi because the
>> A23 and A33 are pin compatible and we've tablets where the
>> only difference is the SoC soldered on there, the use the _exact_
>> same PCB and components otherwise, so we have all the sun8i q8
>> stuff in a common place for sun8i-a23-q8-tablet.dts and
>> sun8i-a33-q8-tablet.dts, those are the only users of this
>> dtsi file.
>>
>> You've already merged the bits which handle the variants with
>> an USB attached wifi module (enabling ehci0 also on boards
>> where nothing is connected). This is the counter-part for
>> PCB's which use a sdio wifi module (about 90% of all boards
>> in my experience).
>
> I'm confused. Are most boards using an USB wifi chip, like you were
> stating in your commit log, or an SDIO wifi chip like you just said?

My bad, the commit msg. is wrong of the 9 sun8i q8 tablets I've
access to only 1 uses usb wifi.

So the first part of the commit msg should read
"Most of the sun8i q8 boards have a sdio wifi controller"

>> As for turning a regulator on unnecessary, both the wifi and sdio
>> wifi solution use the same regulator, so that is already turned on
>> through the usb bits and it needs to be in either case.
>
> Ok, so indeed, that's not as bad as it sounds.
>
>> The only downside of this approach is that we either have
>> the USB controller turned on unnecessarily (in most cases)
>> or the mmc controller (in the rare A23 tablet which still
>> uses an USB wifi module).
>>
>> This all actually fits neatly into the plans to do hardware
>> autodetection for these tablets which I'm working on, in
>> this case we can just let the kernel handle things without
>> additional code (think the beaglebone capemanager) since
>> both busses are discoverable.
>>
>> Once we have the q8-hardwaremgr I'm working on and hope
>> to post an RFC of soon, we could even make that turn off
>> the unused controller (as a future enhancement).
>
> If that's on your to-do-list, that's fine by me.

I've just added it to my to-do list :)

So I assume with that done, that you are ok with taking this
patch now ? Please fixup the commit msg mistake, or let
me know if you want a v2.

Regards,

Hans
