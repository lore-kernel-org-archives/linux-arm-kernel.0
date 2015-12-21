From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 21 Dec 2015 11:46:18 +0100
Subject: [linux-sunxi] Re: [PATCH 4/5] ARM: dts: sun5i: Add dts file for
 the Empire Electronix D709 tablet
In-Reply-To: <CAGb2v65daCCOWf7EXDkNWnxv1idXHXesOp6Et_0h-o+9drdeMA@mail.gmail.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <1450611782-9494-4-git-send-email-hdegoede@redhat.com>
 <CAGb2v65daCCOWf7EXDkNWnxv1idXHXesOp6Et_0h-o+9drdeMA@mail.gmail.com>
Message-ID: <5677D87A.90805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-12-15 07:09, Chen-Yu Tsai wrote:
> Hi,
>
> On Sun, Dec 20, 2015 at 7:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The Empire Electronix D709 tablet is a fairly standard 7" A13 tablet,
>> featuring usb-wifi, a micro-sd slot, micro-usb otg and headphone jack.
>>
>> Empire Electronix is written on the back of the tablet, the D709 model
>> info can be found in the about tablet menu in android.
>>
>> The PCB has no markings to speak of.
>>
>> This dts file does not add support for the ft5x touchscreen found at
>> i2c bus 1, addr 0x38, irq PG11, because it does not work out of the box.
>> It seems it has been flashed with the wrong firmware and needs to have
>> alternative firmware uploaded at boot to make the touchscreen work
>> properly, when hot-booting from android into an upstream kernel the
>> touchscreen does work.
>>
>> The Memsic MXC622X accelerometer at i2c bus 1, addr 0x15 also is not
>> enabled as there is no driver for it.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/Makefile                         |   1 +
>>   .../boot/dts/sun5i-a13-empire-electronix-d709.dts  | 241 +++++++++++++++++++++
>
> The contents seem the same as sun5i-q8-common.dtsi and sun5i-a13-q8-tablet.dts.
> Any chance you could use those instead?

Given the special needs of the touchscreen I do not think that that is a good idea.

> On the side, any thoughts on how to handle the differences between various "Q8"
> tablets, like different I2C-based sensors and WiFi chips?

For i2c based sensors the plan is to use devicetree overlays + an in kernel
overlay manager which probes the i2c bus (checking known touchscreen / accelerometer
addresses) and then picks the right touchscreen + accelerometer overlays.

Wifi is somewhat more tricky I must admit, esp. since there seem to be q8 a23 based
tablet variants with usb wifi and others with sdio wifi. Since both busses are
discoverable I'm tempted to just enable both in devicetree, and let the kernel probe
and see what is actually there. This assume that the way the wifichip is powered
is the same on all boards, or at least that it is safe to enable the necessary
regulators on all boards ...

> I'm asking because with Maxime's couple-regulator we should be able to get the
> RTL8723BS on the Q8 A23/33 v1.5 working.

So this means enabled the sdio controller (should be safe on all boards?) and
enabling 2 regulators to power the wifi-chip. I think it will be safe to do this
even on boards where those regulators are not used, what do you think ?

Regards,

Hans
