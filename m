From: shuahkhan@gmail.com (Shuah Khan)
Date: Wed, 22 Mar 2017 09:46:05 -0600
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <20170322111020.GD21222@n2100.armlinux.org.uk>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
Message-ID: <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel and Marek,

On Wed, Mar 22, 2017 at 5:10 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Feb 21, 2017 at 02:16:38PM +0100, Marek Szyprowski wrote:
>> Some DMA regions, for example those created by dma_declare_coherent_memory,
>> might not be possible to be represented by struct page pointers. Getting
>> scatterlist for the buffer allocated from such region is not possible.
>> This patch adds a simple check in arm_dma_get_sgtable() function if the
>> exported struct page pointer is valid.
>
> I really don't like this - the "validation" here looks like total crap,
> especially when you analyse what these macros expand to.
>
> I also don't like the way dma_get_sgtable() appeared without any
> documentation about (a) what it's for (b) what the expectations for its
> arguments are and (c) what it's supposed to be doing.  There are no
> comments in include/linux/dma-mapping.h describing the interface, nor
> are there any comments about it in Documentation/DMA*.

Soory for a long reply.

This check doesn't really do any kind of validation. I have been debugging
a pagefault when the sgtable created by arm_dma_get_sgtable() runs into
the following kernel error when vb2_dc_dmabuf_ops_map() tries to map
the exported buffer from another driver.

Unable to handle kernel paging request at virtual address f0004000

I tracked the buffer and page - dma_to_pfn() returns a page that is invalid
which gets into this sgtable and later on when another driver tries to map it,
it trips on this invalid sgtable entry.

[  160.717795] pgd = ece98000
[  160.720479] [f0004000] *pgd=00000000
[  160.724034] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  160.729316] Modules linked in: cpufreq_userspace cpufreq_powersave
cpufreq_conservative exynos_gsc s5p_jpeg s5p_mfc v4l2_mem2mem
videobuf2_dma_contig v4l2_common videobuf2_memops videobuf2_v4l2
videobuf2_core videodev media
[  160.749077] CPU: 5 PID: 1979 Comm: v4l2video0dec0: Not tainted
4.10.0-rc5-00007-gfdc23c2-dirty #27
[  160.758000] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  160.764066] task: eb852300 task.stack: eb958000
[  160.768578] PC is at page_address+0x4/0xd8
[  160.772651] LR is at vb2_dc_dmabuf_ops_map+0x140/0x220 [videobuf2_dma_contig]
[  160.779751] pc : [<c01c2bd0>]    lr : [<bf1bc7c8>]    psr: 60030013
               sp : eb959be8  ip : 00000007  fp : ed3456c0
[  160.791188] r10: 00000001  r9 : 00000001  r8 : ed3456c0
[  160.796388] r7 : c0c09a44  r6 : 00000001  r5 : 87654321  r4 : ed345ec0
[  160.802887] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : f0004000
[  160.809387] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  160.816492] Control: 10c5387d  Table: 6ce9806a  DAC: 00000051
[  160.822211] Process v4l2video0dec0: (pid: 1979, stack limit = 0xeb958210)
[  160.828970] Stack: (0xeb959be8 to 0xeb95a000)
[  160.833304] 9be0:                   ed345ec0 87654321 00000001
c0c09a44 ed3456c0 00000001
[  160.841449] 9c00: 00000001 bf1bc7c8 00000001 eb959c34 ed11f314
eeab0a10 c09bb5d4 ed345000
[  160.849595] 9c20: 00000001 00000000 ed345290 00000000 bf12aa8c
00000001 00000001 c044c0f0
[  160.857740] 9c40: ed345280 ed037600 00000000 bf1bc330 00000000
00000000 ed345290 000e6040
----
[  161.102113] [<c01c2bd0>] (page_address) from [<bf1bc7c8>]
(vb2_dc_dmabuf_ops_map+0x140/0x220 [videobuf2_dma_contig])
[  161.112602] [<bf1bc7c8>] (vb2_dc_dmabuf_ops_map
[videobuf2_dma_contig]) from [<c044c0f0>]
(dma_buf_map_attachment+0x44/0x68)
[  161.123774] [<c044c0f0>] (dma_buf_map_attachment) from [<bf1bc330>]
(vb2_dc_map_dmabuf+0x64/0x16c [videobuf2_dma_contig])
[  161.134697] [<bf1bc330>] (vb2_dc_map_dmabuf [videobuf2_dma_contig])
from [<bf1278c8>] (__qbuf_dmabuf+0x3c4/0x4c8 [videobuf2_core])
[  161.146396] [<bf1278c8>] (__qbuf_dmabuf [videobuf2_core]) from
[<bf127afc>] (__buf_prepare+0x130/0x16c [videobuf2_core])
[  161.157226] [<bf127afc>] (__buf_prepare [videobuf2_core]) from
[<bf127d3c>] (vb2_core_qbuf+0x128/0x204 [videobuf2_core])
[  161.168058] [<bf127d3c>] (vb2_core_qbuf [videobuf2_core]) from
[<bf1e4658>] (v4l2_m2m_qbuf+0x1c/0x34 [v4l2_mem2mem])
[  161.178564] [<bf1e4658>] (v4l2_m2m_qbuf [v4l2_mem2mem]) from
[<bf057914>] (__video_do_ioctl+0x290/0x2ec [videodev])
[  161.188972] [<bf057914>] (__video_do_ioctl [videodev]) from
[<bf057338>] (video_usercopy+0x1a0/0x4e0 [videodev])
[  161.199109] [<bf057338>] (video_usercopy [videodev]) from
[<bf0525a4>] (v4l2_ioctl+0xa0/0xd8 [videodev])
[  161.208539] [<bf0525a4>] (v4l2_ioctl [videodev]) from [<c01f991c>]
(do_vfs_ioctl+0x9c/0x8e0)
[  161.216923] [<c01f991c>] (do_vfs_ioctl) from [<c01fa194>]
(SyS_ioctl+0x34/0x5c)
[  161.224205] [<c01fa194>] (SyS_ioctl) from [<c0107740>]
(ret_fast_syscall+0x0/0x3c)
[  161.231741] Code: e0623623 e0800283 e12fff1e e92d47f0 (e5903000)
[  161.237807] ---[ end trace aa851942c99a7c54 ]---


Just an an experiment, I added this hack: in this case __dc_alloc()
returned values
is the mapped page. This is by mo means a fix - I am not sure if we can rely on
this page, since at DQBUF its get unmapped.

/* In this case cpu_addr is the page - just use it */
        if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
                page = cpu_addr;

At this point I dumped some data:

[  154.627505] platform 11000000.codec:left:
debug_arm_dma_get_sgtable: bus_to_pfn 772608 dma_pfn_offset 0
PHYS_PFN_OFFSET 262144
[  154.627512] platform 11000000.codec:left:
debug_arm_dma_get_sgtable: dma_to_pfn 772608 virt_to_pfn 470272
virt_to_dma 1926234112 virt_to_page ef6ca000 page f0004000

cpu_addr is
[  154.627520] platform 11000000.codec:left:
debug_arm_dma_get_sgtable: cpu_addr f2d00000 handle bca00000 page =
f2d00000 size 946176 align size 946176
[  154.627527] platform 11000000.codec:left: after
dma_get_sgtable_attrs() vb2_dc_get_base_sgt: sgt ecdcec00 page
f2d00000 buf ecdced80 cookie f2d00000 vaddr f2d00000 dc_cookie
ecdced90 dma_addr bca00000 size 946176

cpu_addr is f2d00000 and the page you get from
pfn_to_page(dma_to_pfn(dev, handle)) is f0004000.

The page you get with struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
is bogus. So this check Merek added doesn't find a bogus page, does a reverse
validation of the bogus page.

I also generated page tables and I do find this page f2d00000 it in
there. For some reason
dma_to_pfn(dev, handle) fails baldy at this stage which trips the kernel later.

I can help debug this further and find a fix - I have a use-case that
can reproduces on every single run. I am suing 4.10-rc5

With the hack to make page =  cpu_addr, it goes further as the page is
good and then runs into an error when an attempt is made to clean
D-cache.

[  154.687637] Unable to handle kernel paging request at virtual
address a4800000
[  154.693445] pgd = ed880000
[  154.696054] [a4800000] *pgd=00000000
[  154.699611] Internal error: Oops: 2805 [#1] PREEMPT SMP ARM
[  154.705153] Modules linked in: cpufreq_userspace cpufreq_powersave
cpufreq_conservative s5p_mfc s5p_jpeg exynos_gsc v4l2_mem2mem
videobuf2_dma_contig v4l2_common videobuf2_memops videobuf2_v4l2
videobuf2_core videodev media
[  154.724914] CPU: 3 PID: 1901 Comm: v4l2video6dec0: Not tainted
4.10.0-rc5-00007-gfdc23c2-dirty #28
[  154.733835] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  154.739902] task: eda6cb00 task.stack: eb844000
[  154.744414] PC is at v7_dma_clean_range+0x1c/0x34
[  154.749094] LR is at __dma_page_cpu_to_dev+0x28/0x90
[  154.754027] pc : [<c0114070>]    lr : [<c010f624>]    psr: 20030013
               sp : eb845b90  ip : 00040000  fp : 00000001
[  154.765464] r10: 00000001  r9 : 00000000  r8 : c010f6d0
[  154.770664] r7 : 00000001  r6 : 000e7000  r5 : f2d00000  r4 : 00000000
[  154.777164] r3 : 0000003f  r2 : 00000040  r1 : a48e7000  r0 : a4800000
[  154.783663] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  154.790767] Control: 10c5387d  Table: 6d88006a  DAC: 00000051
[  154.796486] Process v4l2video6dec0: (pid: 1901, stack limit = 0xeb844210)
[  154.803246] Stack: (0xeb845b90 to 0xeb846000)

---

[  155.092674] 5fe0: b6589200 b384393c b6556095 b6cf8ea6 20030030
0000001a 00000000 00000000
[  155.100828] [<c0114070>] (v7_dma_clean_range) from [<c010f624>]
(__dma_page_cpu_to_dev+0x28/0x90)
[  155.109661] [<c010f624>] (__dma_page_cpu_to_dev) from [<c010f734>]
(arm_dma_map_page+0x64/0x68)
[  155.118326] [<c010f734>] (arm_dma_map_page) from [<c0110760>]
(arm_dma_map_sg+0x90/0x1a4)
[  155.126486] [<c0110760>] (arm_dma_map_sg) from [<bf1c7814>]
(vb2_dc_dmabuf_ops_map+0x1a0/0x228 [videobuf2_dma_contig])
[  155.137143] [<bf1c7814>] (vb2_dc_dmabuf_ops_map
[videobuf2_dma_contig]) from [<c044c510>]
(dma_buf_map_attachment+0x44/0x68)
[  155.148314] [<c044c510>] (dma_buf_map_attachment) from [<bf1c7318>]
(vb2_dc_map_dmabuf+0x70/0x17c [videobuf2_dma_contig])
[  155.159254] [<bf1c7318>] (vb2_dc_map_dmabuf [videobuf2_dma_contig])
from [<bf1328c8>] (__qbuf_dmabuf+0x3c4/0x4c8 [videobuf2_core])
[  155.170940] [<bf1328c8>] (__qbuf_dmabuf [videobuf2_core]) from
[<bf132afc>] (__buf_prepare+0x130/0x16c [videobuf2_core])
[  155.181771] [<bf132afc>] (__buf_prepare [videobuf2_core]) from
[<bf132d3c>] (vb2_core_qbuf+0x128/0x204 [videobuf2_core])
[  155.192612] [<bf132d3c>] (vb2_core_qbuf [videobuf2_core]) from
[<bf1ef658>] (v4l2_m2m_qbuf+0x1c/0x34 [v4l2_mem2mem])
[  155.203195] [<bf1ef658>] (v4l2_m2m_qbuf [v4l2_mem2mem]) from
[<bf062914>] (__video_do_ioctl+0x290/0x2ec [videodev])
[  155.213542] [<bf062914>] (__video_do_ioctl [videodev]) from
[<bf062338>] (video_usercopy+0x1a0/0x4e0 [videodev])
[  155.223677] [<bf062338>] (video_usercopy [videodev]) from
[<bf05d5a4>] (v4l2_ioctl+0xa0/0xd8 [videodev])
[  155.233094] [<bf05d5a4>] (v4l2_ioctl [videodev]) from [<c01f9d3c>]
(do_vfs_ioctl+0x9c/0x8e0)
[  155.241461] [<c01f9d3c>] (do_vfs_ioctl) from [<c01fa5b4>]
(SyS_ioctl+0x34/0x5c)
[  155.248743] [<c01fa5b4>] (SyS_ioctl) from [<c0107740>]
(ret_fast_syscall+0x0/0x3c)
[  155.256278] Code: e3a02004 e1a02312 e2423001 e1c00003 (ee070f3a)
[  155.262444] ---[ end trace e7118e14619b5c07 ]---

thanks,
-- Shuah

>
> So, I'm really not applying this patch until the purpose of this
> function gets documented.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
