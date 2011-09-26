From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 26 Sep 2011 18:59:42 +0300
Subject: [PATCH 3/4] iommu/exynos: Add iommu driver for Exynos4 Platforms
In-Reply-To: <CAHQjnOM_KTiqzYnePScMHQ3bg5X1wqa4zu6=1A1z7UWeDxVZvQ@mail.gmail.com>
References: <15669786.49881316849426265.JavaMail.weblogic@epml24>
	<CAK=WgbYnGjPKs6_nmFRGfMnbh_7wDR-0QcptAGaqDKVOo-x3cg@mail.gmail.com>
	<CAHQjnOOtVHUS3KmBz7LdO88fLQyLA6f-w3ye9nAH0Bx+zh38XA@mail.gmail.com>
	<CAK=Wgbazwz9PRJSpZjopwxJ-PO88FtajmbXL=pVKDHOr1t61fQ@mail.gmail.com>
	<CAHQjnON7dksupFeAYLuYXX2PhgjX-GXEGJiy0dRTmpoBjbURVg@mail.gmail.com>
	<CAK=WgbaOwe8Q19tpZMeHdvyCj8fcV194zA-oSD20tF7j7_MvpQ@mail.gmail.com>
	<CAHQjnOM_KTiqzYnePScMHQ3bg5X1wqa4zu6=1A1z7UWeDxVZvQ@mail.gmail.com>
Message-ID: <CAK=WgbYzZKTRRf6hk=L5ZvXmFAUpq66Ud3F7xh2-8j6zSvAq9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 5:48 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> I am sorry but I still think that
> installing default fault handler is quite simple and straightforward.

... and abusing the IOMMU API.

Please don't do that. Interfaces are written for specific goals, and
this one was added for IOMMU users, not drivers. Just like all the
other map/unmap/attach/... APIs.

By using this from the IOMMU driver itself, you are adding burden on
future development and evolution of this API. As use cases
materialize, we will have to change it to support them, while
considering existing use cases. Using this API inappropriately will
make our life harder later on.

Moreover, I'm really not sure how exactly are you going to use this.

If you're having an IOMMU user which installs its own fault handler,
then this is all moot since the default behavior you provide here will
be overridden.
If you're not having an IOMMU user which installs its own fault
handler, then just provide the default behavior in your irq handler,
regardless whether you report the fault to the IOMMU core or not. Or
only when it fails. and yes, we can provide different error values for
different scenarios. it's not rocket science :).

Really, there's a myriad of ways to do this right. Please explain your
exact settings/use-case and I'll gladly help you find a clean
solution.

Thanks,
Ohad.
