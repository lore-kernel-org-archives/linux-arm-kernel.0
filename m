From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 28 Dec 2017 21:31:25 +0100
Subject: [PATCH 0/4] Sunxi: Add SMP support on A83T
In-Reply-To: <20171227160729.4509bec5@dell-desktop.home>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
 <20171211193534.GA3967@Red>
 <20171212082425.iv37nrpotbb33vh6@flea.lan>
 <20171215061046.GA9845@Red>
 <20171227160729.4509bec5@dell-desktop.home>
Message-ID: <20171228203125.GB18393@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 27, 2017 at 04:07:29PM +0100, Mylene JOSSERAND wrote:
> Hello Corentin,
> 
> Le Fri, 15 Dec 2017 07:10:46 +0100,
> Corentin Labbe <clabbe.montjoie@gmail.com> a ?crit :
> > On Tue, Dec 12, 2017 at 09:24:25AM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > On Mon, Dec 11, 2017 at 08:35:34PM +0100, Corentin Labbe wrote:  
> > > > On Mon, Dec 11, 2017 at 08:49:57AM +0100, Myl?ne Josserand wrote:  
> > > > > This series adds SMP support for Allwinner Sun8i-a83t
> > > > > with MCPM (Multi-Cluster Power Management).
> > > > > Series information:
> > > > > 	- Based on last linux-next (next-20171211)
> > > > > 	- Had dependencies on Chen Yu's patch that add MCPM
> > > > > 	support:
> > > > > 	https://patchwork.kernel.org/patch/6402801/
> > > > > 
> > > > > Patch 01: Convert the mcpm driver (initially for A80) to be able
> > > > > to use it for A83T. This SoC has a bit flip that needs to be handled.
> > > > > Patch 02: Add registers nodes (prcm, cpucfg and r_cpucfg) needed
> > > > > for MCPM.
> > > > > Patch 03: Add CCI-400 node for a83t.
> > > > > Patch 04: Fix the use of virtual timers that hangs the kernel in
> > > > > case of SMP support.  
> > > > 
> > > > As we discussed in private, Chen Yu's patch should be added in your series.  
> > > 
> > > Not really, she mentionned the dependency in the cover letter, and
> > > it's a good way to do things too. Sure, you can do it your way, but
> > > there's no preference.
> > >   
> > 
> > If the goal of this series is to be applied, the dependency must be applied also.
> > And since the dependency is 2 years old (and part of a serie which does not apply now), I think cherry picking the patch and send it for review is better.
> > 
> > > > Furthermore, MCPM is not automaticaly selected via imply.  
> > > 
> > > Well, yes, is that an issue?
> > >   
> > 
> > After reading the imply documentation, no.
> > 
> > > > With all patchs I hit a bug:
> > > > [    0.898668] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238  
> > > 
> > > I guess this is with CONFIG_PROVE_LOCKING enabled?
> > >   
> > 
> > No, the BUG() printed is enabled by default
> > 
> > > > [    0.911162] in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: swapper/0
> > > > [    0.917776] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-next-20171211+ #73  
> > > 
> > > What are the changes you've made?
> > >   
> > 
> > Just adding wens's patch and this series.
> 
> I tried to reproduce your issue without success (even with
> CONFIG_PROVE_LOCKING enabled, just in case).
> Can you give me more details about your tests? which defconfig and
> additional configurations?
> 
> > 
> > > > [    0.925418] Hardware name: Allwinner sun8i Family
> > > > [    0.930118] Backtrace: 
> > > > [    0.932596] [<c010cc50>] (dump_backtrace) from [<c010cf0c>] (show_stack+0x18/0x1c)
> > > > [    0.940158]  r7:c0b261e4 r6:60000013 r5:00000000 r4:c0b51958
> > > > [    0.945820] [<c010cef4>] (show_stack) from [<c06baccc>] (dump_stack+0x8c/0xa0)
> > > > [    0.953045] [<c06bac40>] (dump_stack) from [<c0149d40>] (___might_sleep+0x150/0x170)
> > > > [    0.960779]  r7:c0b261e4 r6:00000000 r5:000000ee r4:ee844000
> > > > [    0.966437] [<c0149bf0>] (___might_sleep) from [<c0149dc8>] (__might_sleep+0x68/0xa0)
> > > > [    0.974253]  r4:c0861690
> > > > [    0.976796] [<c0149d60>] (__might_sleep) from [<c06d2918>] (mutex_lock+0x24/0x68)
> > > > [    0.984269]  r6:c0892f6c r5:ffffffff r4:c0b1bb24
> > > > [    0.988891] [<c06d28f4>] (mutex_lock) from [<c01ccb6c>] (perf_pmu_register+0x24/0x3e4)
> > > > [    0.996795]  r5:ffffffff r4:ee98b014
> > > > [    1.000375] [<c01ccb48>] (perf_pmu_register) from [<c03efabc>] (cci_pmu_probe+0x340/0x484)
> > > > [    1.008631]  r10:c0892f6c r9:c0bfd5f0 r8:eea19010 r7:c0b261e4 r6:c0b26240 r5:eea19000
> > > > [    1.016447]  r4:ee98b010
> > > > [    1.018989] [<c03ef77c>] (cci_pmu_probe) from [<c045e21c>] (platform_drv_probe+0x58/0xb8)
> > > > [    1.027158]  r10:00000000 r9:c0b2610c r8:00000000 r7:fffffdfb r6:c0b2610c r5:ffffffed
> > > > [    1.034974]  r4:eea19010
> > > > [    1.037511] [<c045e1c4>] (platform_drv_probe) from [<c045c984>] (driver_probe_device+0x254/0x330)
> > > > [    1.046371]  r7:00000000 r6:c0bff498 r5:c0bff494 r4:eea19010
> > > > [    1.052026] [<c045c730>] (driver_probe_device) from [<c045cbc4>] (__device_attach_driver+0xa0/0xd4)
> > > > [    1.061062]  r10:00000000 r9:c0bff470 r8:00000000 r7:00000001 r6:eea19010 r5:ee845ac0
> > > > [    1.068879]  r4:c0b2610c r3:00000000
> > > > [    1.072454] [<c045cb24>] (__device_attach_driver) from [<c045ad68>] (bus_for_each_drv+0x68/0x9c)
> > > > [    1.081228]  r7:00000001 r6:c045cb24 r5:ee845ac0 r4:00000000
> > > > [    1.086883] [<c045ad00>] (bus_for_each_drv) from [<c045c60c>] (__device_attach+0xb8/0x11c)
> > > > [    1.095135]  r6:c0b3e848 r5:eea19044 r4:eea19010
> > > > [    1.099750] [<c045c554>] (__device_attach) from [<c045cc44>] (device_initial_probe+0x14/0x18)
> > > > [    1.108263]  r7:c0b0a4c8 r6:c0b3e848 r5:eea19010 r4:eea19018
> > > > [    1.113919] [<c045cc30>] (device_initial_probe) from [<c045bb58>] (bus_probe_device+0x8c/0x94)
> > > > [    1.122523] [<c045bacc>] (bus_probe_device) from [<c0459db8>] (device_add+0x40c/0x5a0)
> > > > [    1.130429]  r7:c0b0a4c8 r6:eea19010 r5:eea18a10 r4:eea19018
> > > > [    1.136089] [<c04599ac>] (device_add) from [<c0582a58>] (of_device_add+0x3c/0x44)
> > > > [    1.143564]  r10:00000000 r9:00000000 r8:00000000 r7:eedf21a4 r6:eea18a10 r5:00000000
> > > > [    1.151380]  r4:eea19000
> > > > [    1.153915] [<c0582a1c>] (of_device_add) from [<c0582f80>] (of_platform_device_create_pdata+0x7c/0xac)
> > > > [    1.163210] [<c0582f04>] (of_platform_device_create_pdata) from [<c0583100>] (of_platform_bus_create+0xf4/0x1f0)
> > > > [    1.173372]  r9:00000000 r8:00000000 r7:00000001 r6:00000000 r5:eedf2154 r4:00000000
> > > > [    1.181107] [<c058300c>] (of_platform_bus_create) from [<c0583374>] (of_platform_populate+0x74/0xd4)
> > > > [    1.190229]  r10:00000001 r9:eea18a10 r8:00000000 r7:00000000 r6:00000000 r5:eedf1d04
> > > > [    1.198045]  r4:eedf2154
> > > > [    1.200580] [<c0583300>] (of_platform_populate) from [<c03ef2a8>] (cci_platform_probe+0x3c/0x54)
> > > > [    1.209356]  r10:00000000 r9:c0b26168 r8:00000000 r7:fffffdfb r6:c0b26168 r5:ffffffed
> > > > [    1.217172]  r4:eea18a00
> > > > [    1.219708] [<c03ef26c>] (cci_platform_probe) from [<c045e21c>] (platform_drv_probe+0x58/0xb8)
> > > > [    1.228306]  r5:ffffffed r4:eea18a10
> > > > [    1.231881] [<c045e1c4>] (platform_drv_probe) from [<c045c984>] (driver_probe_device+0x254/0x330)
> > > > [    1.240742]  r7:00000000 r6:c0bff498 r5:c0bff494 r4:eea18a10
> > > > [    1.246397] [<c045c730>] (driver_probe_device) from [<c045cbc4>] (__device_attach_driver+0xa0/0xd4)
> > > > [    1.255433]  r10:00000000 r9:c0bff470 r8:00000000 r7:00000001 r6:eea18a10 r5:ee845ce8
> > > > [    1.263250]  r4:c0b26168 r3:00000000
> > > > [    1.266825] [<c045cb24>] (__device_attach_driver) from [<c045ad68>] (bus_for_each_drv+0x68/0x9c)
> > > > [    1.275598]  r7:00000001 r6:c045cb24 r5:ee845ce8 r4:00000000
> > > > [    1.281253] [<c045ad00>] (bus_for_each_drv) from [<c045c60c>] (__device_attach+0xb8/0x11c)
> > > > [    1.289506]  r6:c0b3e848 r5:eea18a44 r4:eea18a10
> > > > [    1.294120] [<c045c554>] (__device_attach) from [<c045cc44>] (device_initial_probe+0x14/0x18)
> > > > [    1.302633]  r7:c0b0a4c8 r6:c0b3e848 r5:eea18a10 r4:eea18a18
> > > > [    1.308288] [<c045cc30>] (device_initial_probe) from [<c045bb58>] (bus_probe_device+0x8c/0x94)
> > > > [    1.316890] [<c045bacc>] (bus_probe_device) from [<c0459db8>] (device_add+0x40c/0x5a0)
> > > > [    1.324796]  r7:c0b0a4c8 r6:eea18a10 r5:ee993810 r4:eea18a18
> > > > [    1.330450] [<c04599ac>] (device_add) from [<c0582a58>] (of_device_add+0x3c/0x44)
> > > > [    1.337926]  r10:00000000 r9:c07759d8 r8:00000000 r7:eedf1d54 r6:ee993810 r5:00000000
> > > > [    1.345743]  r4:eea18a00
> > > > [    1.348277] [<c0582a1c>] (of_device_add) from [<c0582f80>] (of_platform_device_create_pdata+0x7c/0xac)
> > > > [    1.357572] [<c0582f04>] (of_platform_device_create_pdata) from [<c0583100>] (of_platform_bus_create+0xf4/0x1f0)
> > > > [    1.367734]  r9:c07759d8 r8:00000000 r7:00000001 r6:00000000 r5:eedf1d04 r4:00000000
> > > > [    1.375469] [<c058300c>] (of_platform_bus_create) from [<c058315c>] (of_platform_bus_create+0x150/0x1f0)
> > > > [    1.384938]  r10:ee993810 r9:c07759d8 r8:00000000 r7:00000001 r6:00000000 r5:eedefe1c
> > > > [    1.392754]  r4:eedf1d04
> > > > [    1.395289] [<c058300c>] (of_platform_bus_create) from [<c0583374>] (of_platform_populate+0x74/0xd4)
> > > > [    1.404411]  r10:00000001 r9:00000000 r8:00000000 r7:c07759d8 r6:00000000 r5:eedee844
> > > > [    1.412228]  r4:eedefe1c
> > > > [    1.414769] [<c0583300>] (of_platform_populate) from [<c0a25ee8>] (of_platform_default_populate_init+0x80/0x94)
> > > > [    1.424844]  r10:c0a37848 r9:00000000 r8:c0b59680 r7:c0a37834 r6:ffffe000 r5:c0775ce8
> > > > [    1.432661]  r4:00000000
> > > > [    1.435200] [<c0a25e68>] (of_platform_default_populate_init) from [<c0102794>] (do_one_initcall+0x5c/0x194)
> > > > [    1.444925]  r5:c0a25e68 r4:c0b0a4c8
> > > > [    1.448506] [<c0102738>] (do_one_initcall) from [<c0a00f88>] (kernel_init_freeable+0x1d4/0x268)
> > > > [    1.457195]  r9:00000004 r8:c0b59680 r7:c0a37834 r6:c0b59680 r5:c0a47308 r4:c090cfb8
> > > > [    1.464932] [<c0a00db4>] (kernel_init_freeable) from [<c06cf3b0>] (kernel_init+0x10/0x118)
> > > > [    1.473187]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c06cf3a0
> > > > [    1.481004]  r4:00000000
> > > > [    1.483540] [<c06cf3a0>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> > > > [    1.491098] Exception stack(0xee845fb0 to 0xee845ff8)
> > > > [    1.496146] 5fa0:                                     00000000 00000000 00000000 00000000
> > > > [    1.504313] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > > [    1.512480] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > > [    1.519084]  r5:c06cf3a0 r4:00000000
> > > > [    1.522737] ARM CCI_400_r1 PMU driver probed
> > > > 
> > > > And only CPU 0 show up.  
> > > 
> > > This looks more like a bug in the CCI code, and not in this serie
> > > itself. Can you share your whole boot logs?
> > >   
> > 
> > This week end I will retry and send it.
> 
> By any chance, did you try it again? Can you reproduce it on your side?
> 

Hello

With the .config that you give me in private, everything seems to work.
But with mine, the stacktrace still happen.
After some research, this is due to the following code:
cpumask_set_cpu(get_cpu(), &cci_pmu->cpus);
which disable preemption (via get_cpu())

So it is unrelated with your patch, I will send a bug report tomorow.

Furthermore, you can add:
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
Regards
