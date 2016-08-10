From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 10 Aug 2016 16:03:46 +0800
Subject: [PATCH v4 0/2] mmc: dw_mmc: host controller reset support
Message-ID: <1470816228-8874-1-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mmc host controller registers may in abnormal state if mmc is used in
bootloader, eg. to load kernel from eMMC. Some controllers cann't
clear their registers when clk is set. They use dedicated reset
logics to do this.

In this patch, a 'resets' property is added into dw_mmc dts
node. When driver does parse_dt and probe, it calls reset API to
triiger 'reset' of dwmmc host controller. When probe error or
remove, it calls reset API to assert it.

Chip vendor's actual reset logics is implemented in reset driver, not
in dw_mmc code.

Please also refer to Documentation/devicetree/bindings/reset/reset.txt

Changelog:
v4:
 * add reset_control_assert() and usleep() before calling _deassert().

Guodong Xu (2):
  Documentation: synopsys-dw-mshc: add binding for resets
  mmc: dw_mmc: add reset support to dwmmc host controller

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  4 ++++
 drivers/mmc/host/dw_mmc.c                          | 23 +++++++++++++++++++++-
 include/linux/mmc/dw_mmc.h                         |  2 ++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
1.9.1
