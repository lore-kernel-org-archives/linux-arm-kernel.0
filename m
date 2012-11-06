From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 13:00:08 +0000
Subject: [PATCH 15/15] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <509904CC.8050708@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-16-git-send-email-vaibhav.bedia@ti.com>
 <87txt4aqyc.fsf@deeprootsystems.com> <50983510.80000@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04FBA@DBDE01.ent.ti.com>
 <509904CC.8050708@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC05082@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 18:08:36, Shilimkar, Santosh wrote:
> On Tuesday 06 November 2012 06:29 AM, Bedia, Vaibhav wrote:
> > Hi Santosh, Kevin
> >
> > On Tue, Nov 06, 2012 at 03:22:16, Shilimkar, Santosh wrote:
> > [...]
> >
> >>>> +
> >>>> +/*
> >>>> + * This a subset of registers defined in drivers/memory/emif.h
> >>>> + * Move that to include/linux/?
> >>>> + */
> >>>
> >>> I'd probably suggest just moving the register definitions you
> >>> need into <plat/emif_plat.h> so they can be shared with the driver.
> >>>
> >>> Also, the EMIF stuff would benefit greatly from using symbolic defines
> >>> for the values being written.  Probably having those in
> >>> <plat/emif_plat.h> would also help out here.
> >>>
> >>> Or, maybe the EMIF driver can provide some self-contained stubs that can
> >>> be copied to OCP RAM for the functionality needed here?
> >>>
> >>> Santosh, what do you think of that?
> >>>
> >> Thats what I mentioned in my comment. I also don't know why such a bad
> >> hardware choice was made when we have perfectly working EMIF IP across
> >> low power states. Even the self refresh control is managed inside
> >> hardware upon idle.  My guess is DDR self-refresh might be the reason
> >> to use OCMC RAM.
> >>
> >> In either case, Keeping EMIF changes separate as part of EMIF
> >> driver/platform code is right way to go about it. May be the
> >> disable_selfrefresh() might need to kept in assembly files since it
> >> needs to be running from SRAM but rest need not be part of
> >> PM code.
> >>
> >
> >
> > In the suspend path we do lot of I/O manipulations to lower final power
> > number which must be done after the external memory has gone into
> > self-refresh. So, these steps will have to be done from code in OCMC RAM.
> >
> Only the DDR IO needs to be done after memory enters into self refresh.
> Rest of the IOs can be handled and moved to low power modes before DDR
> being in self refresh, No ?
> 

All the code is related to DDR IOs only. We have some code for changing the
pull configuration of the DATA and CMD macros of the PHY and then some code
for DDR VTP control. We also switch over the DDR IOs to mDDR mode to lower
the leakage.

> > Other than saving the EMIF configuration the other thing that we do during
> > suspend from assembly is to put the PLLs in bypass. We could possibly move
> > the DISP PLL bypass to C code. MPU PLL is another candidate but this might
> > add in more delays in the suspend and abort sequence (I don't have any
> > delay numbers to justify this right now)
> >
> So DPLLS doesn't support low power bypass mode which should take
> care of itself on clock gating ? Are the DPLL IPs different than
> what they are on OMAP ?

Same IP but no auto-mode :(

> 
> > The resume path undoes the I/O manipulations and then restores the EMIF
> > configuration all of which I think is necessary before we can jump back to
> > external memory.
> >
> As I memtioned above, you should limit these IOs to only DDR IOs.
> 
> > So, I think we'll have just the EMIF context save and possibly the PLL
> > bypass for DISP PLL during suspend that we can move out of assembly.
> >
> EMIF context save also can be done in advance. Restore is what you need
> to take care in early resume before bringing out DDR out of self
> refresh.
>

Yes I can move the context save earlier. Will try that out and put in the
next version.
 
> > Coming to point of sharing the EMIF register definitions, with the recent
> > changes to move around the header files out of plat-omap, is it ok to
> > add in the required offsets and related bit-field definitions from
> > the EMIF driver to plat-omap?
> >
> We can have that in linux/include/* as well if the register
> defines can be shared.
> 

Ok.

Regards,
Vaibhav 
