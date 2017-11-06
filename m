From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Nov 2017 10:47:52 +0000
Subject: [xlnx:master 1035/1087] drivers//crypto/zynqmp-sha.c:125:3:
 error: implicit declaration of function '__flush_cache_user_range'
In-Reply-To: <201711061846.YTUFx1ti%fengguang.wu@intel.com>
References: <201711061846.YTUFx1ti%fengguang.wu@intel.com>
Message-ID: <20171106104752.GU9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 06:37:48PM +0800, kbuild test robot wrote:
> Hi Nava,
> 
> FYI, the error/warning still remains.
>    drivers//crypto/zynqmp-sha.c: In function 'zynqmp_sha_update':
> >> drivers//crypto/zynqmp-sha.c:125:3: error: implicit declaration of function '__flush_cache_user_range' [-Werror=implicit-function-declaration]
>       __flush_cache_user_range((unsigned long)kbuf,
>       ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/__flush_cache_user_range +125 drivers//crypto/zynqmp-sha.c
> 
>    107	
>    108	static int zynqmp_sha_update(struct ahash_request *req)
>    109	{
>    110		struct zynqmp_sha_ctx *tctx = crypto_tfm_ctx(req->base.tfm);
>    111		struct zynqmp_sha_dev *dd = tctx->dd;
>    112		char *kbuf;
>    113		size_t dma_size = req->nbytes;
>    114		dma_addr_t dma_addr;
>    115		int ret;
>    116	
>    117		if (!req->nbytes)
>    118			return 0;
>    119	
>    120		kbuf = dma_alloc_coherent(dd->dev, dma_size, &dma_addr, GFP_KERNEL);
>    121		if (!kbuf)
>    122			return -ENOMEM;
>    123	
>    124		scatterwalk_map_and_copy(kbuf, req->src, 0, req->nbytes, 0);
>  > 125		 __flush_cache_user_range((unsigned long)kbuf,
>    126					  (unsigned long)kbuf + dma_size);

This is stupid.  This is passing a _kernel_ address to a function that
expects to flush addresses for _userspace_ addresses.

So, NAK on this code from an architecture point of view, it's wrong.

Also, general point (yet again) that drivers should never go under
scratching about in the architecture header files and find architecture
private functions.  The hint is the double-underscore at the start
of the name - and yet again proves that nothing in safe from driver
authors if they can get to it via some header file.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
