From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Thu, 31 Mar 2011 14:16:52 +0100
Subject: JFFS2 on intel possible recursive locking detected
Message-ID: <4D947EC4.4090504@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All, 

This is very much a heads up with far too few details.

Ultimately this doesn't seem to cause any problems on the system
bar the following warning.

It's with the flash on an intel pxa271.  Not sure exactly when
it first showed up, but has been around for a few months and
is still occurring with v2.6.39-rc1

It'll be a while before I have time to try chasing this down myself
unfortunately.

So has anyone else seen this?

[   65.627241] 
[   65.627306] =============================================
[   65.634237] [ INFO: possible recursive locking detected ]
[   65.639628] 2.6.38+ #20
[   65.642067] ---------------------------------------------
[   65.647453] jffs2_gcd_mtd2/404 is trying to acquire lock:
[   65.652838]  (&chip->mutex){+.+...}, at: [<c01ff980>] get_chip+0xf8/0x204
[   65.659757] 
[   65.659768] but task is already holding lock:
[   65.665576]  (&chip->mutex){+.+...}, at: [<c01ff4d4>] chip_ready+0x2d0/0x2f4
[   65.672654] 
[   65.672662] other info that might help us debug this:
[   65.679173] 1 lock held by jffs2_gcd_mtd2/404:
[   65.683602]  #0:  (&chip->mutex){+.+...}, at: [<c01ff4d4>] chip_ready+0x2d0/0x2f4
[   65.691123] 
[   65.691131] stack backtrace:
[   65.695629] [<c0085220>] (unwind_backtrace+0x0/0xec) from [<c00be760>] (__lock_acquire+0xfbc/0x1930)
[   65.704747] [<c00be760>] (__lock_acquire+0xfbc/0x1930) from [<c00bf134>] (lock_acquire+0x60/0x74)
[   65.713650] [<c00bf134>] (lock_acquire+0x60/0x74) from [<c02a9dc8>] (mutex_lock_nested+0x4c/0x2f0)
[   65.722602] [<c02a9dc8>] (mutex_lock_nested+0x4c/0x2f0) from [<c01ff980>] (get_chip+0xf8/0x204)
[   65.731303] [<c01ff980>] (get_chip+0xf8/0x204) from [<c0200ab4>] (do_erase_oneblock+0x48/0x1f0)
[   65.739996] [<c0200ab4>] (do_erase_oneblock+0x48/0x1f0) from [<c01feeb8>] (cfi_varsize_frob+0x198/0x250)
[   65.749472] [<c01feeb8>] (cfi_varsize_frob+0x198/0x250) from [<c020242c>] (cfi_intelext_erase_varsize+0x2c/0x54)
[   65.759627] [<c020242c>] (cfi_intelext_erase_varsize+0x2c/0x54) from [<c01f9a50>] (part_erase+0x70/0xc4)
[   65.769147] [<c01f9a50>] (part_erase+0x70/0xc4) from [<c0185514>] (jffs2_erase_pending_blocks+0x644/0x7a0)
[   65.778794] [<c0185514>] (jffs2_erase_pending_blocks+0x644/0x7a0) from [<c0183fc0>] (jffs2_garbage_collect_pass+0x22c/0x810)
[   65.789993] [<c0183fc0>] (jffs2_garbage_collect_pass+0x22c/0x810) from [<c0185a04>] (jffs2_garbage_collect_thread+0x168/0x1a0)
[   65.801385] [<c0185a04>] (jffs2_garbage_collect_thread+0x168/0x1a0) from [<c00ac238>] (kthread+0x80/0x88)
[   65.810941] [<c00ac238>] (kthread+0x80/0x88) from [<c0080b64>] (kernel_thread_exit+0x0/0x8)
