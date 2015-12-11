From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Dec 2015 22:34:16 +0000
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <1887582.W42jA1d2lP@wuerfel>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <6991913.FSOzozNbSC@wuerfel>
 <alpine.LFD.2.20.1512111125330.26920@knanqh.ubzr>
 <1887582.W42jA1d2lP@wuerfel>
Message-ID: <20151211223415.GY8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 10:50:02PM +0100, Arnd Bergmann wrote:
> On Friday 11 December 2015 12:10:29 Nicolas Pitre wrote:
> > On Fri, 11 Dec 2015, Arnd Bergmann wrote:
> > > #ifdef CONFIG_CPU_PJ4B
> > >         .type   __v7_pj4b_proc_info, #object
> > > __v7_pj4b_proc_info:
> > >         .long   0x560f5800
> > >         .long   0xff0fff00
> > >         __v7_proc __v7_pj4b_proc_info, __v7_pj4b_setup, proc_fns = pj4b_processor_functions
> > >         .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> > > #endif
> > > 
> > > 
> > > Can someone have a look and tell me that I'm wrong when I read this
> > > as matching both PJ4 and PJ4B (and PJ4B-MP)?
> > > 
> > > Either I'm misreading this, or we do the wrong thing in configurations
> > > that include both PJ4B (berlin, mvebu) and PJ4 (MMP2/dove).
> > 
> > I don't have the relevant documentation to validate it.  And I'd prefer 
> > if this was sorted out in a separate patch.  Maybe I should just drop 
> > the PJ4 variants from this patch for now.
> 
> To clarify: that point had nothing to do with your patch, I just think
> I found an existing kernel bug that will cause pj4b_processor_functions
> to be used on PJ4 (Dove, MMP2) in a kernel that includes both PJ4 and
> PJ4B (Armada 370/XP, Berlin).

It does look like it will end up matching a PJ4 CPU against the PJ4B entry
if it's enabled.  I think the question that needs to be asked is why the
mask is soo loose, and the past history gives us some information.  The
loosening of the mask was done by Gregory Clement a couple of years ago:

    ARM: 7754/1: Fix the CPU ID and the mask associated to the PJ4B

    This commit fixes the ID and mask for the PJ4B which was too
    restrictive and didn't match the CPU of the Armada 370 SoC.

 __v7_pj4b_proc_info:
-       .long   0x562f5840
-       .long   0xfffffff0
+       .long   0x560f5800
+       .long   0xff0fff00

So it was to include Armada 370.  So this now brings up the question...
what is the MIDR value used in Armada 370?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
