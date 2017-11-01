From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:34:37 +0100
Subject: [PATCH v4 00/15] arm64: dts: renesas: r8a7795: IPMMU upstream
 integration
Message-ID: <20171101103452.7491-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT nodes for IPMMU instances on r8a7795 together with
connections to various r8a7795 on-chip devices such as Audio-DMAC, SYS-DMAC,
Ethernet-AVB, SATA and a bunch of multimedia devices that make use of FCP.

With these patches applied a white list enabled IPMMU driver may be used
to check silicon revision and then enable IPMMU in the known working cases.

The recommended IPMMU driver patch is iommu/next with the following applied:
 [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5

The final two patches in the series enable IPMMU support for all IPMMU
instances on r8a7795 that are used by IPMMU devices listed above with one
exception.  The exception is the SATA device connected to IPMMU-HC which
still is disabled pending IPMMU USB integration support. I expect IPMMU USB
integration to be handled as a second step once this series is agreed on.

The DT binding for r8a7795 has since long been included in mainline and
this series implements support following such format:

d4e42e7 iommu/ipmmu-vmsa: Add r8a7795 DT binding

Changes since V3:
 - Rework to support ES2.0
 - Other minor changes as noted in per-patch changelogs

Changes since V2:
 - Added the iommus property before power domains - thanks Geert!
 - Added reviewed-by to patch 2 and 3 from Laurent - thanks!
 - Re-added Ethernet and FCPVD patches (They were present in V1 but not V2)
 - Added remaining FCP devices such as FCPF, FCPVB and FCPVI
 - Added SATA device
 - Added final patch to enable various IPMMU devices in the DTS file

Since the DT binding has been merged quite some time ago and the interface
seems stable enough I see no reason not to queue these up for upstream merge.

This is a minor rework of work by Magnus Damm.

Based on renesas-devel-20171101-v4.14-rc7

Magnus Damm (15):
  arm64: dts: renesas: r8a7795: Add IPMMU device nodes
  arm64: dts: renesas: r8a7795-es1: Add IPMMU device nodes
  arm64: dts: renesas: r8a7795: Tie SYS-DMAC to IPMMU-DS0/1
  arm64: dts: renesas: r8a7795: Tie Audio-DMAC to IPMMU-MP0/1
  arm64: dts: renesas: r8a7795: Point DU/VSPD via FCPVD to IPMMU-VI0/1
  arm64: dts: renesas: r8a7795-es1: Point DU/VSPD via FCPVD to IPMMU-VI0
  arm64: dts: renesas: r8a7795: Point FDP1 via FCPF to IPMMU-VP0/1
  arm64: dts: renesas: r8a7795-es1: Point FDP1 via FCPF to IPMMU-VP0
  arm64: dts: renesas: r8a7795: Point VSPBC/VSPBD via FCPVB to
    IPMMU-VP0/1
  arm64: dts: renesas: r8a7795: Point VSPI via FCPVI to IPMMU-VP0/1
  arm64: dts: renesas: r8a7795-es1: Point VSPI via FCPVI to IPMMU-VP
  arm64: dts: renesas: r8a7795: Connect Ethernet-AVB to IPMMU-DS0
  arm64: dts: renesas: r8a7795: Connect SATA to IPMMU-HC
  arm64: dts: renesas: r8a7795: Enable IPMMU-VI, VP, DS0, DS1 and MM
  arm64: dts: renesas: r8a7795-es1: Enable IPMMU-MP1

 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi |  77 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi     | 173 +++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

-- 
2.11.0
