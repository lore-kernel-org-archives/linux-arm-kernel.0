From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 19:38:34 +0100
Subject: [PATCH] irqchip: gic: use dmb ishst instead of dsb when raising a
 softirq
In-Reply-To: <20140224182931.GB1198@mudshark.cambridge.arm.com>
References: <1392918127-1430-1-git-send-email-will.deacon@arm.com>
 <20140224182931.GB1198@mudshark.cambridge.arm.com>
Message-ID: <201402251938.34626.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014, Will Deacon wrote:
> On Thu, Feb 20, 2014 at 05:42:07PM +0000, Will Deacon wrote:
> > When sending an SGI to another CPU, we require a barrier to ensure that
> > any pending stores to normal memory are made visible to the recipient
> > before the interrupt arrives.
> > 
> > Rather than use a vanilla dsb() (which will soon cause an assembly error
> > on arm64) before the writel_relaxed, we can instead use dsb(ishst),
> > since we just need to ensure that any pending normal writes are visible
> > within the inner-shareable domain before we poke the GIC.
> > 
> > With this observation, we can then further weaken the barrier to a
> > dmb(ishst), since other CPUs in the inner-shareable domain must observe
> > the write to the distributor before the SGI is generated.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > 
> > Hi Olof,
> > 
> > Please can you take this via arm-soc for 3.15? That will let me activate
> > the new barrier options for arm64 at the end of the next merge window
> > (in the meantime, you can pass them but they are ignored).
> 
> I still can't see this in -next, any chance you could queue it please?
> 

Applied to next/fixes-non-critical

	Arnd
