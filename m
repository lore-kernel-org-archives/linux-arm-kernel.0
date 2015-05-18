From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:36:55 +0100
Subject: [PATCHv2 07/12] arm64: psci: kill psci_power_state
In-Reply-To: <1431945503-6939-8-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518173655.GN21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:18AM +0100, Mark Rutland wrote:
> A PSCI 1.0 implementation may choose to use the new extended StateID
> format, the presence of which may be queried via the PSCI_FEATURES call.
> The layout of this new StateID format is incompatible with the existing
> format, and so to handle both we must abstract attempts to parse the
> fields.
> 
> In preparation for PSCI 1.0 support, this patch introduces
> psci_power_state_loses_context and psci_power_state_is_valid functions
> to query information from a PSCI power state, which is no longer
> decomposed (and hence the pack/unpack functions are removed). As it is
> no longer decomposed, it is now passed round as an opaque u32 token.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/psci.c | 89 ++++++++++++++++++++----------------------------
>  1 file changed, 37 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 3ef677e..4ef9472 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -37,11 +37,19 @@
>  #define PSCI_POWER_STATE_TYPE_STANDBY		0
>  #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
>  
> -struct psci_power_state {
> -	u16	id;
> -	u8	type;
> -	u8	affinity_level;
> -};
> +static bool psci_power_state_loses_context(u32 state)
> +{
> +	return !!(state & PSCI_0_2_POWER_STATE_TYPE_MASK);
> +}

Nitpick: I don't think you need the !! here since the default conversion
is to bool anyway.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
