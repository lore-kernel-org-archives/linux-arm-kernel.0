From: rogershimizu@gmail.com (Roger Shimizu)
Date: Fri,  1 Sep 2017 00:36:31 +0900
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
Message-ID: <20170831153631.31026-1-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vmlinux/zImage on armel/armhf seems not an ELF, so update the script
scripts/extract-vmlinux to support such case.

This fix is tested on Debian amd64, armel, and armhf platform, with
Debian kernels.

Fixes: 09d481270d44 ("scripts: add extract-vmlinux")
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Michal Marek <mmarek@suse.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kbuild at vger.kernel.org
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---

Dear Michal, Masahiro-san, and Russell,

I posted this patch before [0] but didn't get positive response.
Recently when I trace a Debian kernel issue, I still find this patch
useful to locate the root cause [1].

Besides, it's a well known bug confuses other developers [2][3].
So I decide to submit the patch again.

[0]: https://patchwork.kernel.org/patch/8120831/
[1]: https://bugs.debian.org/870185#50
[2]: https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
[3]: https://bugs.linaro.org/show_bug.cgi?id=461

Please kindly help to review. Thank you!

Cheers,
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1

 scripts/extract-vmlinux | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index 5061abcc2540..0c72ecd24969 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -6,6 +6,7 @@
 # (c) 2009,2010 Dick Streefland <dick@streefland.net>
 #
 # (c) 2011      Corentin Chary <corentin.chary@gmail.com>
+# (c) 2016      Roger Shimizu <rogershimizu@gmail.com>
 #
 # Licensed under the GNU General Public License, version 2 (GPLv2).
 # ----------------------------------------------------------------------
@@ -15,7 +16,14 @@ check_vmlinux()
 	# Use readelf to check if it's a valid ELF
 	# TODO: find a better to way to check that it's really vmlinux
 	#       and not just an elf
-	readelf -h $1 > /dev/null 2>&1 || return 1
+	case "$2" in
+	0|"")
+		readelf -h $1 > /dev/null 2>&1 || return 1
+		;;
+	1)
+	# For ARCH like armel/armhf, vmlinux is not ELF, so we skip the check
+		;;
+	esac
 
 	cat $1
 	exit 0
@@ -31,7 +39,7 @@ try_decompress()
 	do
 		pos=${pos%%:*}
 		tail -c+$pos "$img" | $3 > $tmp 2> /dev/null
-		check_vmlinux $tmp
+		test $? -eq 0 && check_vmlinux $tmp 1
 	done
 }
 
@@ -53,7 +61,7 @@ check_vmlinux $img
 
 # That didn't work, so retry after decompression.
 try_decompress '\037\213\010' xy    gunzip
-try_decompress '\3757zXZ\000' abcde unxz
+try_decompress '\3757zXZ\000' abcde "unxz --single-stream"
 try_decompress 'BZh'          xy    bunzip2
 try_decompress '\135\0\0\0'   xxx   unlzma
 try_decompress '\211\114\132' xy    'lzop -d'
-- 
2.11.0
