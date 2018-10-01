From: david@lechnology.com (David Lechner)
Date: Mon, 1 Oct 2018 11:03:47 -0500
Subject: [PATCH] nvmem: fix nvmem_cell_get_from_lookup()
In-Reply-To: <20181001100052.3580-1-brgl@bgdev.pl>
References: <20181001100052.3580-1-brgl@bgdev.pl>
Message-ID: <44adbace-6849-e37f-70f0-d11661e6bdc9@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2018 05:00 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We check if the pointer returned by __nvmem_device_get() is not NULL
> while we should actually check if it is not IS_ERR(nvmem). Fix it.
> 
> While we're at it: fix the next error path where we should assign an
> error value to cell before returning.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ad1227df1984..8249621d11a6 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   		    (strcmp(lookup->con_id, con_id) == 0)) {
>   			/* This is the right entry. */
>   			nvmem = __nvmem_device_get(NULL, lookup->nvmem_name);
> -			if (!nvmem) {
> +			if (IS_ERR(nvmem)) {
>   				/* Provider may not be registered yet. */
> -				cell = ERR_PTR(-EPROBE_DEFER);
> +				cell = (struct nvmem_cell *)nvmem;

perhaps ERR_CAST() would better indicate the intent here?

>   				goto out;
>   			}
>   
> @@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
>   						       lookup->cell_name);
>   			if (!cell) {
>   				__nvmem_device_put(nvmem);
> +				cell = ERR_PTR(-ENOENT);
>   				goto out;
>   			}
>   		}
> 
