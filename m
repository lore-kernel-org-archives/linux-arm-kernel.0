From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Jul 2011 11:03:16 +0300
Subject: [PATCH] OMAP: powerdomains: Make all powerdomain target states
	as ON at init
In-Reply-To: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
References: <1310527588-13022-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110715080315.GC2611@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 13, 2011 at 08:56:27AM +0530, Santosh Shilimkar wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Program all powerdomain target state as ON; This is to
> prevent domains from hitting low power states (if bootloader
> has target states set to something other than ON) and potentially
> even losing context while PM is not fully initilized.
> The PM late init code can then program the desired target
> state for all the power domains.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index e0490bc..e61866c 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -109,6 +109,16 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  
>  	list_add(&pwrdm->node, &pwrdm_list);
>  
> +	/*
> +	* Program all powerdomain target state as ON; This is to
> +	* prevent domains from hitting low power states (if bootloader
> +	* has target states set to something other than ON) and potentially
> +	* even losing context while PM is not fully initilized.
> +	* The PM late init code can then program the desired target
> +	* state for all the power domains.
> +	*/
> +	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_ON);

Just out of curiosity, I was wondering if it really makes sense to power
up all power domains during boot just to avoid loosing context. Doesn't
hwmod/omap_device soft-reset all IPs during initialization ? If that's
really the case, shouldn't we then choose which powerdomains are
strictly necessary for boot and only power those up ?

Sorry if this is a non-sensical question, but I was curious about it
;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110715/e9cd6215/attachment.sig>
