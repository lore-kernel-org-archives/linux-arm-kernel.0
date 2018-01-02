From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 02 Jan 2018 16:31:32 +0100
Subject: [PATCH v2 0/8] Armada 7K/8K CP110 DT de-duplication
In-Reply-To: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 2 Jan 2018 15:55:50 +0100")
References: <20180102145558.9773-1-thomas.petazzoni@free-electrons.com>
Message-ID: <87373ocm5n.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., janv. 02 2018, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> This series aims at de-duplicating the Armada CP110 Device Tree
> description, which is currently duplicated between
> armada-cp110-master.dtsi and armada-cp110-slave.dtsi, even though they
> are almost identical. Indeed, one concept of Marvell SoCs is that they
> are made of HW blocks composed of a variety of IPs (network, PCIe,
> SATA, XOR, SPI, I2C, etc.), and those HW blocks can be duplicated
> several times within a given SoC. The Armada 7K SoC has a single CP110
> (so no duplication), while the Armada 8K SoC has two CP110. In the
> future, SoCs with more than 2 CP110s will be introduced.
>
> This duplication issue has been discussed at the DT workshop [1] in
> Prague last October, and I presented on this topic [2]. The solution
> of using the C pre-processor to avoid this duplication has been
> validated by the people present in this DT workshop, and this patch
> series simply submits what has been presented.
>
>  - The first four patches are fixes for existing
>    issues/inconsistencies in the Device Tree files. Since they don't
>    fix any visible problems, they are not marked for -stable.
>
>  - The fifth patch is a minor improvement.
>
>  - The sixth patch making use of aliases for SPI busses simply aims at
>    reducing the number of changes between the CP110 master and CP110
>    slave description, by avoiding the need for the cell-index property
>    in the SPI controller DT nodes.
>
>  - The seventh patch implements the de-duplication itself, by
>    introducing an armada-cp110.dtsi file included twice on Armada 8K
>    platforms, once for the master CP110 and once for the slave CP110.
>
>  - The last patch renames cpm to cp0 and cps to cp1, as the concept of
>    master/slave CPs does not apply to future SoCs that have more than
>    2 CPs.
>
> Changes since v1:
>
>  - Rebase on top of mvebu/dt64, since the NAND controller changes will
>    only be submitted for 4.17.
>
>  - Add patches fixing NAND related typos/inconsistencies:
>      arm64: dts: marvell: fix typos in comment describing the NAND controller
>      arm64: dts: marvell: fix compatible string list for Armada CP110 slave NAND
>
>  - Improve the de-duplication patch by removing
>    armada-cp110-master.dtsi and armada-cp110-slave.dtsi, since the
>    concept of master/slave will no longer exist when we will have more
>    than 2 CPs.
>
>  - Add a patch renaming cpm -> cp0, cps -> cp1.
>
> Best regards,
>
> Thomas
>

I applied all the series on mvebu/dt64. The only change I made was
adding a commit log to the patch 3:
"Fix the same typo duplicated in both master and slave version of
armada-cp110-*.dtsi file: s/limiation/limitation/."

Thanks,

Gregory


> [1] https://elinux.org/Device_tree_kernel_summit_2017_etherpad
> [2] https://elinux.org/images/1/14/DTWorkshop2017-duplicate-data.pdf
>
> Thomas Petazzoni (8):
>   arm64: dts: marvell: fix watchdog unit address in Armada AP806
>   arm64: dts: marvell: use lower case for unit address and reg property
>   arm64: dts: marvell: fix typos in comment describing the NAND
>     controller
>   arm64: dts: marvell: fix compatible string list for Armada CP110 slave
>     NAND
>   arm64: dts: marvell: use mvebu-icu.h where possible
>   arm64: dts: marvell: use aliases for SPI busses on Armada 7K/8K
>   arm64: dts: marvell: de-duplicate CP110 description
>   arm64: dts: marvell: replace cpm by cp0, cps by cp1
>
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  46 +--
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi       |  37 +-
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi       |   2 +-
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     |  80 ++--
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  76 ++--
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   2 +-
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi       |  80 +++-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   8 +-
>  arch/arm64/boot/dts/marvell/armada-common.dtsi     |  10 +
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 449 ---------------------
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 448 --------------------
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi      | 422 +++++++++++++++++++
>  12 files changed, 635 insertions(+), 1025 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-common.dtsi
>  delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
>  delete mode 100644 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/armada-cp110.dtsi
>
> -- 
> 2.14.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
