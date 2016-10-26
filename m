From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Oct 2016 19:36:14 +0100
Subject: [PATCH 2/2] arm64/numa: support HAVE_MEMORYLESS_NODES
In-Reply-To: <1477364358-10620-3-git-send-email-thunder.leizhen@huawei.com>
References: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
 <1477364358-10620-3-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20161026183614.GJ15216@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 10:59:18AM +0800, Zhen Lei wrote:
> Some numa nodes may have no memory. For example:
> 1) a node has no memory bank plugged.
> 2) a node has no memory bank slots.
> 
> To ensure percpu variable areas and numa control blocks of the
> memoryless numa nodes to be allocated from the nearest available node to
> improve performance, defined node_distance_ready. And make its value to be
> true immediately after node distances have been initialized.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/Kconfig            | 4 ++++
>  arch/arm64/include/asm/numa.h | 3 +++
>  arch/arm64/mm/numa.c          | 6 +++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 30398db..648dd13 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -609,6 +609,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	def_bool y
>  	depends on NUMA
> 
> +config HAVE_MEMORYLESS_NODES
> +	def_bool y
> +	depends on NUMA

Given that patch 1 and the associated node_distance_ready stuff is all
an unqualified performance optimisation, is there any merit in just
enabling HAVE_MEMORYLESS_NODES in Kconfig and then optimising things as
a separate series when you have numbers to back it up?

Will
