From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Nov 2013 11:19:31 +0100
Subject: [PATCH 0/4] wire up CPU features to udev based module loading
Message-ID: <1384165175-16134-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements automatic module loading based on optional CPU features,
and tries to do so in a generic way.

Typical usage would look like this:

static struct cpu_feature mod_cpu_feature[] = {
	{ HWCAP_CRC32 },
	{}
};
MODULE_DEVICE_TABLE(cpu, mod_cpu_feature);

where (on the arm64 arch) the module in question would be loaded automatically
if the CPU has support for the optional CRC instructions. [Note that the example
is based on a pending patch by Steve Capper: 'arm64: Add hwcaps for crypto and
CRC32 extensions']

Changes wrt RFC version of this series:
- this time, instead of doing something entirely separate for non-x86 archs, the
  new generic modalias version allocates enough bits to cover all x86 features
  (320+), and the x86 version was tweaked to resemble the generic one more
  closely (i.e., both use 'cpu:type:...:feature:...' now)
- removed the weak and alias GCC attribute foo

Ard Biesheuvel (4):
  x86: move arch_cpu_uevent() to generic code
  cpu: advertise CPU features over udev in a generic way
  x86: align with generic cpu modalias
  arm64: advertise CPU features for modalias matching

 arch/arm64/Kconfig                |  3 +++
 arch/arm64/kernel/setup.c         | 20 ++++++++++++++++++++
 arch/x86/kernel/cpu/match.c       | 14 +-------------
 drivers/base/cpu.c                | 15 ++++++++++++++-
 include/linux/cpu.h               |  1 -
 include/linux/mod_devicetable.h   | 11 +++++++++++
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 20 +++++++++++++++-----
 8 files changed, 67 insertions(+), 20 deletions(-)

-- 
1.8.3.2
