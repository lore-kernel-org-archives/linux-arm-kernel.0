From: rogershimizu@gmail.com (Roger Shimizu)
Date: Mon, 28 Mar 2016 20:09:43 +0900
Subject: [PATCH] ARM: dts: orion5x: add device tree for kurobox-pro
In-Reply-To: <CAEQ9gEnt2bocGzbzs5dGW=vB7rkcgVHcL1V9Z9_dFhcEKudPAA@mail.gmail.com>
References: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
 <20160322164200.GH5250@lunn.ch>
 <CAEQ9gEniE1CGaSb46uWDdg1AU0VWEU-Eq8uVF7X7Rxn1jM+KUw@mail.gmail.com>
 <20160323021253.GB19953@lunn.ch>
 <CAEQ9gEnt2bocGzbzs5dGW=vB7rkcgVHcL1V9Z9_dFhcEKudPAA@mail.gmail.com>
Message-ID: <CAEQ9gEkMQvFGFKY2i-uGJztQc=C0qA5AsQGufmABeSMgPwuF7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 7:38 PM, Roger Shimizu <rogershimizu@gmail.com> wrote:
>
> After a few test, I found it's okay WITHOUT clock and MPP setting.
>
> The devbus_cs0 looks like:
>
> &devbus_cs0 {
>     status = "okay";
>     compatible = "marvell,orion-nand";
>     reg = <MBUS_ID(0x01, 0x1e) 0 0x400>;
>     cle = <0>;
>     ale = <1>;
>     bank-width = <1>;
>
>     partitions {
>         compatible = "fixed-partitions";
>         #address-cells = <1>;
>         #size-cells = <1>;
>
>         uImage at 0 {
>             reg = <0 0x400000>;
>             read-only;
>         };
>
>         rootfs at 400000 {
>             reg = <0x400000 0x4000000>;
>             read-only;
>         };
>
>         extra at 4400000 {
>             reg = <0x4400000 0xBC00000>;
>             read-only;
>         };
>     };
> };
>
> This probes alright.
>
> [    1.793575] nand: device found, Manufacturer ID: 0x20, Chip ID: 0xda
> [    1.800006] nand: ST Micro NAND 256MiB 3,3V 8-bit
> [    1.804765] nand: 256 MiB, SLC, erase size: 128 KiB, page size:
> 2048, OOB size: 64
> [    1.812384] Scanning device for bad blocks
> [    1.876876] Bad eraseblock 1530 at 0x00000bf40000
> [    1.889048] Bad eraseblock 1718 at 0x00000d6c0000
> [    1.901338] Bad eraseblock 1909 at 0x00000eea0000
> [    1.911572] 3 ofpart partitions found on MTD device orion_nand
> [    1.917452] Creating 3 MTD partitions on "orion_nand":
> [    1.922648] 0x000000000000-0x000000400000 : "uImage"
> [    1.931186] 0x000000400000-0x000004400000 : "rootfs"
> [    1.940139] 0x000004400000-0x000010000000 : "extra"
>
>> So you can add a node to orion5x-mv88f5182.dtsi containing these two
>> pins.
>>
>>> - how to set these address
>>
>> Not so sure here. The data sheet says CS1 uses Target Interface ID 1,
>> Target Interface Attribute 0x1d.
>>
>> In the soc ranges you want
>>
>> reg = <MBUS_ID(0x01, 0x1d) 0 0xfc000000 0x1000000>
>>
>> and in the nand node
>>
>> reg = <MBUS_ID(0x01, 0x2f) 0 0x200000>;
>
> I also tested using "devbus_cs1" with address "<MBUS_ID(0x01, 0x1d) 0
> 0x400>", but with no luck. The kernel loops output full screens of
> "Bad eraseblock XXXX at 0xYYYY" for minutes before I forcely shutdown
> the device.
>
> So it's almost sure that the NAND is on Device Bus CS0.
>
> And I have another question.
> Currently kernel probes NAND first (mtd{0,1,2}), and then jedec-flash
> device (mtd{3,4,5}).
> Can I change something in device tree to make jedec-flash first and then NAND?
>
> Here I paste the kernel log of jedec-flash:
>
> [    2.000951] Found: SST 39LF020
> [    2.004036] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
> [    2.010394] number of JEDEC chips: 1
> [    2.030787] 3 ofpart partitions found on MTD device f4000000.flash
> [    2.037066] Creating 3 MTD partitions on "f4000000.flash":
> [    2.042649] 0x000000000000-0x000000030000 : "header"
> [    2.051040] 0x000000030000-0x00000003f000 : "uboot"
> [    2.059362] 0x00000003f000-0x000000040000 : "uboot_env"

Dear Andrew,

Could you kindly help to comment, especially the final part, whether
we can have jedec-flash first?
So I can proceed the patch v2.

Thank you and looking forward to your reply!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 17B3ACB1
