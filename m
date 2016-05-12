From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 12 May 2016 18:00:07 +0200
Subject: [PATCH 3/4] ARM: dts: bcm2835: add the bcm2835-sdram-controller
 to the dt
In-Reply-To: <73859954.21004.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
 <1463056732-5607-4-git-send-email-kernel@martin.sperl.org>
 <73859954.21004.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
Message-ID: <0DF5210B-0269-4E49-A8E4-A4A83FCAABCF@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 12.05.2016, at 16:56, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi,
> 
>> kernel at martin.sperl.org hat am 12. Mai 2016 um 14:38 geschrieben:
>> 
>> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Add the bcm2835 sdram controller to the device tree.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>> index 8aaf193..9db9d97 100644
>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>> @@ -22,6 +22,12 @@
>> 		#address-cells = <1>;
>> 		#size-cells = <1>;
>> 
>> +		memory-controller at 7e002000 {
>> +			compatible = "brcm,bcm2835-sdram";
>> +			reg = <0x7e002000 0x58>, <0x7e002800 0x58>;
> 
> where do you get these addresses?
I took this info based on the shared headers by broadcom:
https://github.com/msperl/rpi-registers/blob/master/md/README.md

And the bootrom code showed something similar that would point to
these registers.

Ic0 and ic1 register values also show the valid memory regions:
Especially IC[01]_SRC0 contains reference to the SRAM
size on the CM - 0x20000000
here the fump of devmem2: 
Value at address 0x3F00200C (0x76f3300c): 0x20000000.

But as you point out that may also be the interrupt controller for the VC4
cores?

It is probably the location where the VC4 interrupt table is situated.


> According to register documentation [1] the adresses belong to the interrupt
> controller.
> 
> Maybe 0x7ee00000 is the right address.
This would also fall in range with the cache register ranges:
0x7ee00000 SD
0x7ee01000 L2
0x7ee02000 L1 

L1 contains also IC0 and IC1 register names (L1_IC0_CONTROL et.al.)
so I guess this is what has set me in the wrong direction...

Thanks for pointing it out...

I guess I will need to amend the patchset for that?

Martin
