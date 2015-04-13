From: harald@ccbib.org (harald at ccbib.org)
Date: Mon, 13 Apr 2015 07:59:29 +0200
Subject: Bug: Toggling green led on Olinuxino Maxi, also toggles USB
In-Reply-To: <201504130118.07766.marex@denx.de>
References: <1622635769.189113.1428833170958.JavaMail.open-xchange@oxbaltgw01.schlund.de>
 <201504130118.07766.marex@denx.de>
Message-ID: <1db871b644e46516922636d7bb7635f8@imap.cosmopool.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 13 Apr 2015 01:18:07 +0200, Marek Vasut <marex@denx.de> wrote:
> On Sunday, April 12, 2015 at 12:06:10 PM, Stefan Wahren wrote:
>> Hi,
>> 
>> toggling the green LED (GPIO 65) on Olinuxino Maxi unexpectedly also
>> toggles the USB Host support.
>> 
>> Here is the console output:
>> 
>> # Switching the led off (USB drive connected)
>> echo 255 > /sys/class/leds/green/brightness
>> [  318.650000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11
>> [  318.650000] ci_hdrc ci_hdrc.0: EHCI Host Controller
>> [  318.670000] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus
>> number 1 [  318.710000] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
>> [  318.750000] hub 1-0:1.0: USB hub found
>> [  318.780000] hub 1-0:1.0: 1 port detected
>> [  319.140000] usb 1-1: new high-speed USB device number 2 using
ci_hdrc
>> [  319.310000] hub 1-1:1.0: USB hub found
>> [  319.340000] hub 1-1:1.0: 3 ports detected
>> [  319.640000] usb 1-1.1: new high-speed USB device number 3 using
>> ci_hdrc
>> [  319.880000] usb 1-1.2: new high-speed USB device number 4 using
>> ci_hdrc
>> [  320.030000] usb-storage 1-1.2:1.0: USB Mass Storage device detected
>> [  320.040000] scsi host0: usb-storage 1-1.2:1.0
>> [  321.090000] scsi 0:0:0:0: Direct-Access     LG       USB Drive      

>> 1100 PQ: 0 ANSI: 0 CCS
>> 
>> # Switching the led on (USB drive connected)
>> echo "0" > /sys/class/leds/green/brightness
>> [ 1068.890000] ci_hdrc ci_hdrc.0: remove, state 1
>> [ 1068.890000] usb usb1: USB disconnect, device number 1
>> [ 1068.920000] usb 1-1: USB disconnect, device number 2
>> [ 1068.920000] usb 1-1.1: USB disconnect, device number 3
>> [ 1069.070000] usb 1-1.2: USB disconnect, device number 4
>> [ 1069.450000] ci_hdrc ci_hdrc.0: USB bus 1 deregistered
>> [ 1074.460000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11
>> 
>> Kernel: 4.0.0-rc4-next-20150320
>> Bootloader: U-Boot 2014-10
>> 
>> Harald discovered this problem before me on Olinuxino Mini [1].
>> 
>> I think the problem has something to with USB OTG, because GPIO 65 is
on
>> the same pin for USB_OTG_ID.
>> My idea was to set "dr_mode" in olinuxino dts explicit to "host" and it
>> works, but i'm not sure that is the right fix.
>> 
>> Shouldn't chipidea driver complain about missing pinctrl or something
>> else?
> 
> Is the MX23_PAD_SSP1_DETECT pin muxed as a GPIO ? ie. you should have
such
> an
> entry in the DTS pinmux setup -- MX23_PAD_SSP1_DETECT__GPIO_2_1 .

Yes:
led_pin_gpio2_1: led_gpio2_1 at 0 {
	reg = <0>;
	fsl,pinmux-ids = <
		MX23_PAD_SSP1_DETECT__GPIO_2_1
	>;
	fsl,drive-strength = <MXS_DRIVE_4mA>;
	fsl,voltage = <MXS_VOLTAGE_HIGH>;
	fsl,pull-up = <MXS_PULL_DISABLE>;
};

> If it is, then it'd probably mean that the pin state is leaking into the
> USB
> core even if it's muxed as GPIO, in which case this would be a silicon
> problem.

Well, silicon problem or not: It is actually documented in the iMX23
Reference Manual 37.2.2: 
| Readback registers are never affected by the operation of the
| HW_PINCTRL_MUXSELx registers and always sense the actual value
| on the data pin.
|
| For example, if a pin is programmed to be a GPIO output and then
| driven high, any specialized hardware interfaces that are actively
| monitoring that pin will read the high logic value. Conversely, if
| the pin mux is programmed to give a specialized hardware interface
| such as the EMI block control of a particular pin, the current state
| of that pin can be read through its GPIO read register at any time,
| even while active EMI cycles are in progress.

So it seems like the driver has to take care not to read pins it isn't
actually in charge of.

HTH,
Harald
