From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 20 Feb 2014 11:18:07 -0700
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <20140220094554.GI11878@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <20140218185703.GI29304@obsidianresearch.com>
 <20140218190212.GE7862@titan.lakedaemon.net>
 <20140219222103.GB17826@obsidianresearch.com>
 <20140220094554.GI11878@lunn.ch>
Message-ID: <20140220181807.GC19893@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 10:45:54AM +0100, Andrew Lunn wrote:

> > Presumably the watchdog patchset needs to be a dependency for this? Is
> > there a git URL for it?
> 
> I don't have a tree with both combined. I guess there is a branch in
> 
> https://github.com/MISL-EBU-System-SW/mainline-public.git
> 
> with it.

Thanks, I'll take a peek
  
> > Also, reviewing my 3.13 Kconfig vs the 3.14 Kconfig with the patch,
> > these options are now forced on, and I'd prefer them to be off:
> >  CONFIG_ARM_PATCH_PHYS_VIRT=y
> 
> I suspect that comes from multiplatform.

Right

> >  CONFIG_GENERIC_PHY=y
> >  CONFIG_PHY_MVEBU_SATA=y
> 
> If you disable SATA, you can disable these two.  We have had so much
> breakage with this, that i want to keep away from it for a while to
> let it settle. I can then go back and see about making it truly
> optional.

No, I have SATA off, it is being selected unconditionally:

config PHY_MVEBU_SATA
        def_bool y
        depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD
        depends on OF
        select GENERIC_PHY

Does it need 'depends on ATA'?

> > 	select PCI_QUIRKS if PCI
> >           ^^^^^^^^^^^^^^^^^^^
> >        This can go now, it was something I added to support the old
> >        non-dt kirkwood PCI-E driver. The new DT MVEBU driver does not
> >        require it.
> 
> This has nothing directly to do with this patchset. Please could you
> supply a patch?

Sure, when your patchset is merged I can look at the QUIRKS setting
for mvebu

> > And I feel PCI, POWER_SUPPLY, POWER_RESET, POWER_RESET_GPIO,
> > REGULATOR, REGULATOR_FIXED_VOLTAGE should not be forced in the master
> > KConfig as not all boards require them.
> 
> At the moment, we need PCI in order to get the SoC ID. 

So this is happening because mvebu-soc-id.c is being unconditionally
compiled, even though it is not needed on anything except
armada-370-xp ?

> Gregory has a patch which will help with this, only selecting the
> minimum needed. However, ARCH_KIRKWOOD selected both PCI and
> PCI_QUIRKS, so i think removing them should be in a separate cleanup
> patch, which can follow once the series is accepted.

Agree

> I added the POWER_* and REGULATOR_* options. I will move them into
> mvebu_v5_defconfig and multi_v5_defconfig instead.

Thanks

> > Maybe make them forced if !EMBEDDED or something?
> 
> I think we first need to define what EMBEDDED means. For me a NAS is
> an embedded system, and it is various NAS boxes which want these.

EMBEDDED is just a master option to expose KConfig choices that normal
people wouldn't want to mess with (eg the ability to disable
REGULATOR). It seems to have fallen out of favor these days I guess,
maybe EXPERT is the way to go now?

Jason
