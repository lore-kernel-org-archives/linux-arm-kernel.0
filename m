From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 30 Dec 2013 14:45:23 +0100
Subject: [PATCHv7 05/12] iommu/core: add ops->{bound,unbind}_driver()
In-Reply-To: <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-6-git-send-email-hdoyu@nvidia.com>
Message-ID: <20131230134522.GB2799@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 09:57:06AM +0200, Hiroshi Doyu wrote:
> ops->{bound,unbind}_driver() functions are called at
> BUS_NOTIFY_{BOUND,UNBIND}_DRIVER respectively.
> 
> This is necessary to control the device population order. IOMMU master
> devices depend on an IOMMU device instanciation. IOMMU master devices
> can be registered to an IOMMU only after it's successfully
> populated. This IOMMU registration is done via
> ops->bound_driver(). Currently this population can be deferred if
> depending IOMMU device hasn't yet been populated in driver core. This
> cannot be done via ops->add_device() since after add_device() device's
> population/instanciation can be still deferred via probe().

How about doing dependency checking in the add/remove_device callbacks
instead? When a device is about to be initialized where the IOMMU is not
set up yet, just setup the IOMMU first before initializing the device?


	Joerg
