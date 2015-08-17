From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Aug 2015 11:35:30 -0700
Subject: [PATCH 6/7] ARM: bcm2835: Add the DDC I2C controller to the
 device tree.
In-Reply-To: <55CEC567.109@wwwdotorg.org>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-7-git-send-email-eric@anholt.net>
 <55CEC567.109@wwwdotorg.org>
Message-ID: <871tf1wyod.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 08/12/2015 06:56 PM, Eric Anholt wrote:
>> We need to use it for getting video modes over HDMI.
>
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>
>> +		i2c2: i2c at 7e805000 {
>> +			compatible = "brcm,bcm2835-i2c";
>> +			reg = <0x7e805000 0x1000>;
>> +			interrupts = <2 21>;
>> +			clocks = <&clk_i2c>;
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>
> In an SoC .dtsi file, you'd typically write:
>
> 	status = "disabled";
>
> ... in all nodes that represent IO controllers that interface to
> external HW, so that board DT files can/must explicitly choose to enable
> the device if it's actually in use on the board. Some systems might not
> have HDMI and hence might not hook up the HDMI_SCL/SDA pads.
>
> BCM2835-ARM-Peripherals.pdf states "Note that the BSC2 master is used
> dedicated with the HDMI interface and should not be accessed by user
> programs.". Does this imply the Linux kernel shouldn't be touching this
> I2C controller; that the VC4 firmware might also be attempting to use
> it? I wonder how any such sharing of the HW would work.

In order for *any* of this driver to work, we need to ensure that the
firmware doesn't try to write to the corresponding part of the hardware.
DDC I2C is no different.  All that will cause the firmware to do
anything with display is generating mbox/dispmanx requests (through the
firmware driver), and the undervoltage warnings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150817/39e1921f/attachment-0001.sig>
