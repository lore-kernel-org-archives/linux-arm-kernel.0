From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 12 Jun 2014 18:58:26 +0300
Subject: [PATCH 0/3] Use Tegra's microsecond counter for udelay()
Message-ID: <1402588713-18766-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces support for Tegra's microsecond counter as the
udelay() timer. This is useful on Tegra SoCs which do not have an arch timer
such as Tegra20 and Tegra30. Using the microsecond counter instead of a delay
based loop avoids potential problems during cpu frequency changes.

The set consists of 3 patches:

Patch 1 introduces a new call which is used by the ARM architecture delay
timer code to prevent changing the delay timer after calibration is finished
and thus can be in use.

Patch 2 adds logic to choose the delay timer with the highest resolution. This
allows the same registration code to be used on all Tegra SoCs and yet use the
higher resolution arch timer when available (eg on Tegra114 or Tegra124).

Patch 3 adds the actual delay timer code.

Patch set has been verified on ventana (Tegra20), beaver (Tegra30),
dalmore (Tegra114) and jetson TK1 (Tegra124).

Changes since v1:
* Address review comments

What needs to be done to make progress on this one? I think it's really useful
to have this when CPU DVFS is available.

Peter De Schrijver (3):
  kernel: add calibration_delay_done()
  ARM: choose highest resolution delay timer
  clocksource: tegra: Use us counter as delay timer

 arch/arm/lib/delay.c                |   26 ++++++++++++++++++++++----
 drivers/clocksource/tegra20_timer.c |   13 +++++++++++++
 init/calibrate.c                    |   11 +++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
1.7.7.rc0.72.g4b5ea.dirty
