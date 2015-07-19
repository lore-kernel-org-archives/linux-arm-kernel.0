From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 19 Jul 2015 21:01:34 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <20150715155946.GB21362@localhost>
References: <cover.1433364398.git.hramrach@gmail.com>
 <20150604171547.GA1530@localhost.localdomain>
 <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
 <201507151352.27689.marex@denx.de> <20150715155946.GB21362@localhost>
Message-ID: <CAOMqctTJEg7EauKfrqW-6rUQ-QOmtkTfkgOyz0rCuyh_-XrW5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 15 July 2015 at 17:59, Brian Norris <computersforpeace@gmail.com> wrote:
> Hi Michal,
>
> On Wed, Jul 15, 2015 at 01:52:27PM +0200, Marek Vasut wrote:
>> The problem is, if you add a new DT binding, you'd have to support it
>> forever, no matter how bad idea that binding turned out to be.
>
> Agreed, and a solid NAK to this patch. I could have sworn I gave such a
> response when this was originally being discussed a month ago.
>
> AFAICT, you have one of two general approaches available to you:
>
> 1. Fix up the SPI driver so that it knows how to break large SPI
> transfers up into smaller segments that its constituent hardware (DMA
> controllers, fast clocks, etc.) can handle.
>
> 2. Utilize/create a parameter within the SPI subsystem to communicate
> that the SPI master has a limited max transfer size (notably: NOT a
> per-device DT property, but a SPI API property), and modify SPI device
> drivers (like m25p80) to honor it. Mark Brown seemed open to this, and I
> thought he suggested it somewhere.

It is not known what exactly is limited here.

It seems that the pl330 fails but it is not possible to transfer that
much data over the spi bus in one go without the help of the pl330.

With either approach the limit depends on the SPI transfer settings
which are known the the SPI driver. The pl330 driver is oblivious to
these because it just transfers data from one port to another port and
has no idea that the port is wired to SPI in the SoC.

On the other hand, AFAICT the SPI driver only allocates a DMA channel
which it receives through DT binding and is oblivious to the fact the
DMA channel lives on a pl330. It could probably determine that the
channel is indeed driven by a pl330. I don't think it's a great idea
to add device-specific handling to a generic dmaengine driver or a
dmaengine-spiecific handling to a SPI driver.

It's technically possible to pass SPI transfer parameters to the
dmaengine driver prior to transfer and the dmaengine could impose some
limitation based on those parameters. However, generalising this to
drivers other than SPI might be problematic. Should this interface
also handle i2c parameters, VE parameters, audio parameters, ethernet
parameters, etc?

In the DT you have the information that this particular device is
connected to a Samsung SPI controller connected to a pl330 dma engine.

>
> It is most definitely wrong to put this information solely in the slave
> device DT (i.e., for the flash), when it is not a property of the flash
> device at all. It's a property of the SPI master and/or its clocks and
> DMA controllers.

However, the clocks are set by the parameters of the device, not the
parameters of the master. So the limitation applies for the master
with the settings of the particular slave device. Different slave
settings do impose different master limitations.

Thanks

Michal
