From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 11:46:29 +0000
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <1291635442.3151.39.camel@realization>
References: <1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
	<20101206083306.GI10693@pengutronix.de>
	<1291630492.3151.14.camel@realization>
	<20101206102602.GE29563@n2100.arm.linux.org.uk>
	<1291635442.3151.39.camel@realization>
Message-ID: <20101206114629.GB31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 12:37:22PM +0100, Alberto Panizzo wrote:
> On lun, 2010-12-06 at 10:26 +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 06, 2010 at 11:14:52AM +0100, Alberto Panizzo wrote:
> > > Uwe, the following function works for me:
> > > +static void __init mx31_3ds_reserve(void)
> > > +{
> > > +       long ret;
> > > +       /* reserve MX3_CAMERA_BUF_SIZE for mx3-camera */
> > > +       mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> > > +                       /* ??? */ MX3_CAMERA_BUF_SIZE);
> > > +       memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > +       memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > +       if (!mx3_camera_base) {
> > > +               pr_err("%s: Wrong base allocation\n", __func__);
> > > +               return;
> > > +       }
> > > +       ret = memblock_reserve(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> > > +       if (ret) {
> > > +               pr_err("%s: Memory not reserved\n", __func__);
> > > +               return;
> > > +       }
> > > +}
> > > 
> > > The basic Idea is: why a region allocated, freed and removed can
> > > be declared safely as dma memory for the camera in a second time?
> > > Instead, I used the reserve API on the previous region so I am
> > > sure that region is not used by someone else before declaring it
> > > ad dma region for camera.
> > > 
> > > The ugly part of this code is that memblock_reserve want a base address
> > > that I have to decide before and I am supposing that the base address
> > > resulting from the allocate/free/remove operations, can be safely fed 
> > > to it.
> > 
> > It really is not on to have a region of memory marked as being reserved
> > and at the same time tell memblock that it's not part of the memory map.
> > When we pass this information to bootmem, we will reserve a region which
> > does not exist in the memory map.
> > 
> > Try passing memblock=debug to get a display of the memblock information
> > at boot time - and debugging a bit further from there.
> 
> Ok, I've done as you suggested and the results are the following debug:
> 
> [   17.620000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
> [   17.640000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9000000 (size 155648)
> [   17.660000] mx3-camera mx3-camera.0: mmap c7fe9cc0: q=c7f65508 4066b000-40691000 (25800) pgoff 00087800 buf 0
> [   17.690000] mx3-camera mx3-camera.0: vm_open c7fe9cc0 [count=0,vma=4066b000-40691000]
> [   17.710000] mx3-camera mx3-camera.0: __videobuf_mmap_mapper
> [   17.730000] mx3-camera mx3-camera.0: dma_alloc_coherent data is at addr c9040000 (size 155648)
> [   17.760000] mx3-camera mx3-camera.0: mmap c7d85dc0: q=c7f65508 40744000-4076a000 (25800) pgoff 00087840 buf 1
> [   17.790000] mx3-camera mx3-camera.0: vm_open c7d85dc0 [count=0,vma=40744000-4076a000]
> [   17.810000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP
> [   17.830000] mx3-camera mx3-camera.0: __videobuf_iolock memory method MMAP
> 
> The allocation goes..
> 
> [   17.860000] rw_verify_area: inode
> 
> in rw_verify_area the inode structure is NULL and from now start
> a non terming sequence of errors:
> 
> [   17.860000] Unable to handle kernel NULL pointer dereference at virtual address 00000098
> [   17.890000] pgd = c7fb8000
> [   17.900000] [00000098] *pgd=87fb4031, *pte=00000000, *ppte=00000000
> [   17.920000] Internal error: Oops: 17 [#1] PREEMPT
> [   17.920000] last sysfs file: /sys/kernel/uevent_seqnum
> [   17.920000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
> [   17.920000] CPU: 0    Not tainted  (2.6.36-10808-ga06e72c-dirty #178)
> [   17.920000] PC is at rw_verify_area+0x80/0x110
> [   17.920000] LR is at rw_verify_area+0x80/0x110
> [   17.920000] pc : [<c00a3c50>]    lr : [<c00a3c50>]    psr: 60000013
> [   17.920000] sp : c7faff30  ip : 00000000  fp : 00000003
> [   17.920000] r10: 00000001  r9 : c7fae000  r8 : c7f64820
> [   17.920000] r7 : 0000010f  r6 : 00000000  r5 : 00000000  r4 : 00000000
> [   17.920000] r3 : 00000000  r2 : 00000000  r1 : c7fae000  r0 : 0000002a
> [   17.920000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [   17.920000] Control: 00c5387d  Table: 87fb8000  DAC: 00000015
> [   17.920000] Process gst-launch-0.10 (pid: 646, stack limit = 0xc7fae268)
> [   17.920000] Stack: (0xc7faff30 to 0xc7fb0000)
> [   17.920000] ff20:                                     c7ced818 c003b7d0 c7ced6a0 c7ced6d0
> [   17.920000] ff40: c03e2ee0 c7f64820 00000000 40006000 c7faff80 0000010f 00000000 c00a44bc
> [   17.920000] ff60: c7ced6a0 c7fae000 00000000 00000000 c7f64820 40006000 0000010f c00a462c
> [   17.920000] ff80: 00000000 00000000 fc400000 00000000 0000010f 40006000 404035e0 00000004
> [   17.920000] ffa0: c0029048 c0028ea0 0000010f 40006000 00000001 40006000 0000010f 00000000
> [   17.920000] ffc0: 0000010f 40006000 404035e0 00000004 0000010f 00000000 0008b40f 00000003
> [   17.920000] ffe0: 00000000 bec20f08 40347d1c 40396f0c 60000010 00000001 bfffffef ffffff7f
> [   17.920000] [<c00a3c50>] (rw_verify_area+0x80/0x110) from [<c00a44bc>] (vfs_write+0x80/0x138)
> [   17.920000] [<c00a44bc>] (vfs_write+0x80/0x138) from [<c00a462c>] (sys_write+0x40/0x6c)
> [   17.920000] [<c00a462c>] (sys_write+0x40/0x6c) from [<c0028ea0>] (ret_fast_syscall+0x0/0x30)
> [   17.920000] Code: 1a000002 e59f0088 e59f107c eb0916b2 (e5963098) 
> [   18.430000] Unable to handle kernel paging request at virtual address 19612181
> [   18.430000] pgd = c0004000
> [   18.430000] [19612181] *pgd=00000000
> [   18.430000] Internal error: Oops: 805 [#2] PREEMPT
> [   18.430000] last sysfs file: /sys/kernel/uevent_seqnum
> [   18.430000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
> [   18.430000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #178)
> [   18.430000] PC is at free_block+0x7c/0x148
> [   18.430000] LR is at drain_array+0xb0/0xfc
> [   18.430000] pc : [<c00a0760>]    lr : [<c00a0a40>]    psr: 00000193
> [   18.430000] sp : c7cb1f10  ip : c7809020  fp : 00100100
> [   18.430000] r10: c7d28df0  r9 : 00200200  r8 : 00000001
> [   18.430000] r7 : c7c0c30c  r6 : c7c0c2c0  r5 : 00000000  r4 : c7cba920
> [   18.430000] r3 : 21611961  r2 : 19612181  r1 : 00000080  r0 : c7809b00
> [   18.430000] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [   18.430000] Control: 00c5387d  Table: 87fb8000  DAC: 00000017
> [   18.430000] Process kworker/0:2 (pid: 284, stack limit = 0xc7cb0268)
> [   18.430000] Stack: (0xc7cb1f10 to 0xc7cb2000)
> [   18.430000] 1f00:                                     c7fae000 c7d28df0 00000001 c7d28de0
> [   18.430000] 1f20: 00000000 c7c0c2c0 c0403d58 00000005 c7c11815 c00a0a40 c7cba920 c7c0c2c0
> [   18.430000] 1f40: 00000000 c03e991c c03e4110 c00a0bd0 00000000 c7d5fd90 c03e991c c7c536a0
> [   18.430000] 1f60: 00000037 00000000 c7c11800 c00a0b80 00000000 c0054764 c03e47ec c7c536a0
> [   18.430000] 1f80: c03e47ec 00000009 c7cb0000 c03e47ec c7c536b0 c7c536b0 c03e496c c0054f44
> [   18.430000] 1fa0: c7c25f0c c7cb1fd4 c7c25f0c c7c536a0 c0054d24 00000000 00000000 00000000
> [   18.430000] 1fc0: 00000000 c005a694 c0029f0c 00000000 c7c536a0 00000000 c7cb1fd8 c7cb1fd8
> [   18.430000] 1fe0: 00000000 c7c25f0c c005a618 c0029f0c 00000013 c0029f0c 00000001 02000000
> [   18.430000] [<c00a0760>] (free_block+0x7c/0x148) from [<c00a0a40>] (drain_array+0xb0/0xfc)
> [   18.430000] [<c00a0a40>] (drain_array+0xb0/0xfc) from [<c00a0bd0>] (cache_reap+0x50/0x118)
> [   18.430000] [<c00a0bd0>] (cache_reap+0x50/0x118) from [<c0054764>] (process_one_work+0x258/0x3c8)
> [   18.430000] [<c0054764>] (process_one_work+0x258/0x3c8) from [<c0054f44>] (worker_thread+0x220/0x438)
> [   18.430000] [<c0054f44>] (worker_thread+0x220/0x438) from [<c005a694>] (kthread+0x7c/0x84)
> [   18.430000] [<c005a694>] (kthread+0x7c/0x84) from [<c0029f0c>] (kernel_thread_exit+0x0/0x8)
> [   18.430000] Code: e592c01c e5974000 e59c2004 e59c3000 (e5823000) 
> [   19.060000] ---[ end trace c880c727f016a30b ]---
> [   19.070000] note: kworker/0:2[284] exited with preempt_count 1
> [   19.100000] Unable to handle kernel paging request at virtual address 21412146
> [   19.120000] pgd = c0004000
> [   19.130000] [21412146] *pgd=00000000
> [   19.140000] Internal error: Oops: 5 [#3] PREEMPT
> [   19.140000] last sysfs file: /sys/kernel/uevent_seqnum
> [   19.140000] Modules linked in: ov2640 mx3_camera soc_camera soc_mediabus videobuf_dma_contig videobuf_core
> [   19.140000] CPU: 0    Tainted: G      D      (2.6.36-10808-ga06e72c-dirty #178)
> [   19.140000] PC is at d_hash_and_lookup+0x5c/0x9c
> [   19.140000] LR is at proc_flush_task+0x68/0x260
> [   19.140000] pc : [<c00b6ec4>]    lr : [<c00e6c1c>]    psr: 20000113
> [   19.140000] sp : c7cb1c38  ip : 00121bc5  fp : c7cb1c67
> [   19.140000] r10: c7c0d800  r9 : c7c1ce20  r8 : c7c1ce20
> [   19.140000] r7 : 0000000b  r6 : c7801698  r5 : 00000000  r4 : c7cb1c74
> 
> 
> Sorry but I have not enough time to go down deeply in this problem.
> If you have suggestions I will appreciate it..

And the memblock debug output?
