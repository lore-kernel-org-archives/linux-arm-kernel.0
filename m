From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 27 Sep 2017 14:15:40 +0200
Subject: [RFC] iommu: arm-smmu: stall support
In-Reply-To: <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
References: <20170914194444.32551-1-robdclark@gmail.com>
 <20170919123038.GF8398@8bytes.org>
 <CAF6AEGuutkqjrWk4jagE=p-NwHgxdiPZjjsaFsfwtczK568j+A@mail.gmail.com>
 <20170922090204.GJ8398@8bytes.org>
 <32e3ab2c-a996-c805-2a0d-a2e85deb3a50@arm.com>
 <CAF6AEGuh0FiNWEAmFm+7-7pc6MV5hKKz9cyA_J0d256bY-nYOQ@mail.gmail.com>
Message-ID: <20170927121540.GL8398@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob, Jean,

On Fri, Sep 22, 2017 at 02:42:44PM -0400, Rob Clark wrote:
> I'm in favour if splitting the reporting *somehow*.. the two
> approaches that seemed sane are:
> 
> 1) call fault handler from irq and having separate domain->resume()
> called by the driver, potentially from a wq
> 2) or having two fault callbacks, first called before wq and then
> based on returned value, optionally 2nd callback called from wq
> 
> The first seemed less intrusive to me, but I'm flexible.

How about adding a flag to the fault-handler call-back that tells us
whether it wants to sleep or not. If it wants, we call it from a wq, if
not we call call it directly like we do today in the
report_iommu_fault() function.

In any case we call iommu_ops->resume() when set on completion of the
fault-handler either from the workqueue or report_iommu_fault itself.


Regards,

	Joerg
