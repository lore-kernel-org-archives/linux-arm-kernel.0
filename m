From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Jan 2011 16:53:47 +0000
Subject: [PATCH 1/4] ARM: runtime patching of __virt_to_phys() and
	__phys_to_virt()
In-Reply-To: <alpine.LFD.2.00.1101040926100.22191@xanadu.home>
References: <1294129208-15201-1-git-send-email-nico@fluxnic.net>
	<1294129208-15201-2-git-send-email-nico@fluxnic.net>
	<20110104084517.GA9791@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101040926100.22191@xanadu.home>
Message-ID: <20110104165347.GA24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 09:32:41AM -0500, Nicolas Pitre wrote:
> On Tue, 4 Jan 2011, Russell King - ARM Linux wrote:
> > This is basically my patch with a few blank lines removed, a couple
> > of \n's also removed, a #error if __virt_to_phys is defined by a platform,
> > a minor tweak to the assembly and it being only usable on PXA.
> > 
> > I much prefer my patch over this as anyone can use it.  That's one of
> > the reasons why I arranged the code testing for __virt_to_phys as I
> > did, so the config option could be offered without having a big long
> > dependency list attached to it.
> 
> I don't think offering the option that people can turn on and not having 
> the code effectively perform as expected is a good idea.  People might 
> be expecting the feature to be there while in practice it is ignored 
> which would lead to confusion.

Our aims are different then.  My aim is to move the code to a point where
it works for _everyone_ it possibly can - and theoretically that's every
platform except:

1. MSM due to their PHYS_OFFSET being 2MB aligned, rather than the more
   normal 256MB alignment.
2. Anyone with complex V:P mappings

(1) is dealt with easily by a dependency in the configuration preventing
the option being visible.  (2) is dealt with at runtime by ignoring the
configuration option - resulting in the p2v tables being empty.  The end
result will still run on the platform, but it won't do the relocation
stuff.  (2) could also be dealt with by adding the necessary dependencies
to the configuration option which is the longer term solution.

Lastly, marking the option as 'EXPERIMENTAL' is there to convey that it
may not work for everyone, and people should expect things not to work if
they enable such an option (and report when that's the case.)

Another reason why selecting this option is wrong is that it is incompatible
with XIP.  If you're going to unconditionally enable it for platforms like
PXA, make sure you strip out all of PXA's XIP support before you do so,
otherwise you'll build a kernel which has absolutely no way of ever booting.

> As to the authorship, since I drafted the original design, Eric Miao did 
> the first implementation to validate the concept, and the code surviving 
> is mostly yours, I didn't know who to singularly attribute the patch to 
> in the author field.  I can put yourself there if you feel this is more 
> appropriate.

The correct thing to do is to ensure that it has Eric's and my sign-offs.
If you compare Eric's to my version, mine has a fair amount of changes.
