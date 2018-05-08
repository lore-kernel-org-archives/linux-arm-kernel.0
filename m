From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  8 May 2018 11:43:29 +0100
Subject: [PATCH 0/2] arm64: Report signal frame size to userspace via auxv
Message-ID: <1525776211-28169-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because SVE makes the arm64 signal frame size variable, userspace will
ultimately need a way to detect the size.

This series adds support for exposing this information via a new auxv
entry AT_MINSIGSTKSZ.

These patches are taken from [1], with minor updates.  (They were RFC
in that series, but there has been no significant discussion or
objections raised in the meantime, and no change in the understanding
of the problem being addressed here.  I'd like to get discussions for
binding this to glibc started.)

Changes since [1]:

 * Cache the value computed to AT_MINSIGSTKSZ so that the effort of
   computing it does not need to be repeated on every exec.


[1] [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
lists.infradead.org/pipermail/linux-arm-kernel/2017-October/539993.html

Dave Martin (2):
  arm64: signal: Report signal frame size to userspace via auxv
  arm64/sve: signal: Include SVE when computing AT_MINSIGSTKSZ

 arch/arm64/include/asm/elf.h         |  5 +++
 arch/arm64/include/asm/processor.h   |  3 ++
 arch/arm64/include/uapi/asm/auxvec.h |  3 +-
 arch/arm64/kernel/signal.c           | 68 ++++++++++++++++++++++++++++++++----
 4 files changed, 71 insertions(+), 8 deletions(-)

-- 
2.1.4
