From: joe@perches.com (Joe Perches)
Date: Mon, 27 Jun 2016 04:49:21 -0700
Subject: [PATCH net-next 6/9] net: hns: normalize two different loop
In-Reply-To: <1467021255-95900-7-git-send-email-Yisen.Zhuang@huawei.com>
References: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1467021255-95900-7-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1467028161.1847.101.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-27 at 17:54 +0800, Yisen Zhuang wrote:
> From: Daode Huang <huangdaode@hisilicon.com>
> 
> There are two approaches to assign data, one does 2 loops, another
> does 1 loop. This patch normalize the different methods to 1 loop.
[]
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
[]
> @@ -2567,15 +2567,15 @@ static char *hns_dsaf_get_node_stats_strings(char *data, int node,
> ?	buff += ETH_GSTRING_LEN;
> ?	if (node < DSAF_SERVICE_NW_NUM && !is_ver1) {
> ?		for (i = 0; i < DSAF_PRIO_NR; i++) {
> -			snprintf(buff, ETH_GSTRING_LEN,
> -				?"inod%d_pfc_prio%d_pkts", node, i);
> -			buff += ETH_GSTRING_LEN;
> -		}
> -		for (i = 0; i < DSAF_PRIO_NR; i++) {
> -			snprintf(buff, ETH_GSTRING_LEN,
> -				?"onod%d_pfc_prio%d_pkts", node, i);
> +			snprintf(buff + 0 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
> +				?ETH_GSTRING_LEN, "inod%d_pfc_prio%d_pkts",
> +				?node, i);
> +			snprintf(buff + 1 * ETH_GSTRING_LEN * DSAF_PRIO_NR,
> +				?ETH_GSTRING_LEN, "onod%d_pfc_prio%d_pkts",
> +				?node, i);
> ?			buff += ETH_GSTRING_LEN;

This looks odd and likely incorrect.

> ?		}
> +		buff += 1 * DSAF_PRIO_NR * ETH_GSTRING_LEN;
> ?	}
