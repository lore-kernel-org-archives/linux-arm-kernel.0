From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 18 Feb 2011 18:34:34 +0100
Subject: [PATCH 1/3] OMAP2+: hwmod: Avoid setup if clock lookup failed
In-Reply-To: <1297858285-7056-2-git-send-email-rnayak@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com>
	<1297858285-7056-2-git-send-email-rnayak@ti.com>
Message-ID: <4D5EADAA.7010007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> Add a hwmod state check in the _setup function
> to avoid setting up hwmods' for which clock
> lookup has failed.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e282e35..cd9dcde 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1362,6 +1362,12 @@ static int _setup(struct omap_hwmod *oh, void *data)
>   	int i, r;
>   	u8 postsetup_state;
>
> +	if (oh->_state != _HWMOD_STATE_CLKS_INITED) {
> +		WARN(1, "omap_hwmod: %s: _setup failed as one or more"
> +		     "clock lookups' have failed\n", oh->name);

Maybe a pr_warning will be enough for that?

> +		return -EINVAL;

As discussed previously I'd prefer to return 0 here since we do not want 
to break the iteration.

> +	}
> +
>   	/* Set iclk autoidle mode */
>   	if (oh->slaves_cnt>  0) {
>   		for (i = 0; i<  oh->slaves_cnt; i++) {

Otherwise it is fine for me.

Thanks,
Benoit
