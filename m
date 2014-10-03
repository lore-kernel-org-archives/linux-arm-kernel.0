From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Oct 2014 16:55:36 +0200
Subject: [PATCH 0/3] ARM: Meson6: enable SMP
In-Reply-To: <20141003070913.GH4039@lukather>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
 <1867489.B8srtuItsD@wuerfel> <20141003070913.GH4039@lukather>
Message-ID: <3923222.mSUH8smfac@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 October 2014 09:09:13 Maxime Ripard wrote:
> On Thu, Oct 02, 2014 at 05:50:35PM +0200, Arnd Bergmann wrote:
> > On Thursday 02 October 2014 17:38:04 Maxime Ripard wrote:
> > > On Thu, Oct 02, 2014 at 05:26:53PM +0200, Arnd Bergmann wrote:
> > > > On Thursday 02 October 2014 16:54:26 Maxime Ripard wrote:
> > > > > On Thu, Oct 02, 2014 at 04:44:20PM +0200, Arnd Bergmann wrote:
> > > > > > On Tuesday 30 September 2014 22:45:38 Carlo Caione wrote:
> > > > > > > On mar, set 30, 2014 at 12:22:21 +0200, Arnd Bergmann wrote:
> > > > > > > > On Tuesday 30 September 2014 10:46:46 Carlo Caione wrote:
> > > > > > > > > On mar, set 30, 2014 at 10:43:52 +0200, Carlo Caione wrote:
> > > > > > > > > > Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> > > > > > > > > > pieces to boot the secondary CPU.
> > > > > > > > > 
> > > > > > > > > Sorry for the double sending.
> > > > > > > > > Forgot to CC LAKML.
> > > > > > > > 
> > > > > > > > Looks good to me in principle, but I wonder about the CPU enable method.
> > > > > > > > Are you able to implement PSCI in u-boot like it was done for allwinner?
> > > > > > > > 
> > > > > > > > This is mostly a question of whether the system comes up in secure mode
> > > > > > > > or non-secure mode.
> > > > > > > 
> > > > > > > I would be able if I had the u-boot source code or the possibility to
> > > > > > > flash the board I'm using. Unfortunately at this moment I don't have
> > > > > > > either. Probably in the near future I'll be able to implement PSCI in
> > > > > > > u-boot since Amlogic is kindly starting to provide documentation but now
> > > > > > > this is the best I can do.
> > > > > > 
> > > > > > Ok, I see. Let's give Amlogic some more time then. I think it's better
> > > > > > to merge other parts of the platform first when we can reasonably assume
> > > > > > that we don't have to change the binding any more.
> > > > > > 
> > > > > > It would be a shame to merge this now and then make it obsolete by
> > > > > > implementing PSCI but still having to carry around the original code
> > > > > > for compatibility reasons.
> > > > > 
> > > > > More likely, PSCI is not going to be supported by the bootloaders of
> > > > > the devices already in the wild, so we still have to provide them an
> > > > > option. And even when it will, you'll still have to support both the
> > > > > devices with the old bootloaders, and the one with the new.
> > > > 
> > > > It depends on how common the old boot loaders are, and whether it's
> > > > possible to upgrade them. If we can get to the point where you can
> > > > boot a kernel with a single CPU and have an easy way to update the
> > > > boot loader, we don't need to support it.
> > > 
> > > I thought I heard Olof at some point ranting about this kind of
> > > requirements, but ok 
> > > 
> > > Still, holding off until something that hypothetical happens looks a
> > > bit odd, doesn't it?
> > 
> > I was mainly trying to follow what you are doing in mach-sunxi, but maybe
> > I misunderstood what your plans are for PSCI support there.
> 
> Well, we did it only for the A20, because:
>   - We had a very good bootloader support already
>   - And we needed it to be able to use it for virtualization
> 
> AFAIK, the amlogic guys don't have such a bootloader yet, and can't
> use the virtualization, since it's a cortex-a9.
> 
> Note that for all the other SoCs, where we don't have such a
> bootloader support, we do have smp_ops, or will have, because we can
> just use Allwinner's bootloader.

Ok, I see.

> > mach-meson is still in a very early stage, and it's not like SMP support
> > is the most important feature missing from it. If there are good reasons
> > to include the current patches in 3.19, we can do that.
> 
> That's more of a mainlining scheduling discussion, and I can't really
> argue with that. I wouldn't have done it in that order, but I'm not
> really sure we can do that on that argument alone.
> 
> The only question that should matter I guess is whether this feature
> improves the overall support of the SoC, and whether the code is clean
> enough. If both answers are yes, then I think it should come in.

Makes sense. We should plan to merge it for 3.19 then.

	Arnd
