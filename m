From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sun, 12 Aug 2018 22:57:42 +1000
Subject: [PATCH] arm: simplify syscallnr.sh a bit
Message-ID: <20180812225742.594c7705@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tested by comparing the output of

/bin/sh ./arch/arm/tools/syscallnr.sh arch/arm/tools/syscall.tbl /tmp/xx.h common,oabi,eabi,compat

Before and after this patch.

Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/tools/syscallnr.sh | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/tools/syscallnr.sh b/arch/arm/tools/syscallnr.sh
index df3ccd0ca831..9c604697745e 100644
--- a/arch/arm/tools/syscallnr.sh
+++ b/arch/arm/tools/syscallnr.sh
@@ -9,26 +9,28 @@ fileguard=_ASM_ARM_`basename "$out" | sed \
     -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
     -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
 
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | tail -n1 | (
-    echo "#ifndef ${fileguard}
+nr=$(sed -n -E \
+    's/^([[:xdigit:]Xx]+)[[:space:]]+'"${my_abis}"'[[:space:]].*$/\1/p' "$in" |
+    sort -n | tail -n1)
+nr=$(($nr + 1))
+while [ "$(($nr / (256 * $align) ))" -gt 0 ]; do
+    align=$(( $align * 4 ))
+done
+nr=$(( ($nr + $align - 1) & ~($align - 1) ))
+
+cat <<EOF >"$out"
+#ifndef ${fileguard}
 #define ${fileguard} 1
 
 /*
  * This needs to be greater than __NR_last_syscall+1 in order to account
  * for the padding in the syscall table.
  */
-"
 
-    while read nr abi name entry; do
-        nr=$(($nr + 1))
-        while [ "$(($nr / (256 * $align) ))" -gt 0 ]; do
-            align=$(( $align * 4 ))
-        done
-        nr=$(( ($nr + $align - 1) & ~($align - 1) ))
-        echo "/* aligned to $align */"
-        echo "#define __NR_syscalls $nr"
-    done
+/* aligned to $align */
+#define __NR_syscalls $nr
+
+#endif /* ${fileguard} */
+EOF
 
-    echo ""
-    echo "#endif /* ${fileguard} */"
-) > "$out"
+exit 0
-- 
2.18.0

-- 
Cheers,
Stephen Rothwell
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180812/6500d9b0/attachment.sig>
