From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 29 Jun 2017 15:25:46 +0100
Subject: [PATCH 0/3] Miscellaneous minor compat ptrace fixes
Message-ID: <1498746379-27340-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Responding to a patch from Luc [1] to fix some sparse warnings, Will
reported conflicts with the arm64 tree, and looking into this I noticed
that I had introduced an inconsistency [2] into the FP{,S,C}R handling
in the compat VFP regset accessors.

In this case, the sparse warnings are actually alerting us to a real
issue, which is why [2] squashes one of those warnings, why [1]
conflicts and why the fix by [1] to the second warning is arguably
incorrect (though on initial shallow inspection of the patch it looked
fine).

These issues arise from the way the regset API handles user versus
kernel source/destination pointers, as explained in more detail in [2].


Patch 3 of this series fixes the outstanding sparse warning in a manner
more consistent with [2].

Patches 1-2 fix other minor issues that I noticed along the way, but
which are not directly related.

To avoid unintentional conflicts, the patches are based on
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
3edb1dd13ce6 ("Merge branch 'aarch64/for-next/ras-apei' into aarch64/for-next/core")

Cheers
---Dave

[1] [PATCH] arm64: fix missing __user in compat_vfp_{get,set}()
lists.infradead.org/pipermail/linux-arm-kernel/2017-June/516315.html

[2] [PATCH 1/3] arm64: ptrace: Fix VFP register dumping in compat coredumps
lists.infradead.org/pipermail/linux-arm-kernel/2017-June/514916.html

Dave Martin (3):
  arm64: ptrace: Avoid setting compat FP[SC]R to garbage if get_user
    fails
  arm64: ptrace: Remove redundant overrun check from compat_vfp_set()
  arm64: ptrace: Fix incorrect get_user() use in compat_vfp_set()

 arch/arm64/kernel/ptrace.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.1.4
