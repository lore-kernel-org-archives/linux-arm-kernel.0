From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 13:04:30 +0100
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs
	based on platform device name.
In-Reply-To: <5725201.5LdnvaEu1n@flatron>
References: <1731819.jJi37IsjvJ@flatron> <1660939.8M3FnZsmga@flatron>
	<20110906110311.GM6619@n2100.arm.linux.org.uk>
	<5725201.5LdnvaEu1n@flatron>
Message-ID: <20110906120430.GO6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 01:35:58PM +0200, Tomasz Figa wrote:
> Well, I believe that the context I quoted explains everything, but let me
> explain that again:
> 
> The patch is about a driver being able to check to what SoC a device belongs,
> but there are at least two ways to achieve that.
> 
> I can see many drivers using the way I used, i.e. distinct platform device names
> for each SoC that has to be differentiated plus a generic one. However, I was
> suggested that using cpu_is_*/soc_is_* might be a better approach, while at the
> same time I received an opinion that the original method is the preferred one.

Ok.  There's pros and cons here:

Pros to soc_is_*:
1. Doesn't require additional storage in every driver but does require code.
2. Obvious what's going on for a specific SoC when reading the code.

Cons:
1. Needs to be updated each time a new SoC is added.
2. Doesn't scale well - number of soc_is_* will grow to unmanageable levels
   over time.

Pros to platform driver name:
1. Can re-use existing names if feature compatible without driver mods.
2. Scales well with an increasing number of SoCs.

Cons:
1. People will hate having SoC names which don't refer to their exact SoC.
2. Probably requires storage of a set of flags in driver private data
   to identify SoC specific features.
3. Requires additional string space to identify each driver name.

However, thinking about this more wrt DT, there's another aspect to this.
Rather than encoding into the driver "this SoC has features and quirks
X,Y,Z" maybe that information should be in the device tree itself.  For
example, SoC 1 has X and Z, SoC 2 has Y.  Then a new SoC 3 comes along
with X and Y but not Z.  If X, Y, Z are encoded into DT then there's no
need to touch the kernel to support SoC 3, not even to change driver
names or soc_is_xxx macros etc.

So maybe the answer is: platform driver name determines a set of feature
flags for the driver in lieu of DT support, and when DT support comes
along the flags are controlled by DT properties instead.
