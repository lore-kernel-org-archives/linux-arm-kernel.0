From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 27 Aug 2012 09:36:50 +0200
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Message-ID: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following two patches are a port from Freescale's patch

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/drivers/tty/serial/imx.c?h=imx_3.0.15_android&id=80e525d66d1818722db18e21dc7f1dc41f314156

Using a 3.6-rc3 kernel on a i.MX6 SabreLite board and increasing the
verbosity of the kernel's serial console output with some debug printk
like [1] results in two issues:

1. After some time the kernel output hangs [2]. The debugger tells us that
it hangs in drivers/tty/serial/imx.c at

...
/*
 *	Finally, wait for transmitter to become empty
 *	and restore UCR1/2/3
 */
while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
...

with permanently reading 0x1000 from USR2 while it waits for bit USR2_TXDC
(0x8).

2. Even after applying the first patch, there happens to be some garbage in the
   output [3].

Both issues are gone applying these two patches.

Note: If these patches are fine, they should go to stable, too.

Best regards

Dirk

[1]

Index: a/mm/mmap.c
===================================================================
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1290,6 +1290,9 @@ munmap_back:
 	vma->vm_pgoff = pgoff;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 
+	printk(" => mmap_region: start: 0x%08X end: 0x%08X len: %d\n",
+		(unsigned int)vma->vm_start, (unsigned int)vma->vm_end, (int)len);
+
 	error = -EINVAL;	/* when rejecting VM_GROWSDOWN|VM_GROWSUP */
 
 	if (file) {

[2]
...
=> mmap_region: start: 0x76DBC000 end: 0x76DBE000 len: 8192
=> mmap_region: start: 0x76DBE000 end: 0x76DC0000 len: 8192
=> mmap_region: start: 0x76D5C000 end: 0x76DA0000 ??
<hang, no output any more>

[3]
...
=> mmap_region: start: 0x0011C000 end: 0x0011D000 len: 4096
=> mmap_region: start: 0x00008000 end: 0x000B500f??#.??????R????r????j???????}???????????? start: 0x000BD000 end: 0x000BE000 len: 4096
=> mmap_region: start: 0x000BD000 end: 0x000BE000 len: 4096
...
