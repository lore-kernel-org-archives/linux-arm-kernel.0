From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 23 Oct 2014 10:09:54 +0200
Subject: [PATCH 2/2] iommu: Implement a dummy bus_set_iommu()
In-Reply-To: <20141022142922.GH10074@8bytes.org>
References: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
 <1406897113-20099-2-git-send-email-thierry.reding@gmail.com>
 <20140818165750.GE9809@8bytes.org> <20141015091043.GA13162@ulmo>
 <20141022142922.GH10074@8bytes.org>
Message-ID: <20141023080953.GA30397@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 04:29:22PM +0200, Joerg Roedel wrote:
> On Wed, Oct 15, 2014 at 11:10:44AM +0200, Thierry Reding wrote:
> > It seems like I never got back to you on this. The reason here is that
> > for Tegra the IOMMU is part of a larger IP block. The IP block is
> > primarily a memory controller with a bunch of configuration knobs for
> > arbitration, prioritization and whatnot. A smaller part of the device
> > does the IOMMU translation. Therefore the IOMMU implementation would
> > be part of a larger driver, and having this dummy would reduce the
> > amount of #ifdefs required.
> > 
> > bus_set_iommu() is also the only function in include/linux/iommu.h that
> > doesn't have a dummy, so it seemed like a natural thing to do.
> > 
> > That said, I can work around this being absent for !IOMMU_API.
> 
> Or you make this "larger driver" just depend on IOMMU_API? Otherwise you
> need the #ifdefs anyway to not carry around the iommu-ops functions in
> the driver without having the iommu core enabled, no?

I can do that using IS_ENABLED() magic, which will cause the iommu_ops
to be thrown away automatically when IOMMU_API is disabled. That allows
the driver to be compiled with full coverage and still only include the
needed parts in the final binary.

Then again, going forward it doesn't seem likely that we'll ever want to
disable IOMMU on Tegra once it's been enabled, so this isn't really a
big issue.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141023/f7908fa3/attachment.sig>
