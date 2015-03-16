From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 13:04:19 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <20150316093553.GF8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
Message-ID: <20150316130419.GI8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 09:35:53AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 12:42:39AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 16, 2015 at 12:04:38AM +0000, Russell King - ARM Linux wrote:
> > > On Sun, Mar 15, 2015 at 09:33:30PM +0000, Russell King - ARM Linux wrote:
> > > > I'm going to try a few other kernels to try and track down what's going
> > > > on - whether something from arm-soc or my tree is responsible for this
> > > > really weird behaviour.
> > > 
> > > Okay, this is weird - it seems that it's caused by the FIQ oops
> > > dumping code/FIQ changes which I've carried for many months
> > > unchanged in my tree.
> > 
> > More weirdness.  Progressing forwards through my development code
> > showed that when I merged the patch I mentioned in the previous mail,
> > things started to fail.
> > 
> > As I also mentioned, I'd drop that branch (two patches, one adding
> > the IPI backtrace stuff and the second one updating the GIC to allow
> > it to raise FIQs on suitably equipped platforms.)  I would have
> > expected that to have worked, but it just failed after four boot
> > iterations.  So either it's not the FIQ, or it is the FIQ code _and_
> > also something else.  Or it has something to do with the placement
> > of functions in the kernel.
> > 
> > I'll try more stuff tomorrow, working from where I presently am
> > (which is basically last night's code minus the FIQ changes) by
> > removing other changes to see what brings us back to a working
> > system.
> > 
> > As I've already said - this is really weird because all of these
> > changes were also tested against -rc1... those which weren't are:
> > 
> > mm: fold arch_randomize_brk into ARCH_HAS_ELF_RANDOMIZE
> > mm: split ET_DYN ASLR from mmap ASLR
> > mm: move randomize_et_dyn into ELF_ET_DYN_BASE
> > mm: expose arch_mmap_rnd when available
> > arm: factor out mmap ASLR into mmap_rnd
> > 
> > and a number of clkdev rework patches (to make it use clk_hw
> > internally.)  Neither of these should be affecting it, but that's
> > something I will be testing tomorrow.
> 
> Okay, reverting the ASLR changes and the clkdev changes annoyingly still
> results in random failure.

After ruling out ASLR and clkdev, I started progressively reverting other
stuff in the build tree.  Eventually, I got down to reverting the L2C
change I've been carrying since the L2C cleanups.

With that lot reverted, which is slightly more than the previously known
good test, it booted five times without issue.

So, I thought I'd add that L2C change to the list of bad commits, and try
omitting _just_ the L2C and FIQ changes... and it still fails - on the
first test boot iteration.

I think I'm going to declare that this is all down to some obscure
hardware problem with Versatile Express, which is tickled by the layout
of the kernel against the cache, and take it out of the nightly system
(it's pointless having unstable hardware being tested; random failures
are completely meaningless.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
