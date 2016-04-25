From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Apr 2016 17:35:26 +0200
Subject: [RESEND PATCH 0/5] gcov fixes and maybe-uninitialized warnings
Message-ID: <1461598531-2190169-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

This is a resend of a series I originally sent back in February, but
unfortunately I never heard back from you. Could you apply these
patches for v4.7?

[PATCH 1/5] Kbuild: change CC_OPTIMIZE_FOR_SIZE definition
[PATCH 2/5] Kbuild: disable 'maybe-uninitialized' warning for
[PATCH 3/5] gcov: disable for COMPILE_TEST
[PATCH 4/5] gcov: disable tree-loop-im to reduce stack usage
[PATCH 5/5] gcov: disable -Wmaybe-uninitialized warning

I've marked patch 4/5 for stable backports, please decide for
yourself if you want to send it for v4.6 right away, it's
not overly urgent but it does fix real bugs unlike the others
that just address the warning levels.

	Arnd
----
Original description:

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
