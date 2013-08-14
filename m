From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Aug 2013 12:49:38 +0200
Subject: [PATCH v9 03/16] iommu/exynos: fix page table maintenance
In-Reply-To: <CANEJEGu1ponghpfvyUsQX16+TZWUV+0KXJ7AehjXpju2N_H+Ew@mail.gmail.com>
References: <002701ce941a$eecebdb0$cc6c3910$@samsung.com>
 <1516548.d7oQuzQS7g@amdc1227>
 <CANEJEGu1ponghpfvyUsQX16+TZWUV+0KXJ7AehjXpju2N_H+Ew@mail.gmail.com>
Message-ID: <20130814104938.GF4491@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 11:28:44AM -0700, Grant Grundler wrote:
> I can't speak to the previous BUG_ON(). I believe the EADDRESSINUSE
> failures could be either WARN_ON or BUG_ON.   This condition is
> clearly a bug in the generic IOMMU allocator and I think that's why
> KyongHo Cho used BUG_ON.
> 
> Handing out duplicate addresses will generally lead to some sort of
> data corruption or other fault depending on how robust the underlying
> device drivers are written.  So my preference is a BUG_ON to
> immediately flag this condition instead of hoping a device driver will
> correctly handling the dma mapping failure (Some do, most currently
> don't).
> 
> WARN_ON() + return -EADDRESSINUSE would be a good alternative.

Even if it is a real BUG condition, I don't think it is worth to stop
execution at this point. It makes debugging harder and the system less
reliable. I prefer to go with the WARN_ON and an error return value.


	Joerg
