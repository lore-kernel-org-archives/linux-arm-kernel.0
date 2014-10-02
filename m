From: atull@opensource.altera.com (atull)
Date: Thu, 2 Oct 2014 16:03:55 -0500
Subject: [PATCH 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <3341525.7GDFQS2rGu@wuerfel>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <542C26B6.7010302@opensource.altera.com> <20141001231646.GB1529@amd>
 <3341525.7GDFQS2rGu@wuerfel>
Message-ID: <alpine.DEB.2.02.1410021552470.26097@atx-linux-37>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Oct 2014, Arnd Bergmann wrote:

> On Thursday 02 October 2014 01:16:46 Pavel Machek wrote:
> > > > 
> > > > struct socfpga_reset_manager {
> > > >         u32     status;
> > > >         u32     ctrl;
> > > >         u32     counts;
> > > >         u32     padding1;
> > > >         u32     mpu_mod_reset;
> > > >         u32     per_mod_reset;
> > > >         u32     per2_mod_reset;
> > > >         u32     brg_mod_reset;
> > > > };
> > > > 
> > > > from u-boot. Unlike macros, structs have advantages that typos lead to
> > > > easier-to-see failure modes... (And they are easier to read/parse,
> > > > too).
> > > > 
> > > 
> > > Copying from uboot sounds good, but I already know that the CPU reset
> > > offset is different for our next SOC, Arria 10. The Arria 10 SOC should
> > > still be able to use the same MSL as Cyclone5 and Arria5, but with a few
> > > differences. One of them being, the CPU1 reset offset is at 0x20 instead
> > > of 0x10. So I think having a macro for this one register is a bit
> > > cleaner than having to define a whole new struct for Arria10.
> > 
> > I don't think "whole new struct" is a problem. At least it will be
> > plain to see what changed (which will get easily lost in ifdefs.
> > 
> > struct cyclone5_reset_manager {
> >         struct socfpga_reset_manager common;
> >         u32 brg_mod_reset;
> > }
> > 
> > struct aria10_reset_manager {
> >         struct socfpga_reset_manager common;
> >         char filler[0x10];
> >         u32 brg_mod_reset;
> > }
> > 
> > if (of_machine_is_compatible("altr,socfpga-arria10"))
> >         __raw_writel(0, (struct cyclone5_reset_manager *) rst_manager_base_addr->brg_mod_reset));
> > else
> >         __raw_writel(0, (struct aria10_reset_manager *) rst_manager_base_addr->brg_mod_reset));
> > 
> > ...does not sound that bad. (And you'll need some nice solution for
> > u-boot, anyway...)
> 
> I think it would be better to just add more fields and access a different
> field based on the SoC type than cast the structs around.
> 
> Also, never use __raw_writel unless you know exactly what you are doing.
> This should use writel, or possibly writel_relaxed.

Arnd, Pavel,

I appreciate the comments.

I will fix this to not be a __raw_writel.

> 
> Finally, don't sprinkle of_machine_is_compatible() checks all over the
> place. Make the decision once when you initially probe the machine.
> 
> 	Arnd
> 

The changes for aria10 are minor: a different DT plus two register changes.  
I'm not introducing aria10 support in this patch.  This is a 16 line patch
for fixing something in an established machine layer.  If I have to come up
with a new scheme for accessing registers, then I will need to touch other
code that this patch does not intend to change.

Alan
