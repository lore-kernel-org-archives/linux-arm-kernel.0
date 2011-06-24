From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 10:56:30 +0100
Subject: [PATCH] usb: fsl_udc_core: fix build breakage when building
	for ARM arch
In-Reply-To: <1308873788-22881-1-git-send-email-agust@denx.de>
References: <1308873788-22881-1-git-send-email-agust@denx.de>
Message-ID: <20110624095630.GE23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 02:03:08AM +0200, Anatolij Gustschin wrote:
> Commit 09ba0def introduced build breakage on ARM arch.
> Fix it by setting accessors using a static inline function
> which is a nop when compiling the driver for ARM arch.
> 
> Don't use flush_dcache_range(), convert to the DMA API
> usage instead. USB2.0CV Halt Endpoint Test succeeds on
> PPC. Tested both on ARM i.MX31 and mpc5121 PPC.

While this may work, if you enable DMA API debugging, you'll get
complaints.  Please test your changes on ARM with CONFIG_DMA_API_DEBUG
enabled.


        /* FIXME: fsl_alloc_request() ignores ep argument */
        udc->status_req = container_of(fsl_alloc_request(NULL, GFP_KERNEL),
                        struct fsl_req, req);
        /* allocate a small amount of memory to get valid address */
        udc->status_req->req.buf = kmalloc(8, GFP_KERNEL);
        udc->status_req->req.dma = virt_to_phys(udc->status_req->req.buf);

...

        /* Borrow the per device status_req */
        req = udc->status_req;
        /* Fill in the reqest structure */
        *((u16 *) req->req.buf) = cpu_to_le16(tmp);

        /* flush cache for the req buffer */
        flush_dcache_range((u32)req->req.buf, (u32)req->req.buf + 8);

        req->ep = ep;
        req->req.length = 2;
        req->req.status = -EINPROGRESS;
        req->req.actual = 0;
        req->req.complete = NULL;
        req->dtd_count = 0;

        /* prime the data phase */
        if ((fsl_req_to_dtd(req) == 0))
                fsl_queue_td(ep, req);
...

I've no idea why this driver can't use dma_map_single() before queuing,
and dma_unmap_single() once the req is complete.  It looks like done()
will do the unmap provided we map it correctly and set req->mapped.

So, I think that virt_to_phys can be killed, and a dma_map_single() can
be done in place of the flush_dcache_range to set req->req.dma, and
req->mapped needs to be set to cause it to be unmapped.
