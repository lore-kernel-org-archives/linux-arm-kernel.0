From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Jul 2013 23:27:55 +0100
Subject: [PATCH, re-send] Always trap on BUG()
In-Reply-To: <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
References: <201307051738.35930.arnd@arndb.de>
 <20130715151612.9499c2b2ad40e88d183a4600@linux-foundation.org>
Message-ID: <20130715222755.GY24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 03:16:12PM -0700, Andrew Morton wrote:
> I've been thinking for a while that CONFIG_BUG=n is a pretty dumb thing
> to do, and that maintaining it (and trying to fix the warnings it
> produces) aren't worth the effort and that we should remove the whole
> thing.  Perhaps your patch changes that calculus, dunno.  Please discuss.

This isn't about introducing "CONFIG_BUG=n" - this is about making a
kernel with CONFIG_BUG=n build without producing tonnes and tonnes of
warnings, as it does today.  It makes building randconfig pretty
useless to find what could be more important warnings.

For example, this is a small extract from one such build log that
randconfig decided to set CONFIG_BUG to n:

fs/ext4/extents.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/ext4_jbd2.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/mballoc.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/move_extent.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/indirect.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/inline.c: In function 'ext4_inode_journal_mode':
fs/ext4/ext4_jbd2.h:415:1: warning: control reaches end of non-void function
fs/ext4/acl.c: In function 'acl_by_type':
include/linux/posix_acl.h:108:1: warning: control reaches end of non-void function
fs/ext4/acl.c: In function 'ext4_get_acl':
fs/ext4/acl.c:150:6: warning: 'name_index' may be used uninitialized in this funtion
