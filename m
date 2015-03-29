From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Mar 2015 23:36:02 +0100
Subject: [PATCH RFC] ARM: BCM5301X: Add /device_id property including
 device ID string
In-Reply-To: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
References: <1427667288-23903-1-git-send-email-zajec5@gmail.com>
Message-ID: <20150329223602.GD24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 12:14:48AM +0200, Rafa? Mi?ecki wrote:
> Device vendors often assign IDs to their devices to allow comparing
> firmware image with device model. This is required to prevent users
> from flashing incompatible image and soft-bricking device.
> Add device_id property to DTs to allow user space (and optionally
> bootloader) verifying firmware images.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> Hi guys,
> 
> I think my commit message explains pretty well what I'm trying to do,
> however I'm not sure if I'm using a right place for that.
> I also didn't document this news property, as I can't find a place
> where root-properties are currenty described. Is there any such place?
> I couldn't find a file describing e.g. "model" property.

What does this do which the top-level "compatible" doesn't do?

> diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> index 8b62836..9d2fac4 100644
> --- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> +++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "asus,rt-ac68u", "brcm,bcm4708";
>  	model = "Asus RT-AC68U (BCM4708)";
> +	device_id = "RT-AC68U";

"asus,rt-ac68u" is more specific than your device ID - it's entirely
possible that two manufacturers could choose the same model number
for their device - matching on the model number alone is opening this
up to exactly the issue you're trying to prevent.

If you have your validator check for "asus,rt-ac68u" on such a device
rather than the magic string "RT-AC68U", it should be much better.

> diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> index 2ed9e57..98c8d63 100644
> --- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> +++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
> @@ -14,6 +14,7 @@
>  / {
>  	compatible = "netgear,r6250v1", "brcm,bcm4708";
>  	model = "Netgear R6250 V1 (BCM4708)";
> +	device_id = "U12H245T00_NETGEAR";

Here you decide to include the manufacturer at the end of the name.
If the model number is "U12H245T00" why doesn't the compatible string
reflect this?  That sounds like a mistake to me.

I quote the definition of the "compatible" property:

Property: compatible
Value type: <stringlist>
Description: The compatible property value consists of one or more
 strings that define the specific programming model for the device.
 This list of strings should be used by a client program for device
 driver selection. The property value consists of a concatenated list
 of null terminated strings, from most specific to most general. They
 allow a device to express its compatibility with a family of similar
 devices, potentially allowing a single device driver to match against
 several devices. The recommended format is ?manufacturer,model?,
 where manufacturer is a string describing the name of the manufacturer
 (such as a stock ticker symbol), and model specifies the model number.

So, checking the top-level compatible _should_ do everything you want,
provided it follows the requirements of ePAPR.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
