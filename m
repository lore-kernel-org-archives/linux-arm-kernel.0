From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Wed, 27 Sep 2017 13:49:27 +0200
Subject: [PATCH 0/2] ARM: earlycon: Fix <CR><LF><CR> end-of-line
Message-ID: <20170927114929.9259-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since very beginning the early serial console on ARM produces <CR><LF><CR>
line terminator. There are couple of problems connected:
1. C function early_write() adds <CR> to each <LF> even though underlying
   Assembler printch() does this already
2. printch() adds <CR> *after* <LF>, not before, as it is usually being done

This patchset is tested on a Keystone2 machine (Cortex-A15) with
CONFIG_THUMB2_KERNEL=n.

Alexander Sverdlin (2):
  ARM: Make DEBUG_LL produce CRLF instead of LFCR
  ARM: early_printk: Stop emitting double CR on the console

 arch/arm/kernel/debug.S        | 11 +++++++----
 arch/arm/kernel/early_printk.c |  2 --
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.4.6
