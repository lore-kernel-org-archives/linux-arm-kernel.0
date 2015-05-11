From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 00:17:28 +0200
Subject: [PATCH 0/3] Fix boot on Calxeda highbank
Message-ID: <1431382651-15894-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When upgrading our trusted Calxeda server to Debian Jessie recently the machine
wedged during booting the installer. Upon further investigation, this happens
due to the transition to the generic L2C infrastructure introduced in 3.16. The
generic l2x0 code unlocks the cache during setup, however the Caldexa SMC
interface doesn't seem to allow the kernel to enable enable non-secure access
to the lock registers.. Queue Imprecise aborts and a fairly unhappy machine.

First patch in this series adds a flag to indicate to the l2x0 code the
unlocking should be skipped, second patch turns that flag on for mach-highbank,
fixing this issue. Third patch adds a (empty) configure callback for the
highbank l2c, reflecting the fact that there seeminglyisn't anything to
configured via an SMC on these maches.

Sjoerd Simons (3):
  ARM: cache-l2c: Add flag to skip cache unlocking
  ARM: l2c: highbank: Skip l2c unlocking
  ARM: l2c: highbank: Add dummy configure function

 arch/arm/include/asm/outercache.h | 1 +
 arch/arm/mach-highbank/highbank.c | 9 +++++++++
 arch/arm/mm/cache-l2x0.c          | 4 +++-
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.1.4
