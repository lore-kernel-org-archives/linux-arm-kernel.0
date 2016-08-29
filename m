From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 29 Aug 2016 11:46:14 +0200
Subject: [PATCH 3/3] ARM: dts: sun8i-q8-common: Add support for SDIO wifi
 controllers
In-Reply-To: <20160829065620.GC7612@lukather>
References: <20160826145236.30210-1-hdegoede@redhat.com>
 <20160826145236.30210-4-hdegoede@redhat.com> <20160829065620.GC7612@lukather>
Message-ID: <724a6222-36e3-e230-5071-a7cb23c51697@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 29-08-16 08:56, Maxime Ripard wrote:
> On Fri, Aug 26, 2016 at 04:52:36PM +0200, Hans de Goede wrote:
>> Most of the sun8i q8 boards have an usb wifi controller, on the
>> variants which use an USB wifi controller, this will result in a
>> couple of error msg-s in dmesg when proving the sdio bus and
>> an used mmc controller.
>>
>> The best way to deal with wifi on this boards really is to simply
>> let the kernel auto-detect usb or sdio wifi controllers, so we
>> will just have to live with the few errors in dmesg.
>
> No, because that grabs PINs that might or might not be supposed to be
> used for that, it leaves clocks and regulators enabled, which draw
> power, to no end. And that's even worth since most boards will not use
> it.
>
> You can put the definition of the nodes in the DTSI, but the final
> status will have to be in the (relevant) DTS.

This is again the q8-tablet thing where china produces a new variant
every 2 weeks. So we've sun8i-a23-q8-tablet.dts and sun8i-a33-q8-tablet.dts
which try to be generic dts files for these tablets, since creating
a custom dts per variant is madness.

This commit puts the node in sun8i-q8-common.dtsi because the
A23 and A33 are pin compatible and we've tablets where the
only difference is the SoC soldered on there, the use the _exact_
same PCB and components otherwise, so we have all the sun8i q8
stuff in a common place for sun8i-a23-q8-tablet.dts and
sun8i-a33-q8-tablet.dts, those are the only users of this
dtsi file.

You've already merged the bits which handle the variants with
an USB attached wifi module (enabling ehci0 also on boards
where nothing is connected). This is the counter-part for
PCB's which use a sdio wifi module (about 90% of all boards
in my experience). As for turning a regulator on unnecessary,
both the wifi and sdio wifi solution use the same regulator,
so that is already turned on through the usb bits and it
needs to be in either case.

The only downside of this approach is that we either have
the USB controller turned on unnecessarily (in most cases)
or the mmc controller (in the rare A23 tablet which still
uses an USB wifi module).

This all actually fits neatly into the plans to do hardware
autodetection for these tablets which I'm working on, in
this case we can just let the kernel handle things without
additional code (think the beaglebone capemanager) since
both busses are discoverable.

Once we have the q8-hardwaremgr I'm working on and hope
to post an RFC of soon, we could even make that turn off
the unused controller (as a future enhancement).

I hope this explains things.

Regards,

Hans
