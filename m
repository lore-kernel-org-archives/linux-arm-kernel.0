From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 18:06:20 +0000
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <alpine.LFD.2.00.1101041225070.22191@xanadu.home>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
	<20110104165347.GA24935@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041225070.22191@xanadu.home>
Message-ID: <20110104180620.GC24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 12:50:28PM -0500, Nicolas Pitre wrote:
> On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> > Our aims are different then.  My aim is to move the code to a point where
> > it works for _everyone_ it possibly can - and theoretically that's every
> > platform except:
> > 
> > 1. MSM due to their PHYS_OFFSET being 2MB aligned, rather than the more
> >    normal 256MB alignment.
> > 2. Anyone with complex V:P mappings
> 
> I completely agree with that goal.  But I'd prefer for those platforms 
> which are not yet supported by this feature not to be able to compile 
> rather than silently ignore the feature and not behave as expected.
> 
> > (1) is dealt with easily by a dependency in the configuration preventing
> > the option being visible.  (2) is dealt with at runtime by ignoring the
> > configuration option - resulting in the p2v tables being empty.  The end
> > result will still run on the platform, but it won't do the relocation
> > stuff.  (2) could also be dealt with by adding the necessary dependencies
> > to the configuration option which is the longer term solution.
> 
> Since (2) is not supported yet with this config option selected, I think 
> it is best to simply #error the build.
> 
> > Lastly, marking the option as 'EXPERIMENTAL' is there to convey that it
> > may not work for everyone, and people should expect things not to work if
> > they enable such an option (and report when that's the case.)
> 
> Sure, hence my #error in the patch which is even easier to diagnose and 
> self explanatory.

You're making a mountain out of a mole hill.  At present, there is one
platform which defines its own complex v:p mapping and that is Realview,
but only when sparsemem is enabled.  As already mentioned, MSM is the
only other platform which can't use this method.  So that's a simple
dependency line against the config.

The other breakages are use of PHYS_OFFSET as an initializer which is a
build-error inducing failure, and adopting the approach I outlined in my
4 patch set results in many of those going away before we get support for
this merged - even better, if PHYS_OFFSET were always to be variable-like,
then we'd stop any new uses even appearing.

> And in fact I think that this would indeed be simpler to just fall back 
> to a global variable for PHYS_OFFSET when a platform defines its own 
> p2v/v2p mapping.  This way, the goal of this feature would be 
> universally available.

Not really.  Platforms define their own mapping because it's not a simple
addition or subtraction, but because it's a complex non-linear conversion.

#define __phys_to_virt(phys)                                            \
        ((phys) >= 0x80000000 ? (phys) - 0x80000000 + PAGE_OFFSET2 :    \
         (phys) >= 0x20000000 ? (phys) - 0x20000000 + PAGE_OFFSET1 :    \
         (phys) + PAGE_OFFSET)

#define __virt_to_phys(virt)                                            \
         ((virt) >= PAGE_OFFSET2 ? (virt) - PAGE_OFFSET2 + 0x80000000 : \
          (virt) >= PAGE_OFFSET1 ? (virt) - PAGE_OFFSET1 + 0x20000000 : \
          (virt) - PAGE_OFFSET)

This doesn't lend itself in any way to a variable-based PHYS_OFFSET, and
could never be subsituted code-wise at run time without significant
effort.

In fact, platforms which have complex V:P mappings can _never_ be a part
of a kernel which has this feature enabled.
