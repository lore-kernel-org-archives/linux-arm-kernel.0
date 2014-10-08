From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 08 Oct 2014 14:36:14 +0400
Subject: [PATCH v3 2/2] ARM: shmobile: lager: enable HS-USB
In-Reply-To: <5434C2B6.2030008@renesas.com>
References: <2438577.UAUDMkTTWI@wasted.cogentembedded.com>
 <2298118.7qjLAFjuvd@wasted.cogentembedded.com> <5434C2B6.2030008@renesas.com>
Message-ID: <5435139E.3090604@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/2014 8:51 AM, Yoshihiro Shimoda wrote:

>> Enable HS-USB device for the Lager board, defining the GPIO that the driver
>> should check when probing. Since this board doesn't have the OTG ID pin, we
>> assume that GP5_18 (USB0_PWEN) is an ID pin because it is 1 when the SW5 is
>> in position 2-3 (meaning USB function) and 0 in other positions.

> < snip >
>> Index: renesas/arch/arm/boot/dts/r8a7790-lager.dts
>> ===================================================================
>> --- renesas.orig/arch/arm/boot/dts/r8a7790-lager.dts
>> +++ renesas/arch/arm/boot/dts/r8a7790-lager.dts
>> @@ -226,6 +226,11 @@
>>   		renesas,function = "usb0";
>>   	};
>>
>> +	hsusb_pins: usb0 {
>> +		renesas,groups = "usb0_ovc_vbus";
>
> Thank you for the v3 patch.
> I tested this, and kernel log said "GP_5_19 already requested".

    GP5_19 is also USB0_OVC_VBUS. It's used by PCI [EO]HCI.

> However, the hsusb on lager uses GP_5_18. Is this correct behavior?

    Yes, this error needs to be ignored (I wrote about that in the changelog 
but you cut out that part). If you disable the internal PCI driver, this error 
will disappear.

> sh-pfc e6060000.pfc: pin GP_5_19 already requested by ee090000.pci; cannot claim for e6590000.usb
> sh-pfc e6060000.pfc: pin-179 (e6590000.usb) status -22
> sh-pfc e6060000.pfc: could not request pin 179 (GP_5_19) from group usb0_ovc_vbus  on device sh-pfc

    The kernel log already tells you well about the source of error.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei
