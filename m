From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 16 Dec 2014 10:17:15 +0000
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <1418719615.8392.17.camel@mtksdaap41>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <20141211180245.GE28150@leverpostej>
 <1418371705.423.31.camel@mtksdaap41>
 <20141215125932.GF462@leverpostej>
 <1418719615.8392.17.camel@mtksdaap41>
Message-ID: <20141216101714.GA19412@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 08:46:55AM +0000, Eddie Huang wrote:
> Hi,
> 
> On Mon, 2014-12-15 at 12:59 +0000, Mark Rutland wrote:
> > On Fri, Dec 12, 2014 at 08:08:25AM +0000, Eddie Huang wrote:
> > > Hi Mark,
> > > 
> > > On Thu, 2014-12-11 at 18:02 +0000, Mark Rutland wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Dec 10, 2014 at 10:50:01AM +0000, Eddie Huang wrote:
> > > > > Add device tree support for MT8173 SoC and evalutaion board based on it.
> > > > > 
> > > 
> > > > > +
> > > > > +	psci {
> > > > > +		compatible = "arm,psci-0.2";
> > > > > +		method = "smc";
> > > > > +	};
> > > > 
> > > > What are you using as your PSCI 0.2 implementation?
> > > > 
> > > > Is it fully compliant? (e.g. are the reset and power off functions
> > > > implemented, may CPU0 be hotplugged)?
> > > > 
> > > > Given only portions of the GIC seem to be described below, what
> > > > exception level is your kernel entered at? Per the spec it should be
> > > > EL2, but given the brokenness below with the GIC I'm suspicious.
> > > > 
> > > 
> > > Currently we only implement CPU boot, no power off, no CPU0 hotplug
> > > either. And enter kernel at EL2. Actually, we run ATF in EL3, then
> > > switch to EL2 to run lk and kernel.
> > 
> > Ok. In the absence of CPU_OFF, this is not yet a conforming PSCI 0.2
> > implementation, so I'm wary of marking this as PSCI 0.2 until that is
> > the case. Any attempt to power of CPUs will hit a BUG() in cpu_die(),
> > and we don't want that.
> 
> We are still developing PSCI related functions, CPU_ON, CPU_OFF,
> CPU_SUSPEND are ready, others are going. PSCI 0.2 is our target although
> lacks some implements

Ok. It sounds like for now you can describe this with PSCI 0.1 with
those functions implemented.

> > Is CPU0 hotplug planned?
> 
> No

In that case, for PSCI 0.1 you won't be able to have an enable-method of
"psci" for CPU0 (and hence won't get CPU_SUSPEND for the moment).

> > If not, does your PSCI implementation report CPU0 as
> > non-hotpluggable via MIGRATE_INFO_TYPE reporting a UP not migratable
> > trusted OS (and MIGRATE_INFO_UP_CPU reporting CPU0 as the resident CPU)?
> > 
> Will check whether add this

For PSCI 0.2 you will need to implement these if Cthere is no CPU0
hotplug. Luckily they will only need to return constant values so this
should be easy.

We still need to implement the relevant logic in the Linux PSCI client
code for this, but that should be small and self-contained.

> > Are SYSTEM_OFF and SYSTEM_RESET available?
> 
> No yet

Ok.

> > Thanks,
> > Mark.
> 
> Since we miss some PSCI-0.2 implements, I don't know whether I should
> remove PSCI stuff in this patch.

For the moment you will have to remove the PSCI 0.2 parts, as you are
not compliant and it's trivial to break the kernel on such a
configuration. You might get away with claiming PSCI 0.1, without an
enable method on CPU0, but this will come with reduced functionality.

Thanks,
Mark.
