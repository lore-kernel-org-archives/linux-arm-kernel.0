From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 19:31:50 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <20160203181250.GE26487@MBP.local>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203125735.GA26487@MBP.local>
 <20160203164632.GC1234@leverpostej>
 <20160203173448.GD26487@MBP.local>
 <20160203175351.GG1234@leverpostej>
 <20160203181250.GE26487@MBP.local>
Message-ID: <20160203193149.GJ1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:12:52PM +0000, Catalin Marinas wrote:
> On Wed, Feb 03, 2016 at 05:53:51PM +0000, Mark Rutland wrote:
> > On Wed, Feb 03, 2016 at 05:34:49PM +0000, Catalin Marinas wrote:
> > > In general, if you perform cache maintenance on a non-shareable mapping,
> > > I don't think it would be broadcast. But in this case, the MMU is off,
> > > data accesses default to Device_nGnRnE and considered outer shareable,
> > > so it may actually work. Is this stated anywhere in the ARM ARM?
> > 
> > In ARM DDI 0487A.h, D4.2.8 "The effects of disabling a stage of address
> > translation" we state:
> > 
> > 	Cache maintenance instructions act on the target cache
> > 	regardless of whether any stages of address translation are
> > 	disabled, and regardless of the values of the memory attributes.
> > 	However, if a stage of address translation is disabled, they use
> > 	the flat address mapping for that translation stage.
> 
> But does "target cache" include other CPUs in the system?

It appears so. There's a more complete description (with a table) on
page D3-1718, "Effects of instructions that operate by VA to the Point
of Coherency", where it's explicitly stated:

	For Device memory and Normal memory that is Inner Non-cacheable,
	Outer Non-cacheable, these instructions must affect the caches
	of all PEs in the Outer Shareable shareability domain of the PE
	on which the instruction is operating.

In other cases, per the table, the maintenance may be limited to a
smaller set of caches.

Thanks,
Mark.
