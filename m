From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 19 Jun 2018 14:00:22 +0300
Subject: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
Message-ID: <20180619110027.16935-1-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series of patches brings initial support of Trusted Foundations to
Tegra30, that is to the consumer-grade Tegra30 devices which do not allow
to easily replace the proprietary bootloader. Support is initial because
this series implements only a proper CPU boot-up (main + secondary cores)
and a basic L2 cache maintenance that is done using the TF firmware.
Suspend-resume support is missing yet as I couldn't get it to work
(CPU hangs on resume from suspend after awhile and seems that is related
to inappropriately done cache maintenance during of suspend-resume using
the firmware), it is work-in-progress for now.

This patchset is partially based on the work done by Micha? Miros?aw [0].

[0] https://www.spinics.net/lists/linux-tegra/msg30368.html

Changelog:

v2:
	- The "Don't apply CPU erratas in insecure mode" patch got some
	  cleanup, in particular resolved the messiness in
	  __tegra_cpu_reset_handler_data.

	- Added a comment to tf_cache_write_sec(), justifying the warning
	  message.

Dmitry Osipenko (5):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Setup L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode

 arch/arm/firmware/trusted_foundations.c    | 32 ++++++++++++++++++++++
 arch/arm/include/asm/trusted_foundations.h |  7 +++++
 arch/arm/mach-tegra/reset-handler.S        | 25 +++++++++--------
 arch/arm/mach-tegra/reset.c                |  5 +++-
 arch/arm/mach-tegra/reset.h                |  9 ++++--
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 +++
 arch/arm/mach-tegra/tegra.c                | 15 ++++++++++
 7 files changed, 82 insertions(+), 15 deletions(-)

-- 
2.17.1
