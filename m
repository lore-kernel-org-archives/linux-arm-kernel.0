From: jmcnicol@redhat.com (Jeremy McNicoll)
Date: Thu,  7 Jul 2016 17:41:03 -0700
Subject: [RFC] msm8992/msm8994: Google Nexus 5X/6P initial board support
Message-ID: <1467938467-21607-1-git-send-email-jmcnicol@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[RFC] msm8992/msm8994: Google Nexus 5X/6P initial board support

This is a pure msm8992/msm8994 SOC (BullHead/Angler) forward port from [1].
Only 1 CPU of 6(5X)/8(6P) is supported currently, running an initrd[4].  Serial
console output is fully functional through the earjack debug cable on both. [3]
This will allow others to start testing and porting other pieces of the SOC.
Myself and others are planning on submitting more functionality as more
common SOC components are mainlined and have been tested.  Gotta start some where!

Now that the initial basic board port is complete it should make it easier
for others to be able to help with additional functionality and testing.

Global clock is common between both msm8992 and msm8994. 

Layout and structure of the original 3.10 DTS was maintained and only changes
needed for mainline were made everything else got stripped out as it was
not validated.  Further more there were no bindings and thus would not
function as expected.

The initrd/image creation instructions used for testing is available here [4].

Maintainers file update was omitted and will be updated once we get acceptance of
these changes. 

Updates and additions were made in boot/dts/lge rather than boot/dts/lg as this
was the location for 3.10.

Alternatively the original 3.10 DTS SOC changes could have gone through
gregKH's staging tree as is, followed by a number of patches to make it
work correctly.   But greg's tree is for drivers only, not SOCs. ;-(


SOC info:
---------
(Nexus 5X/bullhead):
       msm8992, msm808 [see 2 below]
tested CPU: AArch64 Processor [410fd033] revision 3

(Nexus 6P/Angler):
	msm8994, msm810 [see 5 below]
tested CPU: AArch64 Processor [410fd032] revision 2


================

[1] https://android.googlesource.com/kernel/msm.git
(Nexus 5X) branch: android-msm-bullhead-3.10-marshmallow-dr1.6 
           Change-Id: I3d1ca38d518e5705b653487bfa95085873247f1c
(Nexus 6P) branch: android-msm-angler-3.10-marshmallow-mr1
	   Commit ID: 3a7f5a4e9c0f5fd4f8ee7bc3f3a204bba9dab60a

[2] http://system-on-a-chip.specout.com/l/1107/Qualcomm-Snapdragon-808-MSM8992

[3] http://people.redhat.com/jmcnicol/nexus_debug/

[4] http://people.redhat.com/~jmcnicol/InitRD.txt

[5] http://system-on-a-chip.specout.com/l/1106/Qualcomm-Snapdragon-810-MSM8994

================


Bastian K?cher (2):
  msm8994 clocks: global clock support Global clock support for the
    msm8994 SOC.
  arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support

Jeremy McNicoll (2):
  arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X) support
  arm64: dts: msm8992 default serial config

 .../devicetree/bindings/clock/qcom,gcc.txt         |    2 +
 arch/arm64/Kconfig.platforms                       |   25 +
 arch/arm64/boot/dts/Makefile                       |    2 +
 arch/arm64/boot/dts/huawei/Makefile                |    5 +
 .../boot/dts/huawei/msm8994-angler-rev-101.dts     |   41 +
 arch/arm64/boot/dts/lge/Makefile                   |    5 +
 .../boot/dts/lge/msm8992-bullhead-rev-101.dts      |   41 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |   38 +
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  221 ++
 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |   38 +
 arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi         |   31 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  237 ++
 arch/arm64/configs/angler_defconfig                |  666 ++++++
 arch/arm64/configs/bullhead_defconfig              |  377 +++
 arch/arm64/configs/msm8992_defconfig               |    5 +
 drivers/clk/qcom/Kconfig                           |    9 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-msm8994.c                     | 2501 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |  145 ++
 19 files changed, 4390 insertions(+)
 create mode 100644 arch/arm64/boot/dts/huawei/Makefile
 create mode 100644 arch/arm64/boot/dts/huawei/msm8994-angler-rev-101.dts
 create mode 100644 arch/arm64/boot/dts/lge/Makefile
 create mode 100644 arch/arm64/boot/dts/lge/msm8992-bullhead-rev-101.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8992.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-v2.0.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994.dtsi
 create mode 100644 arch/arm64/configs/angler_defconfig
 create mode 100644 arch/arm64/configs/bullhead_defconfig
 create mode 100644 arch/arm64/configs/msm8992_defconfig
 create mode 100644 drivers/clk/qcom/gcc-msm8994.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-msm8994.h

-- 
2.6.1
