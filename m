From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 17 Jul 2017 14:13:45 +0530
Subject: [PATCH] cpufreq: s5pv210: add missing of_node_put
In-Reply-To: <1500147653-31229-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1500147653-31229-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20170717084345.GN352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-07-17, 21:40, Julia Lawall wrote:
> for_each_compatible_node performs an of_node_get on each iteration, so a
> return from the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> local idexpression n;
> expression e,e1,e2;
> statement S;
> iterator i1;
> iterator name for_each_compatible_node;
> @@
> 
>  for_each_compatible_node(n,e1,e2) {
>    ...
> (
>    of_node_put(n);
> |
>    e = n
> |
>    return n;
> |
>    i1(...,n,...) S
> |
> +  of_node_put(n);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -u -p a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -612,6 +612,7 @@ static int s5pv210_cpufreq_probe(struct

Just before this location we also called of_find_compatible_node()
directly and never did a of_node_put() for that. Can you please fix
that as well ?

>  		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
>  			pr_err("%s: failed to get alias of dmc node '%s'\n",
>  				__func__, np->name);
> +			of_node_put(np);
>  			return id;
>  		}
>  
> @@ -619,6 +620,7 @@ static int s5pv210_cpufreq_probe(struct
>  		if (!dmc_base[id]) {
>  			pr_err("%s: failed to map dmc%d registers\n",
>  				__func__, id);
> +			of_node_put(np);
>  			return -EFAULT;
>  		}
>  	}

-- 
viresh
