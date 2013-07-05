From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jul 2013 18:42:44 +0200
Subject: scripts/kallsyms: Avoid ARM veneer symbols
In-Reply-To: <20130705145100.GE2932@localhost.localdomain>
References: <2983817.Xe2505Drlj@wuerfel> <201307031803.04501.arnd@arndb.de>
 <20130705145100.GE2932@localhost.localdomain>
Message-ID: <201307051842.44721.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013, Dave P Martin wrote:
> On Wed, Jul 03, 2013 at 06:03:04PM +0200, Arnd Bergmann wrote:
> > On Tuesday 25 June 2013, Dave Martin wrote:
> > suggest would significantly increase the build time since the
> > kallsyms+linker stage cannot be done in parallel or sped up
> > using ccache.
> > 
> > > But including the veneer symbols in kallsyms is arguably not all
> > > that useful.
> > > 
> > > The main potential effect is that profiling might occasionally
> > > sample the PC as being in a completely bogus function which it
> > > never passed through at all, because of the way kallsyms tracks
> > > only symbol locations and not sizes (if I remember right) --
> > > so a veneer will actually get accounted against some arbitrary
> > > adjacent function.
> > > 
> > > I don't know how much this matters.
> > 
> > Interesting point. No idea how often that happens. All the veneers
> > for one section are in one place though, so we could in theory
> > add a kallsyms entry for that section as long as can identify
> > it.
> 
> We could collapse any contiguous sequence of __veneer_* symbols down
> to a single symbol to mark those holes.
> 
> However, many kallsyms passes could still be needed: each pass might add
> extra veneer blocks, unless the size of kallsyms data is identical to
> that in the previous pass.  The expected convergence rate is faster,
> though.

Right, it wouldn't guarantee to converge after two passes, just make
it very likely.

> > > > The easiest solution is to skip veneers in kallsyms in the
> > > > same way we already skip a couple of other symbols.
> 
> Your suggestion of omitting the symbols completely seems to be the only
> way to ensure convergence in 2 passes, so far as I can see.
> 
> 
> Adding size information to every entry in kallsyms would make it possible
> to identify the "holes" without potentially requiring many kallsyms passes,
> but it would bloat the table.  The extra info would be interesting only
> for a tiny subset of the symbols.  I expect people aren't going to like
> that much.
> 
> So I guess your original suggestion may be the best thing to do for now,
> after all...
> 
> There is no proper reserved symbol namespace for linker-generated symbols,
> so a real symbol could have the name __*_veneer, at which point things
> start to get really confusing.  But hopefully that won't happen much.
> I don't see any such symbol right now, and hopefully nobody will be so
> silly as to add one...
> 
> If we eventually need to fix the bogus symbol resolution problem, I can't
> see an alternative to adding size info to every symbol.  But we should
> leave that for now.  It doesn't sound like a serious problem.

Unfortunately I have run into additional problems now after doing a few
hundred more builds:

* not all veneers end in _veneer, some also end in _from_arm or _from_thumb.
  This is easy enough to check for in the same way I did for _veneer.

* There are actually symbols without a name on ARM, which screws up the
  kallsyms.c parser. These also seem to be veneers, but attached to some
  random function:

$ nm obj-tmp/.tmp_vmlinux1 | head
c09e8db1 t 
c09e8db5 t 
c09e8db9 t    # <==========
c09e8dbd t 
c0abfc29 t 
c0008000 t $a
c0f7b640 t $a

$ objdump -Dr obj-tmp/.tmp_vmlinux1 | grep -C 30 c09e8db.
c0851fcc <wlc_phy_edcrs_lock>:
c0851fcc:       b538            push    {r3, r4, r5, lr}
c0851fce:       b500            push    {lr}
c0851fd0:       f7bb d8dc       bl      c000d18c <__gnu_mcount_nc>
c0851fd4:       f240 456b       movw    r5, #1131       ; 0x46b
c0851fd8:       4604            mov     r4, r0
c0851fda:       f880 14d5       strb.w  r1, [r0, #1237] ; 0x4d5
c0851fde:       462a            mov     r2, r5
c0851fe0:       f44f 710b       mov.w   r1, #556        ; 0x22c
c0851fe4:       f7ff fe6d       bl      c0851cc2 <write_phy_reg>
c0851fe8:       4620            mov     r0, r4
c0851fea:       462a            mov     r2, r5
c0851fec:       f240 212d       movw    r1, #557        ; 0x22d
c0851ff0:       f7ff fe67       bl      c0851cc2 <write_phy_reg>
c0851ff4:       4620            mov     r0, r4
c0851ff6:       f240 212e       movw    r1, #558        ; 0x22e
c0851ffa:       f44f 7270       mov.w   r2, #960        ; 0x3c0
c0851ffe:       f196 fedb       bl      c09e8db8 <tpci200_free_irq+0x78>  # <===========
c0852002:       4620            mov     r0, r4
c0852004:       f240 212f       movw    r1, #559        ; 0x22f
c0852008:       f44f 7270       mov.w   r2, #960        ; 0x3c0
c085200c:       e8bd 4038       ldmia.w sp!, {r3, r4, r5, lr}
c0852010:       f7ff be57       b.w     c0851cc2 <write_phy_reg>


... # in tpci200_free_irq:
c09e8d9e:       e003            b.n     c09e8da8 <tpci200_free_irq+0x68>
c09e8da0:       f06f 0415       mvn.w   r4, #21
c09e8da4:       e000            b.n     c09e8da8 <tpci200_free_irq+0x68>
c09e8da6:       4c01            ldr     r4, [pc, #4]    ; (c09e8dac <tpci200_free_irq+0x6c>)
c09e8da8:       4620            mov     r0, r4
c09e8daa:       bdf8            pop     {r3, r4, r5, r6, r7, pc}
c09e8dac:       fffffe00                        ; <UNDEFINED> instruction: 0xfffffe00
c09e8db0:       f4cf b814       b.w     c06b7ddc <bna_enet_sm_chld_stop_wait_entry>
c09e8db4:       f53e bed8       b.w     c0727b68 <gem_do_stop>
c09e8db8:       f668 bf83       b.w     c0851cc2 <write_phy_reg>           # <==========
c09e8dbc:       d101            bne.n   c09e8dc2 <tpci200_free_irq+0x82>
c09e8dbe:       f435 b920       b.w     c061e002 <twl_reset_sequence+0x34c>

It makes no sense to me at all that a function in one driver can just call
write_phy_reg a couple of times, but need a veneer in the middle, and put
that veneer in a totally unrelated function in another driver!

If this is a binutils bug or gcc bug, we should probably just fix it, but it
might be easier to work around it by changing kallsyms.c some more.

> > > > -/*
> > > > - * This ignores the intensely annoying "mapping symbols" found
> > > > - * in ARM ELF files: $a, $t and $d.
> > > > - */
> > > >  static inline int is_arm_mapping_symbol(const char *str)
> > > 
> > > The function's name is now wrong.  Should it be renamed or split up?
> > 
> > Sure I can rename it. Any suggestions?
> 
> Maybe just something more generic like is_arm_special_symbol()?

Ok, I can do that.

	Arnd
