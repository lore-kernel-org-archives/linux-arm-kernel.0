From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2012 15:01:16 +0100
Subject: [PATCH 15/15] ARM: perf: handle muxed CPU IRQ lines
In-Reply-To: <4FE1D3D2.3050209@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-16-git-send-email-lee.jones@linaro.org>
 <20120620132823.GG32666@mudshark.cambridge.arm.com>
 <4FE1D3D2.3050209@linaro.org>
Message-ID: <20120620140115.GJ32666@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 02:44:50PM +0100, Lee Jones wrote:
> >
> > Shouldn't this be in the platform IRQ handler, rather than the core v7 perf
> > code?
> 
> Well that's where it currently resides, but in the process of DT:ing the 
> platform, we have no real way to set the call-back. Normally, if it's 
> absolutely necessary, we do this with AUXDATA. However in the PMU case 
> we fall-down as a device address is required for DT look-up, which the 
> PMU does not have.

Right, so I suspect this is going to be a huge problem for the OMAP guys,
where they have to do a fair amount of jiggery-pokery to kick their PMU into
action. We are also looking to put suspend/resume hooks into the
arm_pmu_platdata which will undoubtedly be highly platform-specific.

> I spoke with Arnd about sensible solutions and he suggested placing the 
> logic inside the generic instead, thus supporting muxed IRQ lines 
> without the requirement of providing a platform specific handler in 
> every instance this occurs (although, I think the ux500 are the only 
> platform to do this currently).

Whilst this code isn't too problematic (but yes, you are the only platform
that needs it) I think if we solve the bigger problem then you can use the
same solution to do your IRQ ping-ponging.

> I'd be happy to take any other suggestions, but this seemed fairly neat 
> and unobtrusive (not withstanding the predicate cock-up).

Can we not fix the AUXDATA stuff to assume address 0 if it's not present for
the matching node? This will work for perf as I don't expect to have
multiple nodes with the same compatible string for PMUs that are not
memory-mapped (for big.LITTLE, the strings will be different).

Will
