From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 5 Oct 2011 11:26:32 +0200
Subject: [RFC 1/5] ARM: dev_archdata: add private iommu extension
In-Reply-To: <1316948337-7924-2-git-send-email-ohad@wizery.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-2-git-send-email-ohad@wizery.com>
Message-ID: <CAK=Wgba6xxD2DBJhM--AcTPBoNRiOZ_6f8+j3bfaCqZMO8A4+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sun, Sep 25, 2011 at 1:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Add a private iommu pointer to the ARM-specific arch data in the
> device struct, which will be used to attach iommu-specific data
> to devices which require iommu support.

Can you please take a look and ack/nack ?

With this change in hand, generic code will now be able to control
OMAP's iommu devices too, without having to use any OMAP-specific API
(this is demonstrated in this patch set).

This will allow us to further clean the existing mainline OMAP iommu
users, and focus on generic IOMMU code for future users
(rpmsg/remoteproc and Marek's upcoming generic DMA API).

The change is only effective when an iommu driver, which supports the
generic IOMMU API, is built (all of them must select
CONFIG_IOMMU_API), and otherwise is a nop.

Obviously the change itself is not OMAP-specific, and it will be
useful for other platforms too.

Thanks!
Ohad.

> Different iommu implementations (on different platforms) will attach
> different types of data to this pointer, so 'void *' is currently used
> (the downside is reduced typesafety).
>
> Note: ia64, x86 and sparc have this exact iommu extension as well, and
> if others are likely to adopt it too, we might want to consider
> adding this to the device struct itself directly.
>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> ?arch/arm/include/asm/device.h | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
> index 9f390ce..6615f03 100644
> --- a/arch/arm/include/asm/device.h
> +++ b/arch/arm/include/asm/device.h
> @@ -10,6 +10,9 @@ struct dev_archdata {
> ?#ifdef CONFIG_DMABOUNCE
> ? ? ? ?struct dmabounce_device_info *dmabounce;
> ?#endif
> +#ifdef CONFIG_IOMMU_API
> + ? ? ? void *iommu; /* private IOMMU data */
> +#endif
> ?};
>
> ?struct pdev_archdata {
> --
> 1.7.4.1
>
>
