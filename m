From: rabin@rab.in (Rabin Vincent)
Date: Tue, 23 Feb 2016 16:30:03 +0100
Subject: [PATCH 2/2] ARM: dma-mapping: fix alloc/free for coherent + CMA
 + gfp=0
In-Reply-To: <xa1tio1kzu4j.fsf@mina86.com>
References: <1455869524-13874-1-git-send-email-rabin.vincent@axis.com>
 <1455869524-13874-2-git-send-email-rabin.vincent@axis.com>
 <xa1tio1kzu4j.fsf@mina86.com>
Message-ID: <20160223153003.GB22447@lnxrabinv.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 02:50:52PM +0100, Michal Nazarewicz wrote:
> I haven?t looked closely at the code, but why not:
> 
> 	struct cma *cma = 
>         if (!cma_release(dev_get_cma_area(dev), page, size >> PAGE_SHIFT)) {
> 		// ... do whatever other non-CMA free
> 	}

The page tables changes need to be done before we release the area with
cma_release().  With the v2 patchset which I've sent to LAKML we won't
need a new in_cma() function since we'll now record how we allocated the
buffer and use this information in the free routine.
