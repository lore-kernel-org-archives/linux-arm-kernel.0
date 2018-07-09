From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 9 Jul 2018 12:28:52 +0200
Subject: droid 4 in v4.18-rc: grep -r adasfasd /sys/ oopses
In-Reply-To: <20180708193720.GA13262@amd>
References: <20180708174939.GA10002@amd>
 <20180708193720.GA13262@amd>
Message-ID: <20180709102852.GA20580@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > grep in /sys produces a nasty oops:
> > 
> > I guess next step is trying to find out which file that is..
> 
> Let me see...
> 
> openat(6, "suspend",
> O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) = 4
> fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> read(4, 0x4d2000, 32768)                = -1 EINVAL (Invalid argument)
> write(2, "grep: ", 6grep: )                   = 6
> write(2, "/sys/kernel/debug/pm_debug/cefus"...,
> 47/sys/kernel/debug/pm_debug/cefuse_pwrdm/suspend) = 47
> write(2, ": Invalid argument", 18: Invalid argument)      = 18
> write(2, "\n", 1
> )                       = 1
> close(4)                                = 0
> close(6)                                = 0
> openat(5, "time", O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW)
> = 4
> fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
> read(4, "cefuse_pwrdm (OFF),OFF:641441757"..., 32768) = 849
> read(4, "", 28672)                      = 0
> close(4)                                = 0
> openat(5, "count",
> O_RDONLY|O_NOCTTY|O_NONBLOCK|O_LARGEFILE|O_NOFOLLOW) = 4
> Connection to usb closed by remote host.
> Connection to usb closed.
> pavel at half:~$
> 
> Ok, so it seems to be:
> 
> user at devuan:~$ cat /sys/kernel/debug/pm_debug/count
> (oops).
> 
> The file seems to be world-readable.
> 
> user at devuan:~$ ls -al /sys/kernel/debug/pm_debug/count
> -r--r--r-- 1 root root 0 Jan  1  1970 /sys/kernel/debug/pm_debug/count
> 
> But on PC, that file does not exist.

Ok, it is easier to reproduce like this:

sudo mount /dev/zero -t debugfs /sys/kernel/debug/
sudo cat /sys/kernel/debug/pm_debug/count

I tried adding debugging like this:

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index cba72de..ed98da8 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -78,14 +78,17 @@ static int clkdm_dbg_show_counter(struct clockdomain *clkdm, void *user)
 {
 	struct seq_file *s = (struct seq_file *)user;
 
+	printk("cmp...\n");
 	if (strcmp(clkdm->name, "emu_clkdm") == 0 ||
 		strcmp(clkdm->name, "wkup_clkdm") == 0 ||
 		strncmp(clkdm->name, "dpll", 4) == 0)
 		return 0;
 
+	printk("printf...\n");	
 	seq_printf(s, "%s->%s (%d)\n", clkdm->name, clkdm->pwrdm.ptr->name,
 		   clkdm->usecount);
 
+	printk("done...\n");	
 	return 0;
 }
 
But it seems to crash outside show_counter function:

[  100.345062] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
[  102.049743] cmp...
[  102.051910] printf...
[  102.054351] done...
[  102.056579] cmp...
[  102.058685] printf...
...
[  102.319427] printf...
[  102.323211] done...
[  102.326843] ------------[ cut here ]------------
[  102.333190] WARNING: CPU: 0 PID: 2360 at
drivers/bus/omap_l3_noc.c:147 l3_int
errupt_handler+0x23c/0x380
[  102.344696] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4PER2
(Read): Da
ta Access in User mode during Functional access

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180709/37a98c8b/attachment.sig>
