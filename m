From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  3 Oct 2017 14:10:16 +0900
Subject: [PATCH v4 0/3] arm64: kgdb: fix single stepping
Message-ID: <20171003051019.29714-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth version of my kgdb patch to fix issues on single
stepping.

Kgdb support on arm64 was merged in v3.15, but from its first appearance,
as far as I know, "single step" has never worked well. This patchset
addresses all the error cases I found so far.
Issues are reproducable, at least, on Hikey and fast model and I tested
the patch on both of them.

The original patch[1] was split into several pieces, patch #1/#2 (and
v3's patch#2), addressing issues one by one, but I dropped v3's patch#2
here because Will really doesn't like a way to fix.
Instead, I propose that we should do the same thing with a *gdb macro*
shown in patch #1 so that we can optionally disable interrupts while
single stepping.

Regarding to patch #3, I'm not still sure whether it is a right fix,
but it certainly fixes some corner case.


Changes in v4 (Oct 3, 2017):
* remove v3's patch#2 (disable interrupts while single stepping)

Changes in v3 (May 23, 2017):
* simplify patch #1 to respect the original code
* swap patch #2 and #3
* add patch #4

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295632.html

AKASHI Takahiro (3):
  arm64: kgdb: fix single stepping
  arm64: kgdb: prevent kgdb from being invoked recursively
  kgdb: select a correct cpu while in a single stepping

 arch/arm64/kernel/kgdb.c  | 42 ++++++++++++++++++++++++++++++++++++++----
 kernel/debug/debug_core.c |  8 ++++----
 2 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.14.1
