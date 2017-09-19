From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Sep 2017 15:19:54 +0100
Subject: [PATCH 1/2] ARM: smccc-call: Use r12 to route secure monitor
 calls on TI platforms
In-Reply-To: <20170918205005.30235-1-afd@ti.com>
References: <20170918205005.30235-1-afd@ti.com>
Message-ID: <20170919141953.GH30715@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 03:50:04PM -0500, Andrew F. Davis wrote:
> Our ROM Secure Monitor(SM) uses the value in r12 to determine which
> service is being requested by an SMC call. This inline with the ARM
> recommended SMC Calling Convention(SMCCC), which partitions the values
> in R0 for this task, OP-TEE's SM follows the ARM recommended convention.

I can't parse this last sentence. What exactly is inline with the SMCCC?

AFAICT, the SMCCC says r12 is "The Intra-Procedure-call scratch
register", which is not a paramter, service ID, etc.

> We need a way to signal that a call is for the OP-TEE SM and not for
> the ROM SM in a way that is safe for the ROM SM, in case it is still
> present. We do this by putting a value of 0x200 in r12 when the call
> is for OP-TEE or any other ARM by modifying the SMCCC caller function.

So IIUC, you have a secure monitor which is not SMCCC compliant, but you
want to use it at the same time as OP-TEE, which is SMCCC compliant.

It would be much better to have a new version of that monitor that was
SMCCC compliant, and have to update the code for that, than to have to
move OP-TEE away from standards compliance.

> There are four combinations of events:
> 
> If the ROM SM is present and we make a legacy style SMC call, as we
> do in early boot, the call will not have r12 set to 0x200 as these
> calls go through existing mach-omap2/ SMC handlers, so all is well.
> 
> If the ROM SM is present and we make an SMCCC style call, r12 will be
> set to 0x200 and ROM SM will see this as an invalid service call and
> safely return to the normal world.

So you're going to describe OP-TEE as present even when it's not!?

That's simply wrong.

> If OP-TEE is present and we make a legacy style SMC call, r12 will
> not be set to 0x200, and OP-TEE will emulate the functionality that
> the call is requesting.

AFAICT this means that OP-TEE completely replaces your existing monitor.

Please fix this properly. Implement SMCCC-compliant versions of those
calls you wish to retain, and come up with a new binding for those.
Describe that in the DT for systems which have OP-TEE providing these
services.

Systems with the old monitor should have that descrbied in their DT, and
not OP-TEE.

That completely removes the need to come up with a new OP-TEE binding
extension, and aligns your FW for forward compatibility with future
services.

Thanks,
Mark.
