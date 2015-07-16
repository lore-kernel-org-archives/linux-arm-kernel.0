From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 19:08:03 +0100
Subject: [PATCH 01/13] arm/arm64: Add new is_kernel_in_hyp_mode predicate
In-Reply-To: <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150716180802.GS26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 05:19:04PM +0100, Marc Zyngier wrote:
> With ARMv8.1 VHE extension, it will be possible to run the kernel
> at EL2 (aka HYP mode). In order for the kernel to easily find out
> where it is running, add a new predicate that returns whether or
> not the kernel is in HYP mode.
> 
> For completeness, the 32bit code also get such a predicate (always
> returning false) so that code common to both architecture (timers,
> KVM) can use it transparently.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/virt.h   |  5 +++++
>  arch/arm64/include/asm/virt.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)

[...]

> +static inline bool is_kernel_in_hyp_mode(void)
> +{
> +	u64 el;
> +
> +	asm("mrs %0, CurrentEL" : "=r" (el));
> +	return el == CurrentEL_EL2;

Missing mask?

Will
