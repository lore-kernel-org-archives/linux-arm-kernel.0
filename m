From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Aug 2014 20:54:07 +0200
Subject: VFP available on a single CPU in a dual-CPU complex
In-Reply-To: <20140815091445.GC27466@arm.com>
References: <CAGVrzcaX4n2rJko_Kny81jkzQbV6z5TmcA2coGrj6BU-ahiOTA@mail.gmail.com>
 <201408151103.01349.arnd@arndb.de> <20140815091445.GC27466@arm.com>
Message-ID: <8014330.Y4lYRxBeEx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 August 2014 10:14:45 Will Deacon wrote:
> On Fri, Aug 15, 2014 at 10:03:01AM +0100, Arnd Bergmann wrote:
> > On Friday 15 August 2014, Florian Fainelli wrote:
> > > Hello,
> > > 
> > > On Broadcom's BCM63138 SoC, the second Cortex A9 CPU does not have
> > > VFP, which is a problem as one might imagine because we currently
> > > assume it is available for all CPUs within the complex.
> > 
> > Wow, that is pretty crazy.
> > 
> > > I started to patch vfp_support_entry to test for CPU1 and branch to a
> > > different location, but that raises a bunch of question, in particular
> > > what to do if NEON/VFP came from the kernel, how can we migrate that
> > > execution to CPU0?
> > >
> > > If the answer is don't use VFP, I guess that's fine, and I can have a
> > > runtime check in vfp_init() that checks for BCM63138 and set
> > > vfp_vector to vfp_null_entry even though we are running on a multi-v7
> > > kernel with VFP enabled.
> > 
> > I think adding hooks to the scheduler for this case is problematic, so
> > the easiest way would of course be to give the user a choice between
> > VFP or SMP on this hardware. For anything beyond that, you could do
> > a prototype patch (possibly for integration into OpenWRT) so we can
> > see how ugly it gets to support this setup.
> 
> I agree. We have something similar on the Realview-PBX (dual A9, only one
> CPU with NEON) and the answer is not to enable NEON if you want SMP.

Does that work with a multiplatform kernel?

I have patches to enable realview for ARCH_MULTIPLATFORM, and I wonder
if that gets in the way. Do we have code to detect this setup at runtime
and disable NEON/VFP if only a subset of the enabled CPUs have it?

	Arnd
