From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Tue, 12 May 2015 09:39:13 +0200
Subject: [PATCH 0/2 v2] Fix boot on Calxeda highbank
Message-ID: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When upgrading our trusted Calxeda server to Debian Jessie recently the machine
wedged during booting the installer. Upon further investigation, this happens
due to the transition to the generic L2C infrastructure introduced in 3.16. The
generic l2x0 code unlocks the cache during setup, however the Caldexa SMC
interface doesn't seem to allow the kernel to enable enable non-secure access
to the lock registers.. Queue Imprecise aborts and a fairly unhappy machine.

First patch in this series adds detection to the l2x0 code to check if
unlocking is possible. Second patch adds a (empty) configure callback for the
highbank l2c, reflecting the fact that there seemingly isn't anything to
configured via an SMC on these maches.

Changes since v1:
 - Auto-detect when unlocking the cache is unsafe rather then requiring a
   explicit flag to be set in the machine-specific code

Sjoerd Simons (2):
  ARM: cache-l2c: Detect whether it's safe to unlock
  ARM: l2c: highbank: Add dummy configure function

 arch/arm/mach-highbank/highbank.c |  8 ++++++++
 arch/arm/mm/cache-l2x0.c          | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.1.4
