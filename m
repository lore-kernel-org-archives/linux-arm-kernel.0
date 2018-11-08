From: bp@alien8.de (Borislav Petkov)
Date: Thu,  8 Nov 2018 20:41:28 +0100
Subject: [PATCH] locking/atomics: Fix out-of-tree build
Message-ID: <20181108194128.13368-1-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

Building a kernel out of tree with:

  make O=/tmp/b oldconfig
  cd /tmp/b
  make

gives this:

  CALL    /mnt/kernel/kernel/linux/scripts/atomic/check-atomics.sh
/bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
make[3]: *** [/mnt/kernel/kernel/linux/./Kbuild:86: old-atomics] Error 127
make[3]: *** Waiting for unfinished jobs....

Make the command use the proper build prerequisite which is the absolute
path to the script.

Fixes: 8d32588077bd ("locking/atomics: Check generated headers are up-to-date")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: arnd at arndb.de
Cc: aryabinin at virtuozzo.com
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: catalin.marinas at arm.com
Cc: dvyukov at google.com
Cc: glider at google.com
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linuxdrivers at attotech.com
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kbuild b/Kbuild
index 47c9fe175bd9..780048056ac5 100644
--- a/Kbuild
+++ b/Kbuild
@@ -80,7 +80,7 @@ always += old-atomics
 targets += old-atomics
 
 quiet_cmd_atomics = CALL    $<
-      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+      cmd_atomics = $(CONFIG_SHELL) $<
 
 old-atomics: scripts/atomic/check-atomics.sh FORCE
 	$(call cmd,atomics)
-- 
2.19.1
