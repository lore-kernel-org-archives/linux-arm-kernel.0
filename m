From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 15 Oct 2015 23:31:06 +0200
Subject: Atmel sama5d3 boot regression, today's linux-next
In-Reply-To: <20151015152046.GA10306@gradator.net>
References: <20151015133015.GA28863@gradator.net>
 <20151015141449.GH3421@piout.net> <20151015152046.GA10306@gradator.net>
Message-ID: <4012289.BrK0EAqN07@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 15, 2015 05:20:46 PM Sylvain Rochet wrote:
> Hi,
> 
> On Thu, Oct 15, 2015 at 04:14:49PM +0200, Alexandre Belloni wrote:
> > On 15/10/2015 at 15:30:16 +0200, Sylvain Rochet wrote :
> > > Hi,
> > > 
> > > Atmel SAMA5D31 boards no longer boot on today's linux-next. Bisected to:
> > > 
> > > commit 7d24068e144adc03b805806645d732cf79488717
> > > Author: Wonhong Kwon <wonhongkwon@gmail.com>
> > > Date:   Tue Oct 6 10:10:20 2015 +0900
> > > 
> > >     PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
> > > 
> > >     pm_init is being invoked by core_initcall and hibernate_image_size_init
> > >     calculates preferred image size (image_size) based on total pages
> > >     (totalram_pages). This totalram_pages can be modified during various
> > >     initcall-s phase and this can cause miscalculated image_size.
> > > 
> > >     For example, when CMA is being used, init_cma_reserved_pageblock tries
> > >     to change the totalram_pages and this job is done during core_initcall.
> > >     In order words, the totalram_pages doesn't take CMA reserved pages into
> > >     account when image_size is calculated and it can be too small.
> > > 
> > >     Move pm_init and pm_disk_init to late_initcall_sync so that it happens
> > >     after all other initcall-s change the totalram_pages.
> > > 
> > >     Reported-by: Sangseok Lee <sangseok.lee@lge.com>
> > >     Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
> > >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Reverting it fixes the issue.
> > > 
> > 
> > The relevant trace is:
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000080
> > pgd = c0004000
> > [00000080] *pgd=00000000
> > Internal error: Oops: 5 [#1] ARM
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper Not tainted 4.3.0-rc5-next-20151015 #30
> > Hardware name: Atmel SAMA5
> > task: cf41dac0 ti: cf42c000 task.ti: cf42c000
> > PC is at __queue_work+0x20/0x20c
> > LR is at queue_work_on+0x34/0x40
> > pc : [<c002d6bc>]    lr : [<c002d8dc>]    psr: 20000093
> > sp : cf42dd20  ip : 00000000  fp : 00000001
> > r10: c06c604c  r9 : 00000000  r8 : 00000001
> > r7 : 00000000  r6 : 00000000  r5 : cf4b58a4  r4 : 60000093
> > r3 : 60000093  r2 : cf4b58a4  r1 : 00000000  r0 : 00000001
> > Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > Control: 10c53c7d  Table: 20004059  DAC: 00000051
> > Process swapper (pid: 1, stack limit = 0xcf42c208)
> > Stack: (0xcf42dd20 to 0xcf42e000)
> > dd20: c06d25c0 c002cca4 60000093 ffffffe1 00000004 00000000 00000005 c002d8dc
> > dd40: cf4b5810 00000000 00000004 c024d67c 60000013 00000000 cf61889c 00000001
> > dd60: c06e7d68 c024d738 cf618868 c024593c cf618868 00000001 cf618870 cf618870
> > dd80: c06c6064 cf618868 00000000 c0244ff4 cf618870 cf618868 cf4b5810 c0243430
> > dda0: cf618868 c024fda0 cf618868 c06e7d68 cf618840 00000000 cf618868 cf4b5800
> > ddc0: 00000000 cf6189c4 00000100 c02f8964 00000000 c024276c c05e2cf4 cf517b68
> > dde0: 00000000 cf42de08 10031012 c0356280 cf618810 cf618840 cf618840 cf4b5800
> > de00: 00000000 c02f8da4 024000c0 cf618810 00000000 cf618840 cf4b5800 c02fd2b4
> > de20: 00000000 cf4b2800 cf618810 cf6b26c8 cf4b61c8 000186a0 f0014030 f0014034
> > de40: 00000001 00000001 00000001 00000001 00000000 00000000 c05e1d54 ffffffed
> > de60: cf4b5810 c06c61f4 fffffdfb 00000000 0000008e c0698838 00000000 c0247428
> > de80: c06e7d8c cf4b5810 c06c61f4 00000000 00000000 c0245b88 cf4b5810 c06c61f4
> > dea0: cf4b5844 c06b7da8 cf6b6540 c0245d00 00000000 c06c61f4 c0245c74 c0244158
> > dec0: cf43da4c cf48d530 c06c61f4 cf4b7c00 00000000 c02452a0 c05f8d48 00000004
> > dee0: c06c61f4 c06c61f4 c06a8b60 c06893b8 00000000 c02464c8 c06a8b60 c06a8b60
> > df00: c06893b8 c0009718 cf408280 c06d9e14 cf48df00 c04d517c 00000000 00000000
> > df20: 00000000 c00e7aa8 c06aea48 cf48df80 00000000 cfffc4ed c04ea9ec c0033b68
> > df40: c05baa70 cfffc4ef 00000004 00000004 00000000 cfffc480 c06a397c 00000004
> > df60: c0698828 c06d1a80 c06d1a80 0000008e c0698838 c066fd80 00000004 00000004
> > df80: 00000000 c066f594 00001a80 c04cfb60 00000000 00000000 00000000 00000000
> > dfa0: 00000000 c04cfb6c 00000000 c000f5d8 00000000 00000000 00000000 00000000
> > dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 ff88b8e1 cd7fefde
> > [<c002d6bc>] (__queue_work) from [<c002d8dc>] (queue_work_on+0x34/0x40)
> > [<c002d8dc>] (queue_work_on) from [<c024d67c>] (rpm_idle+0xc0/0x140)
> > [<c024d67c>] (rpm_idle) from [<c024d738>] (__pm_runtime_idle+0x3c/0x4c)
> > [<c024d738>] (__pm_runtime_idle) from [<c024593c>] (__device_attach+0xe8/0x108)
> > [<c024593c>] (__device_attach) from [<c0244ff4>] (bus_probe_device+0x84/0x8c)
> > [<c0244ff4>] (bus_probe_device) from [<c0243430>] (device_add+0x3e8/0x570)
> > [<c0243430>] (device_add) from [<c02f8964>] (i2c_register_adapter+0xa8/0x4b4)
> > [<c02f8964>] (i2c_register_adapter) from [<c02fd2b4>] (at91_twi_probe+0x400/0x608)
> > [<c02fd2b4>] (at91_twi_probe) from [<c0247428>] (platform_drv_probe+0x50/0xac)
> > [<c0247428>] (platform_drv_probe) from [<c0245b88>] (driver_probe_device+0x204/0x2f0)
> > [<c0245b88>] (driver_probe_device) from [<c0245d00>] (__driver_attach+0x8c/0x90)
> > [<c0245d00>] (__driver_attach) from [<c0244158>] (bus_for_each_dev+0x68/0x9c)
> > [<c0244158>] (bus_for_each_dev) from [<c02452a0>] (bus_add_driver+0x1a0/0x218)
> > [<c02452a0>] (bus_add_driver) from [<c02464c8>] (driver_register+0x78/0xf8)
> > [<c02464c8>] (driver_register) from [<c0009718>] (do_one_initcall+0x90/0x1d8)
> > [<c0009718>] (do_one_initcall) from [<c066fd80>] (kernel_init_freeable+0x130/0x1d0)
> > [<c066fd80>] (kernel_init_freeable) from [<c04cfb6c>] (kernel_init+0xc/0xe8)
> > [<c04cfb6c>] (kernel_init) from [<c000f5d8>] (ret_from_fork+0x14/0x3c)
> 
> Looks like it is related to drivers calling at least the pm_runtime API 
> in their probe function, it is probably not just limited to Atmel SoC, 
> To:ed PM maintainers, Rafael, Len and Pavel.

Sorry about the breakage, I've dropped the problematic commit from my tree.

Thanks,
Rafael
