From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 10 Nov 2016 09:22:21 +0100
Subject: [PATCH 04/14] ARM: dts: armada-375: Fixup bootrom DT warning
In-Reply-To: <20161110001000.10619-5-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
 <20161110001000.10619-5-gregory.clement@free-electrons.com>
Message-ID: <20161110092221.0219490b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 10 Nov 2016 01:09:50 +0100, Gregory CLEMENT wrote:

> -		bootrom {
> +		bootrom at 0 {
>  			compatible = "marvell,bootrom";
>  			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;

I am still not sure whether this "0" unit address is correct compared
to the reg property being passed.

A good example of why I'm worried is the sa-sram case:

+		crypto_sram0: sa-sram0 at 0 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;

+		crypto_sram1: sa-sram1 at 0 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;

The node names should be just "sram" without a number. Indeed for UARTs
for example, you use uart at XYZ, uart at ABC and not uart0 at XYZ and
uart1 at ABC. But then, if you do that, with your scheme, you end up with
both nodes named sa-sram at 0.

Which clearly shows that the way you set this unit-address is not
correct: those two devices are mapped at completely different
locations, but you end up with an identical unit address.

I have no idea what is the rule for setting the unit address in this
case, but I'm pretty sure the rule you've chosen is not good.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
