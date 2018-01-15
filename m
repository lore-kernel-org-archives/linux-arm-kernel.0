From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Jan 2018 15:06:34 +0000
Subject: [PATCH v6 07/12] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
In-Reply-To: <20180113005920.28658-8-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-8-jeremy.linton@arm.com>
Message-ID: <20180115150634.GB12531@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:59:15PM -0600, Jeremy Linton wrote:
> Add a entry to to struct cacheinfo to maintain a reference to the PPTT
> node which can be used to match identical caches across cores. Also
> stub out cache_setup_acpi() so that individual architectures can
> enable ACPI topology parsing.
>

You need to reword above message as you no longer add a new entry.
Other than a minor nit below, looks good.

With those changes done,
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c       |  1 +
>  drivers/base/cacheinfo.c  | 20 +++++++++++++-------
>  include/linux/cacheinfo.h |  9 +++++++++
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 2c4b3ed862a8..4f5ab19c3a08 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -329,6 +329,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>  {
>  	int valid_flags = 0;
>  
> +	this_leaf->fw_unique = cpu_node;
>  	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>  		this_leaf->size = found_cache->size;
>  		valid_flags++;
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 217aa90fb036..ee51e33cc37c 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -208,16 +208,16 @@ static int cache_setup_of_node(unsigned int cpu)
>  
>  	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
>  		return -ENOENT;
> -
>  	return 0;
>  }
> +

[nit] may be it looks better now but still unnecessary, please drop in
the context of $subject patch.

--
Regards,
Sudeep
