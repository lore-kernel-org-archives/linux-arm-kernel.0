From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  7 Nov 2013 18:17:33 +0100
Subject: [RFC PATCH 0/4] wire up CPU features to udev based module loading
Message-ID: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements automatic module loading based on optional CPU features,
and tries to do so in a generic way. Currently, 32 feature bits are supported,
and how they map to actual CPU features is entirely up to the architecture.

There is some GCC attribute foo in here which people may object to, so any
suggestions on how to implement this in a cleaner way are more than welcome.

Typical usage would look like this:

static struct cpu_feature mod_cpu_feature[] = {
	{ HWCAP_NEON },
	{}
};
MODULE_DEVICE_TABLE(cpu, mod_cpu_feature);

where (on the ARM arch) the module in question would be loaded automatically if
a NEON-capable CPU is detected (and advertised).

Ard Biesheuvel (4):
  x86: move arch_cpu_uevent() to generic code
  cpu: advertise CPU features over udev in a generic way
  scripts/mod: add generic CPU features as module alias
  arm64: advertise CPU features using module aliases

 arch/arm64/Kconfig                |  3 +++
 arch/arm64/kernel/setup.c         |  2 ++
 arch/x86/kernel/cpu/match.c       | 11 -----------
 drivers/base/cpu.c                | 39 ++++++++++++++++++++++++++++++++++++++-
 include/linux/cpu.h               |  1 -
 include/linux/mod_devicetable.h   | 11 +++++++++++
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 8 files changed, 67 insertions(+), 13 deletions(-)

-- 
1.8.3.2
