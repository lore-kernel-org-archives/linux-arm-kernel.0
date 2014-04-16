From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 15 Apr 2014 22:31:36 -0700
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
Message-ID: <1397626297-23873-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

Here is my understanding of Dave's and Russell's suggestion on [1] 
to use direct write of xol slot instructions to user space. Now 
posting patch through 'git send-email' since, as it was noted, my
mailer corrupts patches otherwise.

Note default case with __copy_to_user is NOT tested. It addresses
David's remark.

Personally, I am very concerned about this patch because it creates
writable and executable page in traced process. The way how uprobes
is implemented such page will stay in process even if all uprobes
are detached from process. IMHO it may create possible attack hole.
I would prefer to see any executable memory read-only all the time.

On top of that, at least in ARM case xol page address is not even 
randomized, which was perfectly fine with current nowrite/noread,
just execute permissions.

Patch follows this cover letter.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247763.html

Victor Kamensky (1):
  ARM: uprobes xol write directly to userspace

 arch/arm/kernel/uprobes.c |  8 ++++++++
 include/linux/uprobes.h   |  3 +++
 kernel/events/uprobes.c   | 28 +++++++++++++++++++---------
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
1.8.1.4
