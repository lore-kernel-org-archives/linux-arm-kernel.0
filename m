From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 17 May 2017 09:54:34 +0530
Subject: [PATCH v3 00/11] Broadcom Stingray SOC Initial Support
In-Reply-To: <CAOesGMiwspTuVWp8nPcWK2MhuWh8x9XSkZWJE2x=FxTCtU47Sw@mail.gmail.com>
References: <1494934256-1350-1-git-send-email-anup.patel@broadcom.com>
 <CAOesGMiwspTuVWp8nPcWK2MhuWh8x9XSkZWJE2x=FxTCtU47Sw@mail.gmail.com>
Message-ID: <CAALAos8sRb+cLeHLP4yuD5oXRP1RWn=PGCkPGEBq+6X+DdkuQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 12:23 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
>
>
> On Tue, May 16, 2017 at 4:30 AM, Anup Patel <anup.patel@broadcom.com> wrote:
>> This patchset adds initial support of Broadcom Stingray SOC
>> by reusing existing Broadcom iProc device drivers.
>>
>> Most of the patches in this patchset are DT patches except
>> the Stingray clock tree support which just one patch.
>>
>> This patchset is based on Linux-4.12-rc1 and it is also available
>> at stingray-v3 branch of https://github.com/Broadcom/arm64-linux.git
>>
>> Changes since v2:
>>  - Remove default bootargs from chosen DT node
>>  - Remove "linux" prefix from stdout DT attribute of chosen DT node
>>  - Remove use of GIC_CPU_MASK_xxx() for PPIs
>>
>> Changes since v1:
>>  - Rebased patches for Linux-4.12-rc1
>>  - Removed unwanted /memreserve/ from bcm958742-base.dtsi
>>  - Use ranges DT property to clear view of memory-layout
>>  - Make bcm-sr.h part of clock DT bindings patch
>>
>> Anup Patel (3):
>>   dt-bindings: bcm: Add Broadcom Stingray bindings document
>>   arm64: dts: Initial DTS files for Broadcom Stingray SOC
>>   arm64: dts: Add PL022, PL330 and SP805 DT nodes for Stingray
>>
>> Oza Pawandeep (1):
>>   arm64: dts: Add I2C DT nodes for Stingray SoC
>>
>> Pramod Kumar (3):
>>   arm64: dts: Add NAND DT nodes for Stingray SOC
>>   arm64: dts: Add pinctrl DT nodes for Stingray SOC
>>   arm64: dts: Add GPIO DT nodes for Stingray SOC
>>
>> Sandeep Tripathy (3):
>>   dt-bindings: clk: Extend binding doc for Stingray SOC
>>   clk: bcm: Add clocks for Stingray SOC
>>   arm64: dts: Add clock DT nodes for Stingray SOC
>>
>> Srinath Mannam (1):
>>   arm64: dts: Add PWM and SDHCI DT nodes for Stingray SOC
>>
>>  .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |  12 +
>>  .../bindings/clock/brcm,iproc-clocks.txt           |  76 ++++
>>  arch/arm64/boot/dts/broadcom/Makefile              |   1 +
>>  arch/arm64/boot/dts/broadcom/stingray/Makefile     |   6 +
>>  .../boot/dts/broadcom/stingray/bcm958742-base.dtsi | 131 ++++++
>>  .../boot/dts/broadcom/stingray/bcm958742k.dts      |  78 ++++
>>  .../boot/dts/broadcom/stingray/bcm958742t.dts      |  40 ++
>>  .../boot/dts/broadcom/stingray/stingray-clock.dtsi | 170 ++++++++
>>  .../dts/broadcom/stingray/stingray-pinctrl.dtsi    | 345 ++++++++++++++++
>>  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 460 +++++++++++++++++++++
>>  drivers/clk/bcm/Kconfig                            |   8 +
>>  drivers/clk/bcm/Makefile                           |   1 +
>>  drivers/clk/bcm/clk-sr.c                           | 300 ++++++++++++++
>>  include/dt-bindings/clock/bcm-sr.h                 | 101 +++++
>>  .../dt-bindings/pinctrl/brcm,pinctrl-stingray.h    |  68 +++
>>  15 files changed, 1797 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/Makefile
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742-base.dtsi
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742k.dts
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dts
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-clock.dtsi
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
>>  create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
>>  create mode 100644 drivers/clk/bcm/clk-sr.c
>>  create mode 100644 include/dt-bindings/clock/bcm-sr.h
>>  create mode 100644 include/dt-bindings/pinctrl/brcm,pinctrl-stingray.h
>
> Grouping as one patchset for review is fine, but when you submit this
> for merge you need to split it up:
>
> - Documentation/devicetree can go with the driver pieces or with the
> DT changes, your choice
> - DTS/DTSI changes should go through the Broadcom maintainers to arm-soc
> - clk changes should go to clk maintainers.

Only PATCH3 needs to go through clk maintainers rest all patches
are DT bindings document and DTS changes which can go through
Broadcom tree. Right ??

>
> Also, there's usually no need to split up a DT introduction and having
> separate pieces for NAND/pinctrl/GPIO/etc: They can all go in the main
> DT submission patch.

Yes, we have already squashed DTS patches from same author into
one DTS patch except NAND, PINCTRL and GPIO patches.

The NAND, PINCTRL, and GPIO patches were not squashed into
one patch for easy review but since you suggest I will squash these
three DTS patches into one DTS patch.

Regards,
Anup
