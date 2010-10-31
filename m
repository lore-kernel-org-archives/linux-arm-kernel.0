From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Sun, 31 Oct 2010 19:21:57 +0100
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit 5bc23d32d
Message-ID: <20101031182157.GY15069@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm so far happy user of 2.6.34.7 on ts72xx(mach-ep93xx) and few days ago I've
rebased the patchset[1](kernel config[2]) against 2.6.36. All seems to work
fine, except my WiFi USB dongle, which is Belkin F6D4050v2 with Ralink rt3070
chipset. To compile the WiFi driver on 2.6.36 I've to patch it little bit,
because there was some rename of the usb_buffer_* functions in 2.6.35, so
here's my patch for 2.6.36:

+/* see http://kerneltrap.org/mailarchive/git-commits-head/2010/4/30/32383 */
+#ifndef usb_buffer_alloc
+#define usb_buffer_alloc usb_alloc_coherent
+#define usb_buffer_free usb_free_coherent
+#endif
+

Now when I try to ifup the ra0 interface on 2.6.36 the driver fails to
allocate four USB TX ring buffers (using usb_alloc_coherent), which are
actually about 200kB each. It fails all the time just at allocation of the
last, 4th buffer, it can allocate the 3 previous buffers without any problem.
It's the same behaviour always, I can reproduce it 100%. The allocation fails
at arch/arm/mm/vmregion.c:

 [...]

 37 struct arm_vmregion *
 38 arm_vmregion_alloc(struct arm_vmregion_head *head, size_t size, gfp_t gfp)

 [...]

 56         list_for_each_entry(c, &head->vm_list, vm_list) {
 57                 if ((addr + size) < addr)
 58                         goto nospc;
 59                 if ((addr + size) <= c->vm_start)
 60                         goto found;
 61                 addr = c->vm_end;
 62                 if (addr > end)
 63                         goto nospc;
 64         }

The allocation of the 4th buffer fails here and goes to nospc label. When I've
reverted commit mentioned in the subject:

    Revert "ARM: DMA coherent allocator: align remapped addresses"
    
    This reverts commit 5bc23d32d86a132b5636a48dca0fa2528ef69ff9.

the driver can now allocate the buffers and seems to work on 2.6.36. How to
proceed now? I know, that the driver is pile of crap, but it works for me(tm)
quite well on 2.6.34.7, so I don't know how to fix this. Thank you for any
suggestions.

-- ynezz

1. http://github.com/ynezz/linux-2.6/tree/ts72xx-2.6.36.y
2. http://github.com/ynezz/linux-2.6/commit/780f7c8dbe52c06c7a4610de8d09fd91f572fa56
