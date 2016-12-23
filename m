From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Fri, 23 Dec 2016 10:42:30 +0100
Subject: [RFT PATCH] ARM64: dts: meson-gxbb: Add reserved memory zone and
 usable memory range
In-Reply-To: <2ac01237-a7f8-5b3b-0f97-dd49ce6623fb@gmx.de>
References: <20161212101801.28491-1-narmstrong@baylibre.com>
 <09bb78ed-c8ec-d21f-d464-16e55c481d4e@gmx.de>
 <56869b90-6bee-f6ae-a7b1-884b4c0d72c0@baylibre.com>
 <2ac01237-a7f8-5b3b-0f97-dd49ce6623fb@gmx.de>
Message-ID: <90d5b5a3-6dd8-aab2-8701-112a10e3364c@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2016 11:02 AM, Heinrich Schuchardt wrote:
> On 12/14/2016 10:52 AM, Neil Armstrong wrote:
> 
>> Hi Heinrich,
>>
>> Thanks for testing and for the report,
>> we are still struggling into finding what are these zones and how to label them correctly.
>>
>> We need to identify the zones on all boards, the patch I provided works on a non-odroid-c2 and gxm and gxl boards.
>>
>> Neil
>>
> Hello Neil,
> 
> the configuration below works for me on the Hardkernel Odroid C2.
> 
> ramoops is needed for CONFIG_PSTORE_RAM.
> Debian Stretch has CONFIG_PSTORE_RAM=m. Same is true for Fedora.
> I have chosen the address arbitrarily. To accommodate 512 MB boards we
> would have to put it below 0x20000000.
> The size parameters are the same as in hisilicon/hi6220-hikey.dts and
> qcom-apq8064-asus-nexus7-flo.dts.
> 
> linux,cma is used for contiguous memory assignment. I have taken the
> align parameter from arm-src-kernel-2016-08-18-26e194264c.tar.gz
> provided by Amlogic at
> http://openlinux.amlogic.com:8000/download/ARM/kernel/ .
> See Documentation/DMA-API.txt for the usage of align.
> They use the same value 0x400000 for all GXBB boards.
> So we want to put this zone into meson-gxbb.dtsi.
> 
> secmon is used by drivers/firmware/meson/meson_sm.c.
> Amlogic uses the same address range for all 64bit boards.
> 
> 	memory at 0 {
> 		device_type = "memory";
> 		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
> 	};
> 
> 	reserved-memory {
> 		#address-cells = <0x2>;
> 		#size-cells = <0x2>;
> 		ranges;
> 
> 		ramoops at 0x23f00000 {
> 			compatible = "ramoops";
> 			reg = <0x0 0x23f00000 0x0 0x100000>;
> 			record-size = <0x20000>;
> 			console-size = <0x20000>;
> 			ftrace-size = <0x20000>;
> 		};
> 
> 		secmon: secmon {
> 			compatible = "amlogic, aml_secmon_memory";
> 			reg = <0x0 0x10000000 0x0 0x200000>;
> 			no-map;
> 		};
> 
> 		linux,cma {
> 			compatible = "shared-dma-pool";
> 			reusable;
> 			size = <0x0 0xbc00000>;
> 			alignment = <0x0 0x400000>;
> 			linux,cma-default;
> 		};
> 	};
> 
> Best regards
> 
> Heinrich Schuchardt
> 

Hello Neil,

it really makes a difference if we write

 	memory at 0 {
 		device_type = "memory";
 		linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
 	};

or

 	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x1000000 0x0 0x7f000000>;
 	};

The second version leads to failure of the Odroid C2.

When I looked at /sys/firmware/fdt I saw this difference:

--- fails
+++ works

        memory at 0 {
-               device_type = "memory";
                reg = <0x0 0x0 0x0 0x78000000>;
+               device_type = "memory";
+               linux,usable-memory = <0x0 0x1000000 0x0 0x7f000000>;
        };

I found the following sentence in the NXP forum:
In case you want to overwrite the memory usage passed from u-boot, you
can use "linux,usable-memory".
https://community.nxp.com/thread/382284

Best regards

Heinrich Schuchardt
