From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 10:19:46 +0000
Subject: [PATCH] arm64: fix psci power state pack
In-Reply-To: <1392196958-2507-1-git-send-email-pgaikwad@nvidia.com>
References: <1392196958-2507-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <20140212101946.GD13441@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 09:22:38AM +0000, Prashant Gaikwad wrote:
> Values has to be shifted right to create pack.

NAK. This doesn't make any sense to me.

> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---
>  arch/arm64/kernel/psci.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 4f97db3..6e8f1df 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -87,11 +87,11 @@ static int psci_to_linux_errno(int errno)
>  static u32 psci_power_state_pack(struct psci_power_state state)
>  {
>  	return	((state.id & PSCI_POWER_STATE_ID_MASK)
> -			<< PSCI_POWER_STATE_ID_SHIFT)	|
> +			>> PSCI_POWER_STATE_ID_SHIFT)	|
>  		((state.type & PSCI_POWER_STATE_TYPE_MASK)
> -			<< PSCI_POWER_STATE_TYPE_SHIFT)	|
> +			>> PSCI_POWER_STATE_TYPE_SHIFT)	|

So for the type field, this becomes:

  (state.type & 0x1) >> 16

Are you sure?

Will
