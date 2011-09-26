From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 23:48:41 +0900
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAK=WgbaOwe8Q19tpZMeHdvyCj8fcV194zA-oSD20tF7j7_MvpQ@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
	<CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
	<CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
	<CAHQjnON7dksupFeAYLuYXX2PhgjX-GXEGJiy0dRTmpoBjbURVg@mail.gmail.com>
	<CAK=WgbaOwe8Q19tpZMeHdvyCj8fcV194zA-oSD20tF7j7_MvpQ@mail.gmail.com>
Message-ID: <CAHQjnOM_KTiqzYnePScMHQ3bg5X1wqa4zu6=1A1z7UWeDxVZvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 6:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> It seems your default behavior just prints an error message with the
> details of the fault (addresses, flags, etc..). We can probably have
> this unified.
>
> In case you want to print exonys-specific info when the fault is not
> handled by upper layers, we can change report_iommu_fault() to return
> an error whenever a handler is not installed. This way
> exynos_sysmmu_irq() can easily tell whether to proceed with the
> default behavior or not, without installing a fault handler in the
> driver:
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 297893f..dc4b282 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -103,7 +103,7 @@ extern void iommu_set_fault_handler(struct iommu_domain *dom
> ?static inline int report_iommu_fault(struct iommu_domain *domain,
> ? ? ? ? ? ? ? ?struct device *dev, unsigned long iova, int flags)
> ?{
> - ? ? ? int ret = 0;
> + ? ? ? int ret = -EFAULT;
>
That looks better for me :)
However, I think the irq handler need to identify if the return value
is an error
returned by a fault handler or a notice that no fault handler is installed.

I am sorry but I still think that
installing default fault handler is quite simple and straightforward.

Providing generic default behavior for all architectures is also good
if it is available for other architectures.
My intention with the default behavior for unrecoverable fault from IOMMU is
to show what the problem is, where the problem caused and
thus, providing a hint  to solve or catch the problem
for the device drivers and the developers.

>> BTW,
>> I think we need more fault type than IOMMU_FAULT_READ and IOMMU_FAULT_WRITE.
>> We have page fault, access fault(read, write), security fault
>> and bus error (translated physical address is not available)
>
> Initially we had a argument for the type of the fault, but dropped it
> because it was not used. Feel free to add it back if you need it.
>
OK. thanks.

> Thanks,
> Ohad.

Thank you.
Cho KyongHo.
