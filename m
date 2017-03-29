From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Mar 2017 12:23:26 +0100
Subject: [PATCH v2 2/8] arm64: mm: mark fault_info __ro_after_init
In-Reply-To: <20170328213431.10904-3-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
 <20170328213431.10904-3-opendmb@gmail.com>
Message-ID: <20170329112326.GE23442@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 02:34:25PM -0700, Doug Berger wrote:
> The fault_info table must be made writeable to allow installation
> of custom memory abort handlers, but it can be made read-only
> after initialization to provide some protection.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Thanks for putting this together. I agree that making this RO is good.

However, I also think that we should not allow arbitrary hooking of
fault codes, and thus this can be const.

Thanks,
Mark.

> ---
>  arch/arm64/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index cdf1260f1005..43319ed58a47 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -493,7 +493,7 @@ static struct fault_info {
>  	int	sig;
>  	int	code;
>  	const char *name;
> -} fault_info[] = {
> +} fault_info[] __ro_after_init = {
>  	{ do_bad,		SIGBUS,  0,		"ttbr address size fault"	},
>  	{ do_bad,		SIGBUS,  0,		"level 1 address size fault"	},
>  	{ do_bad,		SIGBUS,  0,		"level 2 address size fault"	},
> -- 
> 2.12.0
> 
