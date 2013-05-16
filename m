From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 16 May 2013 18:00:20 +0100
Subject: [PATCH] ARM: prima2: return rather than panic on missing DT nodes
In-Reply-To: <1368719437-28287-1-git-send-email-robherring2@gmail.com>
References: <1368719437-28287-1-git-send-email-robherring2@gmail.com>
Message-ID: <519510A4.8090904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

I was just testing multi_v7_defconfig and noticed that the code is still
doing early_initcall and postcore_initcalls. Which IMO is NOK for
multiplatforms.

I was just about to send my patch and just noticed your patch.


On 16/05/13 16:50, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Missing nodes is a normal condition in multi-platform kernels when we boot
> on other platforms. So remove the panic and just return if we don't find
> a DT node.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Barry Song <baohua.song@csr.com>
> ---
>  arch/arm/mach-prima2/pm.c   | 2 +-
>  arch/arm/mach-prima2/rstc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-prima2/pm.c b/arch/arm/mach-prima2/pm.c
> index 9936c18..a8003e2 100644
> --- a/arch/arm/mach-prima2/pm.c
> +++ b/arch/arm/mach-prima2/pm.c
> @@ -102,7 +102,7 @@ static int __init sirfsoc_of_pwrc_init(void)
>  
First thing is the mach code should not even attempt to run this
function in first place.

I think the correct fix for this is to move all the postcore_initcalls
and early_initcalls to callbacks in MACHINE.


Thanks,
srini

>  	np = of_find_matching_node(NULL, pwrc_ids);
>  	if (!np)
> -		panic("unable to find compatible pwrc node in dtb\n");
> +		return -ENODEV;
>  
>  	/*
>  	 * pwrc behind rtciobrg is not located in memory space
> diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
> index 435019c..6d7d9db 100644
> --- a/arch/arm/mach-prima2/rstc.c
> +++ b/arch/arm/mach-prima2/rstc.c
> @@ -29,7 +29,7 @@ static int __init sirfsoc_of_rstc_init(void)
>  
>  	np = of_find_matching_node(NULL, rstc_ids);
>  	if (!np)
> -		panic("unable to find compatible rstc node in dtb\n");
> +		return -ENODEV;
>  
>  	sirfsoc_rstc_base = of_iomap(np, 0);
>  	if (!sirfsoc_rstc_base)
> 
