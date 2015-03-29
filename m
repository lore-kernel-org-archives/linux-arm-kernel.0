From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 30 Mar 2015 00:54:27 +0200
Subject: [PATCH RFC] ARM: BCM5301X: Add /device_id property including
 device ID string
In-Reply-To: <20150329223602.GD24899@n2100.arm.linux.org.uk>
References: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
 <20150329223602.GD24899@n2100.arm.linux.org.uk>
Message-ID: <CACna6rwYnUE6UBWSwqb2x3wLPkJjR451SwBMJ=otLFH7nhq4mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 00:36, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 30, 2015 at 12:14:48AM +0200, Rafa? Mi?ecki wrote:
>> Device vendors often assign IDs to their devices to allow comparing
>> firmware image with device model. This is required to prevent users
>> from flashing incompatible image and soft-bricking device.
>> Add device_id property to DTs to allow user space (and optionally
>> bootloader) verifying firmware images.
>>
>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>> ---
>> Hi guys,
>>
>> I think my commit message explains pretty well what I'm trying to do,
>> however I'm not sure if I'm using a right place for that.
>> I also didn't document this news property, as I can't find a place
>> where root-properties are currenty described. Is there any such place?
>> I couldn't find a file describing e.g. "model" property.
>
> What does this do which the top-level "compatible" doesn't do?

Let me just answer to this one, it should make rest answers redundant.
I obviously forgot to explain what was clear to me.

What we use in "compatible" is some sane-looking string describing
machine in a friendly way. Why my patch adds is some vendor-picked ID
which is more like a MAGIC specific for a device.

If you download firmware image from vendor's site (Netgear, Asus,
others too), it includes some extra header/tail with a vendor picked
ID (or better: MAGIC). Vendor's bootloader and default-firmware-web-UI
requires that MAGIC or will reject the firmware. It also means that:

1) Generating device-compatible (and so flashable) firmware (like
OpenWrt or similar) requires using the same vendor-picked MAGIC.

2) Flashing vendor-provided firmware image from custom firmware (e.g.
OpenWrt) requires comparing provided file with a device-specific
MAGIC. Since vendors (Netgear, Asus, others) provide firmwares with
their own picked MAGICs, we can't compare them against
"asus,rt-ac68u", "netgear,r6250v1", or whatever we use. That also
means comparing it against some more-or-less silly strings like
"U12H245T00_NETGEAR".

Let me know if that explains my purpose of device_id a bit.

-- 
Rafa?
