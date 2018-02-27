From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 27 Feb 2018 15:09:23 +0100
Subject: [PATCH 0/3] STM32 Extended TrustZone Protection driver
Message-ID: <20180227140926.22996-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
to a secure OS running in TrustZone.
We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
because read/write access will all be discarded.

Extended TrustZone Protection driver register itself as listener of
BUS_NOTIFY_BIND_DRIVER and check, given the device address, if the hardware block
could be used in a Linux context. If not it returns NOTIFY_BAD to driver core
to stop driver probing.

NOTE: patches 2 and 3 should be applied only on
git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
but until this patch: https://lkml.org/lkml/2018/2/26/386
find it way to mailine KBuild will complain about them.

Benjamin Gaignard (3):
  driver core: check notifier_call_chain return value
  dt-bindings: stm32: Add bindings for Extended TrustZone Protection
  ARM: mach-stm32: Add Extended TrustZone Protection driver

 .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  13 ++
 arch/arm/mach-stm32/Kconfig                        |   7 +
 arch/arm/mach-stm32/Makefile                       |   1 +
 arch/arm/mach-stm32/stm32-etzpc.c                  | 252 +++++++++++++++++++++
 drivers/base/dd.c                                  |   9 +-
 5 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
 create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c

-- 
2.15.0
