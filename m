From: fabrice.gasnier@st.com (Fabrice GASNIER)
Date: Fri,  7 Feb 2014 17:19:14 +0100
Subject: [RFC PATCH]  ARM: Enable imprecise external aborts earlier
Message-ID: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some HW / drivers like PCIe use imprecise aborts on ARM to detect ports
that are behind a switch, by using: hook_fault_code(16+6, ...);

At PCIe bus enumeration, imprecise aborts are not enabled. Imprecise
aborts are enabled late during bootup process, when userland
init starts. It seems unmasked later when starting userland init
process (e.g. when CPSR.A bit on arm is cleared). Aborts are deferred
until then.

Enable imprecise external aborts earlier during bootup.

Reference :
http://marc.info/?l=linux-arm-kernel&m=139118404708291&w=2

Fabrice Gasnier (1):
  ARM: Add imprecise abort enable/disable macro

 arch/arm/include/asm/irqflags.h |   33 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/smp.c           |    1 +
 arch/arm/kernel/traps.c         |    4 ++++
 3 files changed, 38 insertions(+)

-- 
1.7.9.5
