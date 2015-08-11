From: msalter@redhat.com (Mark Salter)
Date: Tue, 11 Aug 2015 13:48:10 -0400
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <20150805112713.GY7557@n2100.arm.linux.org.uk>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
 <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
 <20150805112713.GY7557@n2100.arm.linux.org.uk>
Message-ID: <1439315290.3153.11.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-05 at 12:27 +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 05, 2015 at 11:13:07AM +0100, Peter Robinson wrote:
> > On Wed, Aug 5, 2015 at 11:07 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Wed, Aug 05, 2015 at 11:01:01AM +0100, Peter Robinson wrote:
> > > > Hi All,
> > > > 
> > > > On Fedora 23 with recent 4.2 kernels we're seeing a crash (below) 
> > > > in
> > > > highmem.c on a fairly regular occurrence across a number of 
> > > > different
> > > > SoCs, I've seen it with at least AllWinner A20, i.MX6Q, Tegra2 and 
> > > > 124
> > > > with both a LPAE and non LPAE kernel, seen it happen when doing a
> > > > number of different things but regenerating a initrd, applying 
> > > > updates
> > > > (dnf/yum) and starting X are all pretty good triggers.
> > > 
> > > I've yet to see any problems with mainline 4.2-rc5 kernels on any of 
> > > my
> > > iMX6 platforms, which includes initramfs regeneration, apt-get 
> > > updates
> > > and X.
> > > 
> > > > [71751.658105] ------------[ cut here ]------------
> > > > [71751.658153] kernel BUG at arch/arm/mm/highmem.c:114!
> > > 
> > > Well, in mainline kernels, the BUG is on line 113, not line 114.  So 
> > > at
> > > least this file is modified from mainline kernels.  Maybe the problem 
> > > is
> > > caused by patches applied to Fedora kernels?
> > 
> > We apply a crash driver patch [1] which has been there forever (long
> > enough that I'd forgotten it) but other than that for arm kernels we
> > currently don't apply any arm specific patches in 4.2.
> 
> It helps if I look at 4.2 rather than an older kernel :)
> 
> However, I've checked that I have DEBUG_HIGHMEM enabled, which I do, and
> I'm unable to reproduce this here.  My kernels are built with gcc 4.7.4.
> 
> What it looks like from your oops is that the address which was passed
> in was 0xffedf000, but the address we calculated via the following for
> the current index was 0xfff00000:
> 
> type = kmap_atomic_idx();
> idx = type + KM_TYPE_NR * smp_processor_id();
> __fix_to_virt(idx)
> 
> Doing a bit of maths... the address 0xffedf000 corresponds to a fixmap
> index of... (0xffeff000 - 0xffedf000) >> 12 = 32.  KM_TYPE_NR is 16 on
> ARM, so the mapping was created by CPU 2, and type was zero.
> 
> On unmap, 0xfff00000 gives... (0xffeff000 - 0xfff00000) >> 12 = -1.
> That suggests we're on CPU 0, and type is -1 - in other words, there
> are no atomically mapped mappings on CPU 0.
> 
> Since kmap_atomic() disables preemption and page faults, how did your
> kernel migrate this thread from CPU 2 to CPU 0... and I can't see how
> that happened.
> 

The fedora kernel is using PREEMPT_VOLUNTARY with !PREEMPT and
!PREEMPT_CPOUNT. So preempt_disable() is a nop. I added some code
to catch the kernel scheduling between kmap_atomic() and
kunmap_atomic() and got this straightaway:

[    2.958651] ------------[ cut here ]------------
[    2.963263] kernel BUG at arch/arm/mm/highmem.c:61!
[    2.968132] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    2.973261] Modules linked in:
[    2.976313] CPU: 0 PID: 199 Comm: systemd-udevd Tainted: G        W       4.2.0-rc5 #9
[    2.984218] Hardware name: Highbank
[    2.987699] task: ecb9bf40 ti: eccce000 task.ti: eccce000
[    2.993097] PC is at check_kmap_atomic+0x20/0x2c
[    2.997710] LR is at __schedule+0x254/0x60c
[    3.001885] pc : [<c022318c>]    lr : [<c08d49a0>]    psr: 200d0093
[    3.001885] sp : ecccfdd8  ip : 00000000  fp : ecccfe1c
[    3.013350] r10: c0d508a0  r9 : ecb9c244  r8 : ffeff000
[    3.018565] r7 : c0d4a140  r6 : ec90a280  r5 : ed3b7140  r4 : ecb9bf40
[    3.025081] r3 : 00000001  r2 : 2c66d000  r1 : eccce000  r0 : 00000000
[    3.031599] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    3.038810] Control: 10c5387d  Table: 2cc9c04a  DAC: 00000015
[    3.044546] Process systemd-udevd (pid: 199, stack limit = 0xeccce220)
[    3.051063] Stack: (0xecccfdd8 to 0xeccd0000)
[    3.055410] fdc0:                                                       eccad500 00000000
[    3.063580] fde0: ecc83e80 eccbc488 ecc83e80 c08d5030 2c66d000 00000000 00000002 eccce000
[    3.071749] fe00: 00000000 0000012a b6fe0000 ffeff000 ecccff14 ecccff0c ecccfe2c c08d5030
[    3.079918] fe20: ecb5f538 00000000 ecccfe34 c08d5088 b6fe0000 c08d6a14 00000000 c05285a0
[    3.088086] fe40: b6fe0000 ffeff000 0000012a 0000012a 00000000 ec3da524 ffeff000 0000012a
[    3.096255] fe60: ecccff14 c052dcec ef7b1678 ffeff000 0000012a 00000000 eccbc480 ec3da524
[    3.104423] fe80: ef7b1678 00000000 0000012a ecccff28 00000000 c032add4 00000000 c04b6804
[    3.112592] fea0: ecccff14 ffffffff 00000fff ec3da438 eccbc4e8 00000001 00000129 00000000
[    3.120760] fec0: ecc72c18 00000000 00000000 000b6fe0 00000000 00000000 b6fe1000 eccbc480
[    3.128929] fee0: 00000000 ecccff88 00001000 c020fae4 eccce000 00000200 00000000 c037ff08
[    3.137098] ff00: 00001000 c020fae4 eccce000 b6fe0000 00001000 00000000 00000000 00001000
[    3.145266] ff20: ecccff0c 00000001 eccbc480 00000000 00000000 00000000 00000000 00000000
[    3.153435] ff40: 00000000 00000000 00000000 b6fe0000 eccbc480 ecccff88 00001000 c03805d0
[    3.161603] ff60: eccbc480 b6fe0000 00001000 eccbc480 eccbc480 b6fe0000 00001000 c020fae4
[    3.169772] ff80: eccce000 c0380e84 00000000 00000000 00001000 8066e1c0 00003ffe 8066e1c0
[    3.177940] ffa0: 00000003 c020fad0 8066e1c0 00003ffe 00000006 b6fe0000 00001000 00000040
[    3.186109] ffc0: 8066e1c0 00003ffe 8066e1c0 00000003 0000000a bee856e4 00000000 00000000
[    3.194277] ffe0: 00000000 bee8528c b6daa470 b6e0f5b0 600d0010 00000006 00000000 00000000
[    3.202454] [<c022318c>] (check_kmap_atomic) from [<c08d49a0>] (__schedule+0x254/0x60c)
[    3.210454] [<c08d49a0>] (__schedule) from [<c08d5030>] (preempt_schedule_common+0x24/0x40)
[    3.218799] [<c08d5030>] (preempt_schedule_common) from [<c08d5088>] (_cond_resched+0x3c/0x4c)
[    3.227404] [<c08d5088>] (_cond_resched) from [<c08d6a14>] (down_read+0x14/0x48)
[    3.234799] [<c08d6a14>] (down_read) from [<c05285a0>] (__copy_to_user_memcpy+0x54/0x17c)
[    3.242974] [<c05285a0>] (__copy_to_user_memcpy) from [<c052dcec>] (copy_page_to_iter+0xd8/0x258)
[    3.251844] [<c052dcec>] (copy_page_to_iter) from [<c032add4>] (generic_file_read_iter+0x370/0x5dc)
[    3.260885] [<c032add4>] (generic_file_read_iter) from [<c037ff08>] (__vfs_read+0xb0/0xd8)
[    3.269142] [<c037ff08>] (__vfs_read) from [<c03805d0>] (vfs_read+0x8c/0x13c)
[    3.276270] [<c03805d0>] (vfs_read) from [<c0380e84>] (SyS_read+0x48/0x88)
[    3.283141] [<c0380e84>] (SyS_read) from [<c020fad0>] (__sys_trace_return+0x0/0x10)
[    3.290790] Code: e7922100 e7923003 e3530000 012fff1e (e7f001f2) 
[    3.296876] ---[ end trace cb88537fdc8fa202 ]---
[    3.301485] note: systemd-udevd[199] exited with preempt_count 2097152
