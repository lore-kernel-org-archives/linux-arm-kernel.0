From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 12 Nov 2013 14:30:12 -0500
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <528275B7.6050209@wwwdotorg.org>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
Message-ID: <20131112193012.GR10335@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Tue, Nov 12, 2013 at 11:38:47AM -0700, Stephen Warren wrote:
> On 11/12/2013 08:29 AM, Rob Herring wrote:
> > On Mon, Nov 11, 2013 at 3:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 11/11/2013 01:29 PM, Jason Cooper wrote:
> >>> Consumers of the Linux kernel's build products are beginning to hardcode
> >>> the filenames of the dtbs generated.  Since the dtb filenames are
> >>> currently the dts filename s/dts/dtb/, this prevents the kernel
> >>> community from renaming dts files as needed.
> >>
> >> My take is that the DTB filenames are part of the ABI, and therefore the
> >> DTS filenames are also part of the ABI. Why would we want to rename them?
> > 
> > I agree with the ABI part, but for long term I think compatible
> > strings are a better choice for the ABI than filenames. A link
> > provides for a way to transition.
> 
> But this change isn't making the compatible value be the ABI, it's still
> keeping the filename as the ABI, but creating a different way of
> choosing the filename.

Right, which provides a path towards a slightly more sane ABI.  If we
choose to implement this, or another variant, we get to shape a
migration path towards an ABI we designed.  As opposed to locked in to
one we didn't even see coming.

> In other words, if the compatible value is the ABI, then the algorithm is:
> 
> * Search for all available DTBs
> * Parse each DTB to find one with a matching compatible value
> 
> Whereas if the filename is the ABI, the algorithm is:
> 
> * Calculate the filename
> * Load that one specific file, without looking at its content
> 
> Some additional thoughts:
> 
> * The filename is only relevant to the bootloader (or whatever
> locates/selects a DTB). The kernel/OS just gets a single DTB passed to
> it and uses it, without any naming metadata[1].

As I see it (and perhaps this suffers from my limited view of the
embedded space, eg fairly marvell-specific), there are two scenarios:

1) The end goal:  bootloaders load a single DTB from a chunk of flash
and pass it off to the kernel/next stage, whatever.  Either there is no
filename, just a flash partition, or the vendor has chosen some dtb
naming scheme suitable for their needs, eg OMAP SoCs pulling the
bootloader from an SD card would need to name the dtb contained on the
same SD card. board.dtb?  I'm assuming here that the SD card files are
board specific (x-loader, uboot, env, dtb)

2) right now: distributions are creating utilities, such a flash-kernel
in Debian, that pick from a slew of dtbs, append it to the zImage, and
create the uImage.  The bootloaders in these installs don't have support
for fdt.

Our problem (as I see it) is that #2 is creating an ABI out of something
we never realized would become an ABI, the filenames created by 'make
dtbs'.

And since the dtb name is derived directly from the dts name, we're
getting locked into a bunch of filenames that are less than ideal
because we didn't know what we didn't know when we started this two+
years ago.

> * Perhaps different bootloaders work different ways. For example, I've
> set up U-Boot on all Tegra devices so that if U-Boot expands the string
> "${soc}-${board}.dtb" using its environment, it'll generate the correct
> DTB filename.

Why does the bootloader have to choose?  Is this a development scenario or
a deployed scenario?

> * Other boot-loaders might like "${compatible_parsed_from_the_dtb}" to
> be the filename; that's Jason's proposal.
> 
> * Other SW (which I mention in [1]) might want to locate DTBs based on
> ARM machine ID rather than compatible value.

fyi:  https://github.com/zonque/pxa-impedance-matcher.git

> * As such, we're really talking about an indexing process when
> installing/packaging/searching DTBs. Shouldn't this file renaming happen
> as part of that process, not the build process?

I agree, but it's not.  Hence the patch.

> * When we create symlinks or any kind of index, I think we want to
> create links for all entries in the compatible property (or other index
> source). 

We can't, you'll get collisions.  In my globalscale,mirabox.dtb example,
the next string is 'marvell,armada370'.  That matches many boards which
_aren't_ compatible with the globalscale,mirabox.dtb.

> Consider if we have two boards:
> 
> Cardhu revision A02
> Cardhu revision A04
> 
> Initially we think they're the same because we didn't read the
> schematics well enough, but then later we split them. That means we'll
> start out with one file:
> 
> nvidia,tegra30-cardhu.dtb

We've seen this as well with a couple of boards.

> then later have instead:
> 
> nvidia,tegra30-cardhu-a02.dtb
> nvidia,tegra30-cardhu-a04.dtb
> 
> Similarly, perhaps one DTB is (initially thought to be?) suitable for
> multiple ARM machine IDs, etc.
> 
> So, bootloaders would have to search for $vendor,$soc-$board-$rev.dtb
> then fall back to $vendor,$soc-$board.dtb (both those values are in the
> compatible properties in those DTBs).

I disagree here.  I don't think this decision/discovery process should
be done by the bootloader.  It should be done by the distribution
installer/firmware upgrade utility.  The risk of breaking boot is too
high.

> But then "nvidia,tegra30" is in the compatible property for many boards.
> I wonder how we resolve that?

At least during installer/upgrade the distro has the opportunity to
query the user, "Hey, this used to have nvidia,tegra30-cardhu.dtb, but
now I need to choose between nvidia,tegra30-cardhu-a02.dtb and
nvidia,tegra30-cardhu-a04.dtb.  Please see
http://wiki.mydistro.org/devicetree/upgrade/nvidia,tegra30-cardhu for
howto determine which variant matches your board."

Ideally, there would be programmatic way for the upgrader to determine
which variant it is on, but failing that, it could fall back to the
above.

thx,

Jason.
