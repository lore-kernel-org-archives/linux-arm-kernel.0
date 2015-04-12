From: marex@denx.de (Marek Vasut)
Date: Mon, 13 Apr 2015 01:18:07 +0200
Subject: Bug: Toggling green led on Olinuxino Maxi, also toggles USB
In-Reply-To: <1622635769.189113.1428833170958.JavaMail.open-xchange@oxbaltgw01.schlund.de>
References: <1622635769.189113.1428833170958.JavaMail.open-xchange@oxbaltgw01.schlund.de>
Message-ID: <201504130118.07766.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, April 12, 2015 at 12:06:10 PM, Stefan Wahren wrote:
> Hi,
> 
> toggling the green LED (GPIO 65) on Olinuxino Maxi unexpectedly also
> toggles the USB Host support.
> 
> Here is the console output:
> 
> # Switching the led off (USB drive connected)
> echo 255 > /sys/class/leds/green/brightness
> [  318.650000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11
> [  318.650000] ci_hdrc ci_hdrc.0: EHCI Host Controller
> [  318.670000] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus
> number 1 [  318.710000] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
> [  318.750000] hub 1-0:1.0: USB hub found
> [  318.780000] hub 1-0:1.0: 1 port detected
> [  319.140000] usb 1-1: new high-speed USB device number 2 using ci_hdrc
> [  319.310000] hub 1-1:1.0: USB hub found
> [  319.340000] hub 1-1:1.0: 3 ports detected
> [  319.640000] usb 1-1.1: new high-speed USB device number 3 using ci_hdrc
> [  319.880000] usb 1-1.2: new high-speed USB device number 4 using ci_hdrc
> [  320.030000] usb-storage 1-1.2:1.0: USB Mass Storage device detected
> [  320.040000] scsi host0: usb-storage 1-1.2:1.0
> [  321.090000] scsi 0:0:0:0: Direct-Access     LG       USB Drive       
> 1100 PQ: 0 ANSI: 0 CCS
> 
> # Switching the led on (USB drive connected)
> echo "0" > /sys/class/leds/green/brightness
> [ 1068.890000] ci_hdrc ci_hdrc.0: remove, state 1
> [ 1068.890000] usb usb1: USB disconnect, device number 1
> [ 1068.920000] usb 1-1: USB disconnect, device number 2
> [ 1068.920000] usb 1-1.1: USB disconnect, device number 3
> [ 1069.070000] usb 1-1.2: USB disconnect, device number 4
> [ 1069.450000] ci_hdrc ci_hdrc.0: USB bus 1 deregistered
> [ 1074.460000] ci_hdrc ci_hdrc.0: timeout waiting for 00000800 in 11
> 
> Kernel: 4.0.0-rc4-next-20150320
> Bootloader: U-Boot 2014-10
> 
> Harald discovered this problem before me on Olinuxino Mini [1].
> 
> I think the problem has something to with USB OTG, because GPIO 65 is on
> the same pin for USB_OTG_ID.
> My idea was to set "dr_mode" in olinuxino dts explicit to "host" and it
> works, but i'm not sure that is the right fix.
> 
> Shouldn't chipidea driver complain about missing pinctrl or something else?

Is the MX23_PAD_SSP1_DETECT pin muxed as a GPIO ? ie. you should have such an
entry in the DTS pinmux setup -- MX23_PAD_SSP1_DETECT__GPIO_2_1 .

If it is, then it'd probably mean that the pin state is leaking into the USB
core even if it's muxed as GPIO, in which case this would be a silicon problem.

Best regards,
Marek Vasut
