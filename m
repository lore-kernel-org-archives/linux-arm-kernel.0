From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 22 Apr 2011 09:33:56 +0200
Subject: [PATCH 2/7] ARM: Samsung: update/rewrite Samsung SYSMMU (IOMMU)
	driver
In-Reply-To: <201104211618.31418.arnd@arndb.de>
References: <1303118804-5575-1-git-send-email-m.szyprowski@samsung.com>
	<201104211400.13289.arnd@arndb.de>
	<003301cc002c$f67ba0c0$e372e240$%szyprowski@samsung.com>
	<201104211618.31418.arnd@arndb.de>
Message-ID: <000001cc00bf$a3afc220$eb0f4660$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, April 21, 2011 4:19 PM Arnd Bergmann wrote:

> On Thursday 21 April 2011, Marek Szyprowski wrote:
> > > No, I think that would be much worse, it definitely destroys all kinds
> of
> > > assumptions that the core code makes about devices. However, I don't
> think
> > > it's much of a problem to just create two child devices and use them
> > > from the main driver, you don't really need to create a device_driver
> > > to bind to each of them.
> >
> > I must have missed something. Video codec is a platform device and struct
> > device pointer is gathered from it (&pdev->dev). How can I define child
> > devices and attach them to the platform device?
> 
> There are a number of ways:
> 
> * Do device_create() with &pdev->dev as the parent, inside of the
>   codec driver, with a new class you create for this purpose
> * Do device_register() for a device, in the same way
> * Create the additional platform devices in the platform code,
>   with their parents pointing to the code device, then
>   look for them using device_for_each_child in the driver

IMHO this will be the cleanest way. Thanks for the idea.

> * Create two codec devices in parallel and bind to both with your
>   driver, ideally splitting up the resources between the two
>   devices in a meaningful way.

Video codec has only standard 2 resources - ioregs and irq, so there
is not much left for such splitting.

> None of them are extremely nice, but it's not that hard either.
> You should probably prototype a few of these approaches to see
> which one is the least ugly one.

Ok. Today while iterating over the hardware requirements I noticed
one more thing. Our codec hardware has one more, odd requirement for
video buffers. The DMA addresses need to be aligned to 8KiB or 16KiB
(depending on buffer type). Do you have any idea how this can be
handled in a generic way?

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
