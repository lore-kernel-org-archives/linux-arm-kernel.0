From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 20 Apr 2017 21:02:23 +0200
Subject: [PATCH] ARM: KVM: Fix idmap stub entry when running Thumb-2 code
In-Reply-To: <20170420150221.15796-1-marc.zyngier@arm.com>
References: <20170420150221.15796-1-marc.zyngier@arm.com>
Message-ID: <20170420190223.GF4104@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 04:02:21PM +0100, Marc Zyngier wrote:
> When entering the hyp stub implemented in the idmap, we try to
> be mindful of the fact that we could be running a Thumb-2 kernel
> by adding 1 to the address we compute. Unfortunately, the assembler
> also knows about this trick, and has already generated an address
> that has bit 0 set in the litteral pool.
> 
> Our superfluous correction ends up confusing the CPU entierely,
> as we now branch to the stub in ARM mode instead of Thumb, and on
> a possibly unaligned address for good measure. From that point,
> nothing really good happens.
> 
> The obvious fix in to remove this stupid target PC correction.
> 
> Fixes: 6bebcecb6c5b ("ARM: KVM: Allow the main HYP code to use the init hyp stub implementation")
> Reported-by: Christoffer Dall <cdall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This works, thanks.

Applied to kvmarm/next.
-Christoffer
