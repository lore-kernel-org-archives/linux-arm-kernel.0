From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 12 Feb 2012 00:37:46 +0400
Subject: [PATCH V3 1/1] dt: add of_get_child_count helper function
In-Reply-To: <1328980929-5423-1-git-send-email-dong.aisheng@linaro.org>
References: <1328980929-5423-1-git-send-email-dong.aisheng@linaro.org>
Message-ID: <4F36D19A.8050409@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-02-2012 21:22, Dong Aisheng wrote:

> Currently most code to get child count in kernel are almost same,
> add a helper to implement this function for dt to use.

> Signed-off-by: Dong Aisheng<dong.aisheng@linaro.org>
> Cc: Grant Likely<grant.likely@secretlab.ca>
> Cc: Rob Herring<rob.herring@calxeda.com>

> ---
> Hi Rob,

> Since my imx pinctrl driver series still depends on the pinctrl core dt
> binding patch which is still not in mainline, i'd like this pure dt patch
> go separately first in case others want to use.

> changes v2->v3:
>   Addressed some people's comments:
>   * do not use assignment as expression
>   * return 0 for non-dt case

> Changes v1->v2:
>   * change the name from of_get_child_number to of_get_child_count
> ---
>   include/linux/of.h |   16 ++++++++++++++++
>   1 files changed, 16 insertions(+), 0 deletions(-)

> diff --git a/include/linux/of.h b/include/linux/of.h
> index a75a831..ae242ef 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -195,6 +195,17 @@ extern struct device_node *of_get_next_child(const struct device_node *node,
>   	for (child = of_get_next_child(parent, NULL); child != NULL; \
>   	     child = of_get_next_child(parent, child))
>
> +static inline int of_get_child_count(const struct device_node *np)
> +{
> +	struct device_node *child = NULL;
> +	int num = 0;
> +
> +	while ((child = of_get_next_child(np, child)) != NULL)

    Doesn't scripts/checkpatch.pl complain here?

> +		num++;
> +
> +	return num;
> +}
> +

WBR, Sergei
