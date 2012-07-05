From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Jul 2012 08:09:15 +0000
Subject: [PATCH v4 RESEND] mm: cma: add a simple kernel module as the
 helper to test CMA
In-Reply-To: <1341469459-29558-1-git-send-email-Barry.Song@csr.com>
References: <1341469459-29558-1-git-send-email-Barry.Song@csr.com>
Message-ID: <201207050809.15834.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 July 2012, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> Any write request to /dev/cma_test will let the module to allocate memory from
> CMA, for example:
> 
> 1st time
> $ echo 1024 > /dev/cma_test
> will require cma_test to request 1MB(1024KB)
> 2nd time
> $ echo 2048 > /dev/cma_test
> will require cma_test to request 2MB(2048KB)
> 
> Any read request to /dev/cma_test will let the module to free the 1st valid
> memory from CMA, for example:
> 
> 1st time
> $ cat /dev/cma_test
> will require cma_test to free the 1MB allocated in the first write request
> 2nd time
> $ cat /dev/cma_test
> will require cma_test to free the 2MB allocated in the second write request

I missed the earlier times this was posted and read up on it now.

> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Reviewed-by: Michal Nazarewicz <mina86@mina86.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  resend to Greg KH so that he can decide whether it should be placed at tools
>  or drivers/misc;
>  See the discussion thread:
>  [1] https://lkml.org/lkml/2012/7/3/80
>  [2] https://lkml.org/lkml/2012/7/3/224
>  [3] https://lkml.org/lkml/2012/7/4/87

I think it should be in mm/cma-test.c, along with kmemleak-test.c. It would be nice
if you could add some code that just runs at boot time (or when the module is
loaded) and allocates and frees memory using CMA.

> +static struct device *cma_dev;

Do you actually need this device? It's not connected to hardware so
it doesn't actually do DMA and we might as well pass a NULL pointer
into dma_alloc_*().

> +static const struct file_operations cma_test_fops = {
> +	.owner =    THIS_MODULE,
> +	.read  =    cma_test_read,
> +	.write =    cma_test_write,
> +};
> +
> +static struct miscdevice cma_test_misc = {
> +	.name = "cma_test",
> +	.fops = &cma_test_fops,
> +};
> +
> +static int __init cma_test_init(void)
> +{
> +	int ret = misc_register(&cma_test_misc);

A better place for this is really debugfs. The driver is not meant as a stable
kernel interface that applications can rely on, it's purely a debugging help.

Just make this

	ret = debugfs_create_file("cma-test", 0600, NULL, NULL, &cma_test_fops);



	Arnd
