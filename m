From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 15 Dec 2015 11:05:17 +0000
Subject: block layer bug with 4.4-rc3+
Message-ID: <566FF3ED.1000503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been experiencing issues with at least 4.4-rc3 (including current
HEAD) on a Calxeda Midway (4*ARM Cortex-A15 (32-bit), 8GB RAM, SATA
spinning disk or SSD).
After some disk I/O load (kernel compile with -j6) I see the kernel
screaming:

[  103.736982] ata1.00: exception Emask 0x0 SAct 0x3ffff0 SErr 0x0
action 0x6 frozen
[  103.744476] ata1.00: failed command: WRITE FPDMA QUEUED
[  103.749707] ata1.00: cmd 61/00:20:48:6b:41/08:00:0a:00:00/40 tag 4
ncq 1048576 out
[  103.749707]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  103.764659] ata1.00: status: { DRDY }
[  103.768321] ata1.00: failed command: WRITE FPDMA QUEUED
[  103.773547] ata1.00: cmd 61/98:28:48:73:41/42:00:0a:00:00/40 tag 5
ncq 8728576 out
[  103.773547]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
< repeated with increasing tag numbers>

This repeats for a while, but then seems to recover later, though I
haven't checked if there are more issues and rebooted instead to avoid
filesystem damage.

While I agree that this looks like a disk error on the first glance, I
never saw this before 4.4-rc2, had the very same error on different
nodes (with another spinning disk and even an SSD) and I can make it
vanish by reverting the commit I identified after bisection:

commit 578270bfbd2803dc7b0b03fbc2ac119efbc73195
Author: Ming Lei <ming.lei@canonical.com>
Date:   Tue Nov 24 10:35:29 2015 +0800

    block: fix segment split
...
I understand that this fix seems sane, but actually reverting it fixes
the issue for me: 4.4-rc5 crashed within some minutes with the above
log, 4.4-rc5 with 578270bfbd reverted survived 19 hours of continuous
kernel compiles without issues.
Looking at the git history of that file I see quite some recent changes
there, but it's beyond my understanding of the code to spot the real
culprit.

Can anyone point me to a change in blk-merge.c I could try to revert to
identify the real root cause? I can run tests quickly, though a real
positive case would need some hours of runtime to be sure it's fine.

Many thanks!
Cheers,
Andre.
