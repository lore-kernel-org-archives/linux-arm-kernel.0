From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 10:00:27 +0100
Subject: [PATCH 2/4] ARM: sirf: add atlas7 machine support
In-Reply-To: <CAGsJ_4xzn0mHXa85yMSOERt23as7W=PfkfyzC6xrXo5wBDcR1g@mail.gmail.com>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <4739415.xM06V8YCmL@wuerfel>
 <CAGsJ_4xzn0mHXa85yMSOERt23as7W=PfkfyzC6xrXo5wBDcR1g@mail.gmail.com>
Message-ID: <6143383.aIfcyE6KvX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 December 2014 22:50:16 Barry Song wrote:
> 2014-12-31 6:34 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 25 December 2014 16:34:18 Barry Song wrote:
> >> +DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
> >> +       /* Maintainer: Barry Song <baohua.song@csr.com> */
> >> +       .smp            = smp_ops(sirfsoc_smp_ops),
> >> +       .map_io         = sirfsoc_map_io,
> >> +       .init_late      = sirfsoc_init_late,
> >> +       .dt_compat      = atlas7_dt_match,
> >> +MACHINE_END
> >
> > Can you check if the sirfsoc_map_io function is still required?
> > My guess is that you can just replace sirfsoc_map_scu() with a
> > call of ioremap in sirfsoc_smp_prepare_cpus, and drop sirfsoc_map_lluart()
> > entirely in favor of the default debug_ll_io_init() function that
> > is called when map_io is NULL.
> >
> > Also, how about merging the entries for atlas6 and atlas7, and just
> > having multiple compatible strings in atlas_dt_match?
> 
> the situation is that atlas7 is not a family of atlas6. atlas6 is much
> similar with prima2, but atlas7 is actually a replacement of earlier
> marco family.
> 
> atlas7 is a dual core cortex-a7, but atlas6 is a single core
> cortex-a9. and atlas7 is using a Network on Chip(NoC) bus architecture
> which is completely not same with atlas6 which is using a tree-type
> bus, so atlas7 will have some machine-specific codes like NoC fireware
> which should be in machine specific codes to handle external data
> aborts things for security protection. and more important, atlas7 has
> much different IP modules with atlas6 for things like GPS,
> connectiviy, software digital radios. and atlas7 has a more cortex-M3
> for CAN stack, so this will involve some IPC drivers. and one more DSP
> for audio processing.
> 
> this means atlas7 is not a simple atlas6+1, it is a new chip.  i have
> a feeling atlas7 should be highlighted as a seperate machine.

Ideally, I'd like to see a single DT_MACHINE_START for all of the
sirf machines once you have eliminated all the callbacks, but
until then, using one per SoC type for consistency is fine with me
as well, so just leave it that way for now.

	Arnd
