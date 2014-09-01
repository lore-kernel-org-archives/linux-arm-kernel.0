From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 1 Sep 2014 10:13:22 +0200
Subject: [RFC PATCH 3/7] iommu: add new iommu_ops callback for adding a
 device with a set of IDs
In-Reply-To: <1409327670-3495-4-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-4-git-send-email-will.deacon@arm.com>
Message-ID: <20140901081320.GB24430@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 04:54:26PM +0100, Will Deacon wrote:
> This patch adds a new function to the iommu_ops structure to allow a
> device to be added to a specific IOMMU instance along with a set of
> opaque IDs that are used internally by the IOMMU for identifying and
> configuring translations.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)

I don't really see the point of this new callback. As I understand it,
the strength of the current .add_device() callback is that it uses only
the struct device and figures out which exact IOMMU to associate it with
in case there are multiple IOMMUs.

Although that doesn't seem to be the general case either. That's really
been one of the difficulties in dealing with IOMMU. Every driver seems
to do things very differently and the IOMMU subsystem itself is fairly
different from other subsystems too.

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 20f9a527922a..3dd1b99c4542 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,8 @@ struct iommu_ops {
>  	int (*domain_has_cap)(struct iommu_domain *domain,
>  			      unsigned long cap);
>  	int (*add_device)(struct device *dev);
> +	int (*add_device_master_ids)(struct device *dev, int count, u32 *ids,
> +				     void *data);

If we want to pass around IOMMU instances I think we should make them
proper objects rather than some loosely specified void *.

Also the generic IOMMU binding doesn't require the IOMMU specifier to
contain master IDs. So this seems to be a callback that would only be
used by a restricted set of IOMMUs.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/93dc1a1e/attachment.sig>
