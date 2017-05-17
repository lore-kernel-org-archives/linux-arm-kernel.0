From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 May 2017 15:33:36 +0530
Subject: [PATCH 2/2] ARM: davinci: PM: Do not free useful resources in
 normal path in 'davinci_pm_init'
In-Reply-To: <20170513114020.23668-1-christophe.jaillet@wanadoo.fr>
References: <20170513114020.23668-1-christophe.jaillet@wanadoo.fr>
Message-ID: <68b895dc-1bcf-fb59-0e19-e69b2e72f8c1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 13 May 2017 05:10 PM, Christophe JAILLET wrote:
> This looks spurious to iounmap resources in the normal path of this init
> function.
> The 3 ioremap'ed fields of 'pm_config' can be accessed later on in other
> functions, so it is likely that we should return 'success' before unrolling
> everything.
> 
> Fixes: aa9aa1ec2df6 ("ARM: davinci: PM: rework init, remove platform device")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is just a *guess*. The end of the function looks more like a
> error handling code rather than a normal path.

The patch is correct.

> ---
>  arch/arm/mach-davinci/pm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index d282b0783ecf..163d865abbf9 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -161,6 +161,7 @@ int __init davinci_pm_init(void)
>  						davinci_cpu_suspend_sz);
>  
>  	suspend_set_ops(&davinci_pm_ops);
> +	return 0;

We normally have an empty line before return. I added that while 
applying. Also, I modified the patch description to be more "sure" in 
its language. Here is the final description:

    ARM: davinci: PM: Do not free useful resources in normal path in 'davinci_pm_init'
    
    It is wrong to iounmap resources in the normal path of davinci_pm_init()
    
    The 3 ioremap'ed fields of 'pm_config' can be accessed later on in other
    functions, so we should return 'success' instead of unrolling everything.
    
    Fixes: aa9aa1ec2df6 ("ARM: davinci: PM: rework init, remove platform device")
    Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    [nsekhar at ti.com: commit message and minor style fixes]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

I will let this go through some testing before sending for inclusion in 
v4.12 kernel. Thanks for catching these.

For future, when sending more than one patch, please add a cover 
letter. And have the patches appear as replies to the cover letter. 
This happens if you send the patches together with cover letter using 
git-send-email and have chainreplyto set to false in your .gitconfig

Thanks,
Sekhar
