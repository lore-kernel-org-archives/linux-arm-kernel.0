From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 26 Jul 2015 01:02:32 +0300
Subject: [PATCH v2 15/25] memconsole: fix __iomem mishandling, switch to
 memremap
In-Reply-To: <20150725023923.8664.66965.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023923.8664.66965.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <55B40778.4010909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/25/2015 05:39 AM, Dan Williams wrote:

> The memconsole driver is not using proper accessors for __iomem.  Switch
> to memremap to fix this issue, and this also prepares the driver for the
> removal of ioremap_cache.

> Cc: Mike Waychison <mikew@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/firmware/google/memconsole.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
> index 2f569aaed4c7..1b25fba84f32 100644
> --- a/drivers/firmware/google/memconsole.c
> +++ b/drivers/firmware/google/memconsole.c
> @@ -52,14 +52,15 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
>   	char *memconsole;
>   	ssize_t ret;
>
> -	memconsole = ioremap_cache(memconsole_baseaddr, memconsole_length);
> +	memconsole = memremap(memconsole_baseaddr, memconsole_length,
> +			MEMREMAP_CACHE);

    Could you maintain the existing style of the broken line alignment in this 
file?

>   	if (!memconsole) {
> -		pr_err("memconsole: ioremap_cache failed\n");
> +		pr_err("memconsole: memremap failed\n");
>   		return -ENOMEM;
>   	}
>   	ret = memory_read_from_buffer(buf, count, &pos, memconsole,
>   				      memconsole_length);

    Here's an example...

> -	iounmap(memconsole);
> +	memunmap(memconsole);
>   	return ret;
>   }

MBR, Sergei
