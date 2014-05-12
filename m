From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 May 2014 14:00:57 +0200
Subject: Questions regarding DMA buffer sharing using IOMMU
In-Reply-To: <BAY169-W12541AD089785F8BFBD4E26EF350@phx.gbl>
References: <BAY169-W12541AD089785F8BFBD4E26EF350@phx.gbl>
Message-ID: <5218408.5YRJXjS4BX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 May 2014 15:12:41 Pintu Kumar wrote:
> Hi, 
> I have some queries regarding IOMMU and CMA buffer sharing. 
> We have an embedded linux device (kernel 3.10, RAM: 256Mb) in 
> which camera and codec supports IOMMU but the display does not support IOMMU. 
> Thus for camera capture we are using iommu buffers using
> ION/DMABUF. But for all display rendering we are using CMA buffers. 
> So, the question is how to achieve buffer sharing (zero-copy)
> between Camera and Display using only IOMMU? 
> Currently we are achieving zero-copy using CMA. And we are
> exploring options to use IOMMU. 
> Now we wanted to know which option is better? To use IOMMU or CMA? 
> If anybody have come across these design please share your thoughts and results. 

There is a slight performance overhead in using the IOMMU in general,
because the IOMMU has to fetch the page table entries from memory
at least some of the time.

If that overhead is within the constraints you have for transfers between
camera and codec, you are always better off using IOMMU since that
means you don't have to do memory migration.

Note however, that we don't have a way to describe IOMMU relations
to devices in DT, so whatever you come up with to do this will most
likely be incompatible with what we do in future kernel versions.

	Arnd
