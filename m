From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 17:06:17 +0100
Subject: [PATCH 0/5] gcov fixes and maybe-uninitialized warnings
Message-ID: <1455293187-179811-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to address two related problems:

* getting better "variable may be used uninitialized" warnings
  in allmodconfig and randconfig builds

* improving GCOV_PROFILE support

Surprisingly, these two are related, so I have a single series that
I hope to get merged through the Kbuild tree.

I have built many thousands of ARM randconfig kernels and created
patches for every single warning and error I found, and submitted
most of them for inclusion. The "may be used uninitialized" warnings
are both the most annoying and the most helpful ones that gcc
gives us, so this tries to make them more useful, including three
steps:

1. Limit the false positives as much as we can: Aside from
   CC_OPTIMIZE_FOR_SIZE, three other options (UBSAN_SANITIZE_ALL,
   PROFILE_ALL_BRANCHES and GCOV_PROFILE_ALL) confuse the
   compiler (in versions 4.9 through 5.3, and to a lesser degree
   on older versions) so we get a lot of extra warnings. We
   already disable the warnings for CC_OPTIMIZE_FOR_SIZE, and
   this series also disables them for the other two, which are
   rarely used in practice but do show up in randconfig builds
   all the time.
2. Ensure we actually see them on 'allmodconfig' builds: Today they
   are disabled, because CC_OPTIMIZE_FOR_SIZE disables them.
   UBSAN_SANITIZE_ALL and PROFILE_ALL_BRANCHES are defined in
   a way that they don't get turned on for allmodconfig, and
   we need to do the samem for GCOV_PROFILE_ALL and
   CC_OPTIMIZE_FOR_SIZE.
3. Fix all known such warnings: The warnings should stick out,
   so we can fix them once they first appear. Today they often
   get ignored because of all the false positives.

For GCOV support, another problem showed up, resulting in an increased
risk for kernel stack overflow, aside from getting a number of
warnings about the stack size. I'm also including a patch to
address that here.

	Arnd

Arnd Bergmann (5):
  Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
  Kbuild: disable 'maybe-uninitialized' warning for
    CONFIG_PROFILE_ALL_BRANCHES
  gcov: disable for COMPILE_TEST
  gcov: disable tree-loop-im to reduce stack usage
  gcov: disable -Wmaybe-uninitialized warning

 Makefile            |  8 ++++++--
 init/Kconfig        | 13 +++++++++++++
 kernel/gcov/Kconfig |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.7.0
