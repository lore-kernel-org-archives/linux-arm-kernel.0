From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Aug 2018 16:41:09 +0800
Subject: [PATCH v3 0/4] allwinner: a64: add SRAM controller / system
 control
In-Reply-To: <20180820094210.6d856029d51dad480782a783@bidouilliste.com>
References: <20180614153548.9644-1-wens@csie.org>
 <20180820094210.6d856029d51dad480782a783@bidouilliste.com>
Message-ID: <CAGb2v66Eb4EoQs44cRwSKLf7MgwOtczNS0ufbtH5bLQBK24Lzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2018 at 3:42 PM, Emmanuel Vadot <manu@bidouilliste.com> wrote:
>
>  Hello Chen-Yu,
>
> On Thu, 14 Jun 2018 23:35:44 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> Hi,
>>
>> This series is the remaining A64 syscon changes from the R40 DWMAC
>> series. The series aligns how the A64 system control exports a regmap
>> for the sun8i DWMAC driver to access with what we've done for the R40.
>>
>> Originally the A64 used the generic syscon for this bit of hardware.
>> But this block also contains mapping bits for the onboard SRAM, used
>> by various peripherals, and other vendor specific bits we may use in
>> the future. It is by no means generic. And we already have a device
>> tree binding and driver for the SRAM part.
>>
>> The first patch make the SRAM control device export a regmap, exposing
>> a single EMAC control register, for the DWMAC driver to consume.
>>
>> The second and third patches rename the A64 compatible string to read
>> "system control", which is what the block is named in the user manual.
>>
>> The last patch fixes up the device node, and also adds the lone mappable
>> SRAM block, which is needed by the Display Engine.
>>
>> Changes since v2:
>>
>>   - changed the compatible string from "*-sram-controller" to
>>     "*-system-control"
>>
>>
>> ChenYu
>>
>> Chen-Yu Tsai (2):
>>   dt-bindings: sram: Rename A64 SRAM controller compatible
>>   soc: sunxi: sram: Add updated compatible string for A64 system control
>>
>> Icenowy Zheng (2):
>>   soc: sunxi: export a regmap for EMAC clock reg on A64
>>   arm64: dts: allwinner: a64: add SRAM controller device tree node
>>
>>  .../devicetree/bindings/sram/sunxi-sram.txt   |  3 +-
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 19 +++++-
>>  drivers/soc/sunxi/sunxi_sram.c                | 61 ++++++++++++++++++-
>>  3 files changed, 78 insertions(+), 5 deletions(-)
>>
>> --
>> 2.17.1
>
>  I wish to have seen this serie before as it have some inconsistencies.
>
>  In patch 2 you renamed allwinner,sun50i-a64-sram-controller to
> allwinner,sun50i-a64-system-control but the former was never used in
> the DTS, the compatible used was allwinner,sun50i-a64-system-controller.
>  You also say that you've never seen use of it. How can you make that
> claim ? There is a lot of downstream users of DTS now (FreeBSD, NetBSD,
> OpenBSD and even RiscOS and Haiku iirc), it's not just Linux.

The original "a64-sram-controller" was never used in any upstream device
tree, be it Linux or U-boot. Since the projects you listed all derive
their device trees from U-boot, with maybe some extra devices on top,
they would either have had the "system-controller" version, or the even
earlier version in U-boot where the emac node just lists the syscon
address range as its own.

U-boot has the latter "system-controller" because it was copied from Linux.
The original use-case was a SoC-specific compatible string followed by the
very generic "syscon". The latter "syscon" binding is what we actually
support in Linux and U-boot. Same goes for NetBSD and OpenBSD.

IMHO FreeBSD could also move to a generic syscon API, instead of
"system-controller" for sunxi and "grf" for rockchip.

You can continue to support old device trees and the unlisted compatible
through the generic "syscon" fallback. For the updated device tree you will
have to support the new compatible, along with supporting the SRAM mappings.
The SRAM mappings are why the "syscon" compatible was removed. It just
doesn't fit the semantics described by the "syscon" binding.

>  Also this compatible is currently the one used in the u-boot dts,
> which mean that users of the embedded DTB use or can use it (which is
> the default for EFI users of U-Boot).

As mentioned above, the old device tree uses the syscon binding, which
you can continue to support. The new binding is add support for the SRAM
mapping system. In addition, you probably don't want two device drivers
supporting the same compatible string. On Linux it's even worse, because
the "syscon" driver sidesteps the device model and isn't an actual device
driver.

Regards
ChenYu
