From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 13:47:46 +0100
Subject: [PATCH v7 05/14] arm64/numa: avoid inconsistent information to
 be printed
In-Reply-To: <1472024693-12912-6-git-send-email-thunder.leizhen@huawei.com>
References: <1472024693-12912-1-git-send-email-thunder.leizhen@huawei.com>
 <1472024693-12912-6-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20160826124746.GB30302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 03:44:44PM +0800, Zhen Lei wrote:
> numa_init(of_numa_init) may returned error because of numa configuration
> error. So "No NUMA configuration found" is inaccurate. In fact, specific
> configuration error information should be immediately printed by the
> testing branch.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/numa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 5bb15ea..d97c6e2 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -335,8 +335,10 @@ static int __init numa_init(int (*init_func)(void))
>  	if (ret < 0)
>  		return ret;
> 
> -	if (nodes_empty(numa_nodes_parsed))
> +	if (nodes_empty(numa_nodes_parsed)) {
> +		pr_info("No NUMA configuration found\n");
>  		return -EINVAL;

Hmm, but dummy_numa_init calls node_set(nid, numa_nodes_parsed) for a
completely artificial setup, created by adding all memblocks to node 0,
so this new message will be suppressed even though things really did go
wrong.

In that case, don't we want to print *something* (like we do today in
dummy_numa_init) but maybe not "No NUMA configuration found"? What
exactly do you find inaccurate about the current message?

Will
