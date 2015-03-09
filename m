From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 12:39:36 +0100
Subject: [PATCH] btrfs: fix size_t format string
Message-ID: <2448187.keuqSF9F23@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resolves a harmless gcc warning in btrfs_check_super_valid that
results from a size_t value being printed as %lu:

fs/btrfs/disk-io.c:3927:21: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]

On all Linux systems, size_t is the same length as unsigned long,
but the compiler does not know this, and warns about potentially
unportable code here. The correct printf string for size_t is %z.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ce7fca5f57ed0f "btrfs: add checks for sys_chunk_array sizes"
Cc: David Sterba <dsterba@suse.cz>
Cc: Chris Mason <clm@fb.com>
---
This warning has been rather annoying because it shows up in every
'allmodconfig' build. I assume others have reported it before, but
please apply some fix for it, ideally before 4.0.

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f79f38542a73..639f2663ed3f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3921,7 +3921,7 @@ static int btrfs_check_super_valid(struct btrfs_fs_info *fs_info,
 	}
 	if (btrfs_super_sys_array_size(sb) < sizeof(struct btrfs_disk_key)
 			+ sizeof(struct btrfs_chunk)) {
-		printk(KERN_ERR "BTRFS: system chunk array too small %u < %lu\n",
+		printk(KERN_ERR "BTRFS: system chunk array too small %u < %zu\n",
 				btrfs_super_sys_array_size(sb),
 				sizeof(struct btrfs_disk_key)
 				+ sizeof(struct btrfs_chunk));
