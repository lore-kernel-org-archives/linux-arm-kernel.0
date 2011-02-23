From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 23 Feb 2011 15:38:20 +0100
Subject: [PATCH 4/8] OMAP2+: hwmod: find MPU initiator hwmod during in
	_register()
In-Reply-To: <20110223071146.5874.15334.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071146.5874.15334.stgit@twilight.localdomain>
Message-ID: <4D651BDC.8040700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> Move the code that looks for the MPU initiator hwmod to run during
> the individual hwmod _register() function.  (Previously, it ran after
> all hwmods were registered in the omap_hwmod_late_init() function.)
>
> This is done so code can late-initialize a few individual hwmods --
> for example, for the system timer -- before the entire set of hwmods is
> initialized later in boot via omap_hwmod_late_init().
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno?t Cousson<b-cousson@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++--------
>   1 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 9e89a58..41f548e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1455,7 +1455,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
>    */
>   static int __init _register(struct omap_hwmod *oh)
>   {
> -	int ret, ms_id;
> +	int ms_id;
>
>   	if (!oh || !oh->name || !oh->class || !oh->class->name ||
>   	    (oh->_state != _HWMOD_STATE_UNKNOWN))
> @@ -1478,9 +1478,14 @@ static int __init _register(struct omap_hwmod *oh)
>
>   	oh->_state = _HWMOD_STATE_REGISTERED;
>
> -	ret = 0;
> +	/*
> +	 * XXX Rather than doing a strcmp(), this should test a flag
> +	 * set in the hwmod data, inserted by the autogenerator code.

What do you mean exactly? Something like a "is_mpu" field set to true 
for the mpu?
Since we are enforcing a consistent naming for every hwmods, that looks 
like a duplication of the name.
We will always named this hwmod "mpu", so the strcmp() should be enough.

But, maybe I'm missing your point.

Benoit

> +	 */
> +	if (!strcmp(oh->name, MPU_INITIATOR_NAME))
> +		mpu_oh = oh;
>
> -	return ret;
> +	return 0;
>   }
>
