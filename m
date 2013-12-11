From: p.wilczek@samsung.com (Piotr Wilczek)
Date: Wed, 11 Dec 2013 14:07:34 +0100
Subject: [PATCH 3/8] device tree blob must be 4-bytes alingned
In-Reply-To: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
References: <1386767259-15693-1-git-send-email-p.wilczek@samsung.com>
Message-ID: <1386767259-15693-4-git-send-email-p.wilczek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each appended device tree blob must be 4-bytes aligned.
This patch modifies append_dtbs script to append bytes to each device tree
file so the size is multiple of 4.
When finding dtb the addres of next dtb is also aligned to 4-bytes.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Piotr Wilczek <p.wilczek@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 append_dtbs.sh |   11 +++++++++++
 dtbs.c         |    4 ++++
 2 files changed, 15 insertions(+)

diff --git a/append_dtbs.sh b/append_dtbs.sh
index 82bb463..a8a7cda 100755
--- a/append_dtbs.sh
+++ b/append_dtbs.sh
@@ -4,5 +4,16 @@ OUT="$1"
 shift
 DTBS="$*"
 
+while [ -n "$*" ]
+do
+	SIZE=`stat $1 -c %s`
+	MOD=`expr $SIZE % 4`
+	if [ $MOD -ne 0 ]; then
+		PADDING=`expr 4 - $MOD`
+		dd if=/dev/zero count=$PADDING bs=1 >> $1 2> /dev/null
+	fi
+	shift
+done
+
 cat $DTBS >>$OUT
 dd if=/dev/zero of=$OUT oflag=append conv=notrunc bs=1 count=8 #sentinel
diff --git a/dtbs.c b/dtbs.c
index 812c2ef..26e3b83 100644
--- a/dtbs.c
+++ b/dtbs.c
@@ -30,6 +30,10 @@ void *find_dtb(void *dtbs, const char *compat)
 			return d;
 
 		d = (struct fdt_header *)((char *)d + be_to_cpu(d->totalsize));
+
+		/* align to 4-bytes */
+		d = (struct fdt_header *)((((unsigned int)d + 0x3) & ~0x3));
+
 	}
 
 	return NULL;
-- 
1.7.9.5
