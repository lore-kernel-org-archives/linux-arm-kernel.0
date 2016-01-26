From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 26 Jan 2016 21:10:36 +0900
Subject: [RFC] scripts: make extract-vmlinux support ARM vmlinuz
Message-ID: <1453810236-2082-1-git-send-email-rogershimizu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vmlinuz on ARM seems is not an ELF, so scripts/extract-vmlinux
need to support such case.

This fix is tested on amd64 and armel platform.

Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
---

Dear Michal and Russell,

I'm studying ARM booting process, and happened to find scripts/extract-vmlinux
in kernel tree is broken on ARM for long time. [0][1]

[0]: https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
[1]: https://bugs.linaro.org/show_bug.cgi?id=461

The patch I created looks like dirty hack, and I don't know the status of 
whether vmlinuz is ELF or not on other platforms, so I make this as "RFC".

Please comment. Thank you!

Cheers,
Roger

 scripts/extract-vmlinux | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/extract-vmlinux b/scripts/extract-vmlinux
index 5061abcc2540..d569eb8c8efe 100755
--- a/scripts/extract-vmlinux
+++ b/scripts/extract-vmlinux
@@ -15,7 +15,15 @@ check_vmlinux()
 	# Use readelf to check if it's a valid ELF
 	# TODO: find a better to way to check that it's really vmlinux
 	#       and not just an elf
-	readelf -h $1 > /dev/null 2>&1 || return 1
+	case "$2" in
+	0|"")
+		readelf -h $1 > /dev/null 2>&1 || return 1
+		;;
+	1|*)
+	# For ARCH like ARM, vmlinux is not ELF, so we only do the check
+	# when $2 is 0 or NULL
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
2.1.4
