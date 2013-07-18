From: ml@communistcode.co.uk (Jack Mitchell)
Date: Thu, 18 Jul 2013 12:35:51 +0100
Subject: [PATCH 0/4] Enable ethernet support for SOCFPGA
In-Reply-To: <51E7B27F.2000304@communistcode.co.uk>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
 <51E7B27F.2000304@communistcode.co.uk>
Message-ID: <51E7D317.50101@communistcode.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/13 10:16, Jack Mitchell wrote:
> On 18/07/13 00:10, dinguyen at altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Hello,
>>
>> These 4 patches are meant to enable ethernet and SD/MMC for the SOCFPGA
>> platform.
>>
>> patch (1/4): Adds select ARM_TWD for the platform
>> patch (2/4): Add platform specific initialization for the ethernet
>> controller.
>> patch (3/4): Commit 25c83b5c2 added "snps,phy-addr" for getting the
>> PHY addr.
>>          Set the ethernet clocks to be emac_0_clk and emac_1_clk so it
>> be gated.
>> patch (4/4): Update defconfig to support SD/MMC, ethernet, EXT3 and NFS.
>>
>> Thanks,
>>
>> Dinh Nguyen (4):
>>    arm: socfpga: Enable ARM_TWD for socfpga
>>    arm: socfpga: Add platform initialization for ethernet
>>    ARM: socfpga: dts: Fix entries for the ethernet entries.
>>    arm: socfpga: Add support for SD/MMC and ethernet to defconfig
>>
>>   arch/arm/boot/dts/socfpga.dtsi         |    4 +-
>>   arch/arm/boot/dts/socfpga_cyclone5.dts |    2 +-
>>   arch/arm/configs/socfpga_defconfig     |    8 +++
>>   arch/arm/mach-socfpga/Kconfig          |    1 +
>>   arch/arm/mach-socfpga/core.h           |    8 +++
>>   arch/arm/mach-socfpga/socfpga.c        |   85
>> +++++++++++++++++++++++++++++++-
>>   6 files changed, 104 insertions(+), 4 deletions(-)
>>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Olof Johansson <olof@lixom.net>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Cc: Pavel Machek <pavel@denx.de>
>> Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>
>>
> 
> Hi Dinh,
> 
> What tree is this based against, or what patches are a pre-requisite to
> this series? I applied the patches to linux-arm/master but the compile
> failed.
> 
> arch/arm/mach-socfpga/socfpga.c: In function 'ksz9021rlrn_phy_fixup':
> arch/arm/mach-socfpga/socfpga.c:85:21: error:
> 'MICREL_KSZ9021_EXTREG_CTRL' undeclared (first use in this function)
>    phy_write(phydev, MICREL_KSZ9021_EXTREG_CTRL,
>                      ^
> arch/arm/mach-socfpga/socfpga.c:85:21: note: each undeclared identifier
> is reported only once for each function it appears in
> arch/arm/mach-socfpga/socfpga.c:86:4: error:
> 'MICREL_KSZ9021_RGMII_RX_DATA_PAD_SCEW' undeclared (first use in this
> function)
>     MICREL_KSZ9021_RGMII_RX_DATA_PAD_SCEW | 0x8000);
>     ^
> arch/arm/mach-socfpga/socfpga.c:87:21: error:
> 'MICREL_KSZ9021_EXTREG_DATA_WRITE' undeclared (first use in this function)
>    phy_write(phydev, MICREL_KSZ9021_EXTREG_DATA_WRITE, 0x0000);
>                      ^
> arch/arm/mach-socfpga/socfpga.c:91:4: error:
> 'MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SCEW' undeclared (first use in this
> function)
>     MICREL_KSZ9021_RGMII_CLK_CTRL_PAD_SCEW | 0x8000);
>     ^
> arch/arm/mach-socfpga/socfpga.c: In function 'socfpga_cyclone5_init':
> arch/arm/mach-socfpga/socfpga.c:193:30: error: 'PHY_ID_KSZ9021RLRN'
> undeclared (first use in this function)
>    phy_register_fixup_for_uid(PHY_ID_KSZ9021RLRN,
>                               ^
> Cheers,
> Jack.
> 

Dinh,

So I found your patch "phy: micrel: Add definitions for common Micrel
PHY registers" and applied it, now the kernel compiles. I do however
still run into the "Waiting for root device" issue. This is still on my
Arrow SoCkit board, which may be a bit different to the Altera devkit;
so please don't let this be a blocker if it works find with your kit. It
is strange though that both boards can share the same 3.9-vendor
dts/kernel without any changes...

Synopsys Designware Multimedia Card Interface Driver
oprofile: no performance counters
oprofile: using timer interrupt.
TCP: cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
ThumbEE CPU extension supported.
Registering SWP/SWPB emulation handler
Waiting for root device /dev/mmcblk0p2...

Cheers,
Jack.




-- 

  Jack Mitchell (jack at embed.me.uk)
  Embedded Systems Engineer
  http://www.embed.me.uk

--
