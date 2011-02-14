From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 09:27:51 +0900
Subject: [PATCH v3 2/5] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <20110211115853.GC23404@n2100.arm.linux.org.uk>
References: <20110206191117.GA17808@n2100.arm.linux.org.uk>
	<E1PmA28-0000AC-2t@rmk-PC.arm.linux.org.uk>
	<20110207120103.GC31929@n2100.arm.linux.org.uk>
	<20110207121052.GD31929@n2100.arm.linux.org.uk>
	<AANLkTintBD2Gfb3pkPZPe2mreU5EatUnNwUqR-id7q+M@mail.gmail.com>
	<20110207133457.GE31929@n2100.arm.linux.org.uk>
	<AANLkTi=B45PuOErxR49Gfhfq6-=y_NugbWBLBo0MEoCt@mail.gmail.com>
	<20110207141734.GG31929@n2100.arm.linux.org.uk>
	<AANLkTimCtaSZ=CHT5snWZ496_bi4sH=0LU7vJ-Jfh=dP@mail.gmail.com>
	<20110211115853.GC23404@n2100.arm.linux.org.uk>
Message-ID: <000001cbcbde$0e69bce0$2b3d36a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Wed, Feb 09, 2011 at 07:15:25PM -0800, Colin Cross wrote:
> > The diagnostic register also needs to be saved to keep the errata bits
> > set in __v7_setup.
> 
> Saving I've no problem with.  Restoring gets hairy with kernels running
> in non-secure mode, as we can't just write the register - we don't know
> whether we are running in secure or non-secure mode.  A write to the
> register in NS mode will crash.
> 
> Santosh: is the diagnostic register on OMAP4 re-initialized by the secure
> code on OMAP?
> 
> > > +       stmia   r0, {r4 - r11}
> > > +       ldmfd   sp!, {r4 - r11, pc}
> > > +ENDPROC(cpu_v7_do_suspend)
> > > +
> > > +ENTRY(cpu_v7_do_resume)
> > > +       mov     ip, #0
> > > +       mcr     p15, 0, ip, c8, c7, 0   @ invalidate TLBs
> > > +       mcr     p15, 0, ip, c7, c5, 0   @ invalidate I cache
> >
> > Does this need the same ALT_SMP/ALT_UP combo as v7_flush_icache_all?
> 
> That depends whether you the CPU which is resuming is part of a coherent
> SMP system at that point.  This instruction will invalidate the I-cache
> for the local CPU only, whereas the c7, c1 variant will invalidate the
> instruction caches of all CPUs within the inner sharable domain.
> 
> Has anything changed in the other CPUs as a result of this CPU resuming
> at this point?  I don't think so, so I think we just need to ensure that
> the local CPU instruction cache is invalidated at this point.
> 
> > Tegra2 suspend and cpuidle works on top of this patch and the patch
> > that adds SMP support to sleep_save_sp.  Tegra seems to need to
> > invalidate the entire l1 data cache before enabling it,
> 
> As it's undefined what state the data cache is in on resume, I'm surprised
> the s5pv210 code doesn't also need a D-cache invalidate too.  Maybe Samsung
> folk can answer that.
> 

Now, it works fine with omission D-cache invalidate on S5PV210. Basically, Samsung S5P SoCs have some kind of hardware initialization code. So I'm not sure it has something for it, will/need to check it to hardware guys soon :) Then let you know about that ;)

As a note, I will test your updated generic CPU suspend/resume support on Samsung SoCs also, if any available branch which has p2v patches for it, please let me know. Anyway sorry for late testing on board.

Have a nice weekend.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
