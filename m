From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Mar 2017 14:15:39 +0100
Subject: [PATCH v2 4/5] ARM64: dts: Prepare Realtek RTD1295 and Zidoo X9S
In-Reply-To: <20170228000327.hnenlharcmiqxkpb@rob-hp-laptop>
References: <20170223164553.3715-1-afaerber@suse.de>
 <20170223164553.3715-5-afaerber@suse.de>
 <20170228000327.hnenlharcmiqxkpb@rob-hp-laptop>
Message-ID: <c8f9941f-17ab-5db0-5f6c-186fe1a87bbf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.02.2017 um 01:03 schrieb Rob Herring:
> On Thu, Feb 23, 2017 at 05:45:51PM +0100, Andreas F?rber wrote:
>> Add initial device trees for the RTD1295 SoC and the Zidoo X9S TV box.
>>
>> The CPUs lack the enable-method property because the vendor device tree
>> uses a custom "rtk-spin-table" method and "psci" did not appear to work.
>>
>> The UARTs lack the interrupts properties because the vendor device tree
>> connects them to a custom interrupt controller. earlycon works without.
>>
>> A list of memory reservations is adopted from v1.2.11 vendor device tree:
>> 0x02200000 can be used for an initrd, 0x01b00000 is audio-related;
>> ion-related 0x02600000, 0x02c00000 and 0x11000000 are left out;
>> 0x10000000 is used for sharing the U-Boot environment; others remain
>> to be investigated.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v1 -> v2:
>>  * Dropped 0x0000000010000000 /memreserve/
>>  
>>  arch/arm64/boot/dts/Makefile                      |   1 +
>>  arch/arm64/boot/dts/realtek/Makefile              |   5 +
>>  arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts |  78 +++++++++++
>>  arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 162 ++++++++++++++++++++++
>>  4 files changed, 246 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/realtek/Makefile
>>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
>>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
>> index 080232b..78f7991 100644
>> --- a/arch/arm64/boot/dts/Makefile
>> +++ b/arch/arm64/boot/dts/Makefile
>> @@ -14,6 +14,7 @@ dts-dirs += marvell
>>  dts-dirs += mediatek
>>  dts-dirs += nvidia
>>  dts-dirs += qcom
>> +dts-dirs += realtek
>>  dts-dirs += renesas
>>  dts-dirs += rockchip
>>  dts-dirs += socionext
>> diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
>> new file mode 100644
>> index 0000000..8521e92
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/realtek/Makefile
>> @@ -0,0 +1,5 @@
>> +dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
>> +
>> +always		:= $(dtb-y)
>> +subdir-y	:= $(dts-dirs)
>> +clean-files	:= *.dtb
>> diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
>> new file mode 100644
>> index 0000000..53302bb
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
>> @@ -0,0 +1,78 @@
>> +/*
>> + * Copyright (c) 2016-2017 Andreas F?rber
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
> 
> You can use SPDX tag here instead.

Already done. :)

>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
> 
> Unless you have >4GB regions, you don't really need 2 cells here.

Correct, but using less cells than in the root node requires a ranges
mapping, and we don't have size information available for that. So I
would rather leave it like this initially.

>> +		ranges;
>> +
>> +		tee at 10100000 {
>> +			reg = <0x0 0x10100000 0x0 0xf00000>;
>> +			no-map;
>> +		};
>> +	};
> 
> 
>> +	soc {
>> +		compatible = "simple-bus";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
> 
> Same here. And use ranges to narrow the address space to what you need.

By my definition, SoC is the whole memory range.

And as pointed out in the v1 cover letter, I don't have sufficient
documentation for this chip - there's not even a general address map in
the datasheet, nor any bus information - so any attempt to restrict it
would be a wild guess and specific to the 2G .dts rather than suitable
for the generic .dtsi here.

If we had the info, I would still want to leave the soc node like this
and instead have bus sub-nodes with suitable ranges, like we did for
meson-gxbb. I don't see harm in having the .dts be a few cells larger.

>> +		ranges;
>> +
>> +		uart0: serial at 98007800 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x0 0x98007800 0x0 0x400>,
>> +			      <0x0 0x98007000 0x0 0x100>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clock-frequency = <27000000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart1: serial at 9801b200 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x0 0x9801b200 0x0 0x100>,
>> +			      <0x0 0x9801b00c 0x0 0x100>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clock-frequency = <432000000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		uart2: serial at 9801b400 {
>> +			compatible = "snps,dw-apb-uart";
>> +			reg = <0x0 0x9801b400 0x0 0x100>,
>> +			      <0x0 0x9801b00c 0x0 0x100>;
>> +			reg-shift = <2>;
>> +			reg-io-width = <4>;
>> +			clock-frequency = <432000000>;
>> +			status = "disabled";
>> +		};
>> +
>> +		gic: interrupt-controller at ff011000 {
>> +			compatible = "arm,gic-400";
>> +			reg = <0x0 0xff011000 0x0 0x1000>,
>> +			      <0x0 0xff012000 0x0 0x1000>;
> 
> You are missing some register ranges and the sizes may be wrong. Check 
> the binding doc.

I have in the meantime tested that 1k, 2k, 2k, 2k plus PPI 9 lets KVM
initialize the vGIC:

[    0.256915] kvm [1]: 8-bit VMID
[    0.256951] kvm [1]: IDMAP page: 73f000
[    0.256986] kvm [1]: HYP VA range: 800000000000:ffffffffffff
[    0.257417] kvm [1]: Hyp mode initialized successfully
[    0.257479] kvm [1]: vgic-v2 at ff014000
[    0.257554] kvm [1]: vgic interrupt IRQ1
[    0.257600] kvm [1]: virtual timer IRQ4

As usual, not yet tested with a guest for lack of proper rootfs.

Mark, is there any benefit in using a raw 0xf mask over a simple 4, when
there are only 4 CPUs? I tested the simple 4 copied from my S900,
whereas the timer based on the vendor device tree uses raw 0xf, i.e.,
simple 8. Should I change that to be consistently simple 4?

>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +		};
>> +	};
>> +};

Additionally I am dropping the irq.h include, because arm-gic.h already
does that for us.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
