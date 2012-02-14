From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 08:21:29 +0000
Subject: [BUG] LPAE can be enabled with non-LPAE capable CPUs
Message-ID: <20120214082129.GD15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

The latest OMAP randconfig kautobuildv2 build has found the following issue:

arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix
arch/arm/mm/proc-v6.S:124: Error: unrecognized relocation suffix

The config file indicates:

CONFIG_CPU_V6=y
CONFIG_CPU_V7=y
CONFIG_ARM_LPAE=y

As V6 CPUs don't support LPAE, this is an invalid configuration, which
suggests that the constraints within Kconfig are insufficient for LPAE.
Should ARM_LPAE depend on CPU_V7 && !CPU_32v6 && !CPU_32v5 && !CPU_32v4T
&& !CPU_32v4 && !CPU_32v3 ?
