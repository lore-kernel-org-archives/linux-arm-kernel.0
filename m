From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Fri, 16 Jul 2010 18:49:09 +0530
Subject: [PATCH 0/3] Cache maintenance on VIPT caches
In-Reply-To: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
References: <20100625115826.30030.89790.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100716131908.GA15032@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 25, 2010 at 14:01:27 +0200, Catalin Marinas wrote:
> The first and third patches have already been posted in the same form.
> The second patch have been modified to handle all the VIPT caches via
> __sync_icache_dcache(). The initial use case for this patch was dealing
> with an SMP race condition but following suggestions from Rabin, it was
> extended to cover ARMv6 onwards, both UP and SMP.
> 
> Any Tested-by's are welcome.

This version also fixes the MMC rootfs init crashes, without the need
for the flush_kernel_dcache_page() change:

Tested-by: Rabin Vincent <rabin.vincent@stericsson.com>

Will you be submitting this patch for linux-next?  I ask because the
mmci patches that I posted convert that driver to use the sg_miter API
(which uses flush_kernel_dcache_page() internally), and not do any
flushing inside the driver itself.  Or do you think it would be
appropriate to have the driver call flush_dcache_page() explicitly?
(Although this would be double flushing on systems with aliasing caches
where flush_kernel_dcache_page() is not a no-op.)

Rabin
