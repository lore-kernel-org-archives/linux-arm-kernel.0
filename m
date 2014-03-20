From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 11:48:15 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <8120199.tJr1GuP6ec@wuerfel>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140319204946.GK7528@n2100.arm.linux.org.uk> <8120199.tJr1GuP6ec@wuerfel>
Message-ID: <201403201148.16239.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Arnd Bergmann wrote:
> On Wednesday 19 March 2014 20:49:47 Russell King - ARM Linux wrote:
> > On Wed, Mar 19, 2014 at 08:29:41PM +0100, Arnd Bergmann wrote:
> > > This adds a new Kconfig option for the Integrator platform to
> > > choose between ARMv4/ARMv5 based CPUs and those based on ARMv6/ARMv7,
> > > which is required because we cannot have both classes enabled in the
> > > same kernel at compile time.
> > 
> > Wouldn't it just be easier to make the older CPUs depend on
> > !CPU_V6 && !CPU_V7 rather than trying to hack this for each platform?
> 
> It's only two platforms: integrator and realview. Actually I took two
> different approaches on these, and wanted to make up my mind first
> which one is better. Any suggestion?
> 
> I have a mild preference to always using 'select' on the CPU_* symbol
> from the platform, mostly for consistency. The downside is that it
> gets a little messy for Integrator, but that's just one platform in
> the end.
> 
> At some point, I think I got into circular dependencies when one CPU
> depended on another one being disabled, but I don't remember exactly
> what case that was.
> 

Nevermind, I'll drop this patch for now, I just had an idea to do it
better: Since Linus and I are trying to get Integrator and Realview
moved over into ARCH_MULTIPLATFORM anyway, I'll defer the CPU selection
question until that's done.

Within ARCH_MULTIPLATFORM, we already want to deal with booting machines
that are described entirely in DT and have no platform specific code,
but we also want to be able to select the CPU types built into the
kernel for them.

For the v6/v6k/v7 selection, we can do this through the top-level
multiplatform options we already have, as we don't expose the
differences between the individual core implementations for the most
part. We can potentially leave PJ4 and PJ4B as user-selectable.

For the v4/v4t/v5 selection, I would allow any CPU to be manually
enabled with a dependency on the ARCH_MULTI_V* option. Platforms
that know what they have should obviously keep selecting the one
they want. I would leave strongarm and xscale out of the selection,
because I don't expect any platform based on those cores to ever
become enabled for ARCH_MULTIPLATFORM, but all the others should
be selectable.

For the moment, I'll keep using my patches locally in order to
keep randconfig building, and I'll follow up with a new patch
after integrator and realview are part of multiplatform. That
may take a while, but I'm sure we'll get there eventually.

	Arnd
