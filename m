From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Jun 2013 11:01:08 +0100
Subject: [PATCH 00/21] ARM: ux500: Enable Clock look-up from Device Tree
In-Reply-To: <CAPDyKFrJumd79hHWJkGWvRKzhoaprPHu=U6HOHXzVL8WyNS6jw@mail.gmail.com>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
 <CAPDyKFrJumd79hHWJkGWvRKzhoaprPHu=U6HOHXzVL8WyNS6jw@mail.gmail.com>
Message-ID: <20130611100108.GC9216@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Nice and simple implementation using standard Clk APIs.
> Hi Lee,
> 
> I may be a bit tired, but I am having a bit hard to follow the steps
> taken in this patch set. :-)
> 
> I should of course tell you why:
> 1. You start out by adding DT definitions in the DT files, should that
> not be done as the final step, after the DT support has been added in
> ux500 clk driver?

No, let me tell you why. ;)

a) The DT definitions will be going in via a separate tree, so it
doesn't really matter where they are placed in _this_ patchset. and b)
they will remain completely dormant until they are backed up with
driver bindings, so there is no harm in putting them in first.

> 2. Moreover, I think it would be enough to group the definitions
> patches into one patch or at least significant fewer. Same feeling
> about the patches were you remove the AUXDATA, this would simplify the
> review for me.

It's generally accepted that lots of lines of code split over a
greater number of patches (so long as they are in consistent groups of
functionality) are easier to review and thus have a greater chance of
acceptance. It also makes things like reverting easier and bisecting
more precise (rather than finding a big patch using bisect, then
having to complete a manual mini-bisect to find the offending change.

Arnd provides the maths for calculating the ease of upstreaming a
patch, which he calls 'weight' (NB: this is from memory, it might be a
little off):

(patch_weight * patch_weight) * patch_count = delta_weight

So if we had a 100 lines split over 2 patches, it would be:

(50 * 50) * 2 = 5000

Whereas if we split those lines over 4 patches we would see:

(25 * 25) * 4 = 1000

Thus, by this convention it would (generally) considered to be twice
as difficult to upstream - at least that's the theory. There is a more
extravagant formula for calculating how difficult it would be to
upstream an entire tree of delta if a) all patches were contained on a
single branch compared to b) if patches were split into topic branches.

Something like:

((patch_weight * patch_weight) * patch_count)  *
 (patch_weight * patch_weight) * patch_count)) *
  branch_count = delta_weight

So following on from the example above and placing 100 lines over 2
patches on 1 branch you would get:

(((25 * 25) * 4) * (25 * 25) * 4) * 1 = 6250000

Whereas if you spread the patches over two branches you'd have:

(((25 * 25) * 2) * (25 * 25) * 2) * 2 = 3125000

Obviously the branch number comparison works better with the larger
numbers you'd expect to find in a typical downstream BSP, but you get
the idea.

</tangent> ... whoops, sorry! :)

> 3. The rest will be commented per patch.
> 
> Kind regards
> Ulf Hansson
> 
> >
> >  arch/arm/boot/dts/dbx5x0.dtsi    |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  arch/arm/boot/dts/snowball.dts   |    3 ++-
> >  arch/arm/mach-ux500/cpu-db8500.c |   36 +--------------------------
> >  drivers/clk/ux500/u8500_clk.c    |  154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  4 files changed, 249 insertions(+), 38 deletions(-)
> >
> >

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
