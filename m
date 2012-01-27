From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jan 2012 16:23:59 +0000
Subject: [PATCH 0/4] Various VFP fixes
Message-ID: <1327681443-16627-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've recently experienced a few VFP problems that cropped up during runs
of Peter Maydell's excellent `risu' tool:

	https://wiki.linaro.org/PeterMaydell/Risu

After lots of debugging, it became apparent that modifying the ucontext
VFP state from within a signal handler was sometimes unreliable in a
preemptible kernel.

These patches fix the problem and some others that were identified along
the way. The first in the series should probably go to -stable once it's
agreed. The others aren't as critical: patches 2 and 3 could be merged
if there's good reason to do so and the final patch is really just
pedantry.

All feedback welcome.

Cheers,

Will

Cc: Dave Martin <dave.martin@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Dave Martin (1):
  ARM: vfp: fix ptrace regset modification race

Will Deacon (3):
  ARM: vfp: flush thread hwstate before restoring context from sigframe
  ARM: vfp: flush thread hwstate before copying ptrace registers
  ARM: vfp: clear fpscr length and stride bits on return from sig handler

 arch/arm/kernel/ptrace.c |    8 +++++---
 arch/arm/kernel/signal.c |   15 ++++++++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
1.7.4.1
