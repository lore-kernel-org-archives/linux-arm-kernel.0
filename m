From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 21 Sep 2017 15:47:19 +0100
Subject: [PATCH 1/2] ARM: smccc-call: Use r12 to route secure monitor
 calls on TI platforms
In-Reply-To: <7390d268-5c72-b263-f153-fbf0d728e05e@ti.com>
References: <20170918205005.30235-1-afd@ti.com>
 <20170919141953.GH30715@leverpostej>
 <7390d268-5c72-b263-f153-fbf0d728e05e@ti.com>
Message-ID: <20170921144719.GA31434@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 10:07:39AM -0500, Andrew F. Davis wrote:
> On 09/19/2017 09:19 AM, Mark Rutland wrote:
> > On Mon, Sep 18, 2017 at 03:50:04PM -0500, Andrew F. Davis wrote:
> >> We need a way to signal that a call is for the OP-TEE SM and not for
> >> the ROM SM in a way that is safe for the ROM SM, in case it is still
> >> present. We do this by putting a value of 0x200 in r12 when the call
> >> is for OP-TEE or any other ARM by modifying the SMCCC caller function.
> > 
> > So IIUC, you have a secure monitor which is not SMCCC compliant, but you
> > want to use it at the same time as OP-TEE, which is SMCCC compliant.
> 
> Not at the same time, our old secure monitor is in ROM, it will be
> present anytime OP-TEE is not installed. OP-TEE is not mandatory, and so
> any call to the secure side must be safe for both secure monitors.
> 
> > It would be much better to have a new version of that monitor that was
> > SMCCC compliant, and have to update the code for that, than to have to
> > move OP-TEE away from standards compliance.
> 
> The current monitor is part of ROM and dates back to OMAP3 days, so
> looks to pre-date ARM standardizing the SMCCC by several years, so I
> hope our lack of compliance here can be forgiven here..

For the existing ROM, as that stands, certainly. I appreciate it's older
than SMCCC.

> Luckily, OP-TEE does not have to move away from compliance to support
> our platforms, it only needs to check for this sentinel value in r12,
> which it already has support upstream for:
> 
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-ti/sm_platform_handler_a15.c#L34

That *is* a move away from compliance, as an SMCCC-compliant TEE should
not look at r12, and an SMCCC-compliant client can (and will) leave
arbitrary values in r12.

[...]

> >> If OP-TEE is present and we make a legacy style SMC call, r12 will
> >> not be set to 0x200, and OP-TEE will emulate the functionality that
> >> the call is requesting.
> > 
> > AFAICT this means that OP-TEE completely replaces your existing monitor.
> 
> Correct.
> 
> > Please fix this properly. Implement SMCCC-compliant versions of those
> > calls you wish to retain, and come up with a new binding for those.
> > Describe that in the DT for systems which have OP-TEE providing these
> > services.
> 
> This might not be possible, these old SMCs are made very early and are
> used all over our existing platform code:
> 
> git grep "smc" -- arch/arm/mach-omap2

Given that one can build a multi-platform kernel, parts of the DT have
already been parsed (in order to determine that the machine is an OMAP2)
before any of this is executed.

These are not too early to preclude runtime switching based on the DT.

I can appreciate that it's a pain to have to alter these, but it's
certainly possible, and it would eliminate the problem rather than
spreading it further.

> > Systems with the old monitor should have that descrbied in their DT, and
> > not OP-TEE.
> 
> All systems have the old monitor by default, OP-TEE is the new and
> optional case, I think its node should be the entity modified when
> adding something OP-TEE specific like this.

... and so the DT can also be altered to describe a new SMCCC-compliant
set of OMAP2 SMCs in this case.

Thanks,
Mark.
