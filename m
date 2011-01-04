From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 04 Jan 2011 12:50:28 -0500 (EST)
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <20110104165347.GA24935@n2100.arm.linux.org.uk>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
	<20110104165347.GA24935@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1101041225070.22191@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:

> On Tue, Jan 04, 2011 at 09:32:41AM -0500, Nicolas Pitre wrote:
> > On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> > > This is basically my patch with a few blank lines removed, a couple
> > > of \n's also removed, a #error if __virt_to_phys is defined by a platform,
> > > a minor tweak to the assembly and it being only usable on PXA.
> > > 
> > > I much prefer my patch over this as anyone can use it.  That's one of
> > > the reasons why I arranged the code testing for __virt_to_phys as I
> > > did, so the config option could be offered without having a big long
> > > dependency list attached to it.
> > 
> > I don't think offering the option that people can turn on and not having 
> > the code effectively perform as expected is a good idea.  People might 
> > be expecting the feature to be there while in practice it is ignored 
> > which would lead to confusion.
> 
> Our aims are different then.  My aim is to move the code to a point where
> it works for _everyone_ it possibly can - and theoretically that's every
> platform except:
> 
> 1. MSM due to their PHYS_OFFSET being 2MB aligned, rather than the more
>    normal 256MB alignment.
> 2. Anyone with complex V:P mappings

I completely agree with that goal.  But I'd prefer for those platforms 
which are not yet supported by this feature not to be able to compile 
rather than silently ignore the feature and not behave as expected.

> (1) is dealt with easily by a dependency in the configuration preventing
> the option being visible.  (2) is dealt with at runtime by ignoring the
> configuration option - resulting in the p2v tables being empty.  The end
> result will still run on the platform, but it won't do the relocation
> stuff.  (2) could also be dealt with by adding the necessary dependencies
> to the configuration option which is the longer term solution.

Since (2) is not supported yet with this config option selected, I think 
it is best to simply #error the build.

> Lastly, marking the option as 'EXPERIMENTAL' is there to convey that it
> may not work for everyone, and people should expect things not to work if
> they enable such an option (and report when that's the case.)

Sure, hence my #error in the patch which is even easier to diagnose and 
self explanatory.

And in fact I think that this would indeed be simpler to just fall back 
to a global variable for PHYS_OFFSET when a platform defines its own 
p2v/v2p mapping.  This way, the goal of this feature would be 
universally available.

OTOH, one of the long term goal for this is to be able to support more 
than one SOC family with the same kernel binary.  I don't think it is 
worth extending this support to be able to also include those platforms 
with a complex v2p and p2v translation, as the overhead for all included 
platforms would simply kill the advantages of having a single kernel 
binary.  So I still don't see a big compelling reason to support (2) at 
all with this, except maybe only for kdump purposes.

> Another reason why selecting this option is wrong is that it is incompatible
> with XIP.  If you're going to unconditionally enable it for platforms like
> PXA, make sure you strip out all of PXA's XIP support before you do so,
> otherwise you'll build a kernel which has absolutely no way of ever booting.

Well, my idea is more about a global config option that makes sense for 
the user, like "physically position independent kernel binary" or 
something like that.  This option would of course be dependent on !XIP 
and !ZBOOT_ROM, and would in turn select AUTO_ZRELADDR and 
ARM_PATCH_PHYS_VIRT.  In fact, maybe those options should all be 
consolidated under a single generic config option expressing the goal to 
be achieved instead of the implementation strategy.

> > As to the authorship, since I drafted the original design, Eric Miao did 
> > the first implementation to validate the concept, and the code surviving 
> > is mostly yours, I didn't know who to singularly attribute the patch to 
> > in the author field.  I can put yourself there if you feel this is more 
> > appropriate.
> 
> The correct thing to do is to ensure that it has Eric's and my 
> sign-offs. 

Fair enough.

> If you compare Eric's to my version, mine has a fair amount of 
> changes.

Yep, and I'm now adding to the mix.  So this is a good idea to clarify 
this issue.


Nicolas
