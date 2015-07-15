From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 15 Jul 2015 08:59:46 -0700
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <201507151352.27689.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <20150604171547.GA1530@localhost.localdomain>
 <CAOMqctSCL9E-kCBryeaMvtssSP12RY=kyfPuwSYx9wc=Lv9kGQ@mail.gmail.com>
 <201507151352.27689.marex@denx.de>
Message-ID: <20150715155946.GB21362@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Wed, Jul 15, 2015 at 01:52:27PM +0200, Marek Vasut wrote:
> The problem is, if you add a new DT binding, you'd have to support it
> forever, no matter how bad idea that binding turned out to be.

Agreed, and a solid NAK to this patch. I could have sworn I gave such a
response when this was originally being discussed a month ago.

AFAICT, you have one of two general approaches available to you:

1. Fix up the SPI driver so that it knows how to break large SPI
transfers up into smaller segments that its constituent hardware (DMA
controllers, fast clocks, etc.) can handle.

2. Utilize/create a parameter within the SPI subsystem to communicate
that the SPI master has a limited max transfer size (notably: NOT a
per-device DT property, but a SPI API property), and modify SPI device
drivers (like m25p80) to honor it. Mark Brown seemed open to this, and I
thought he suggested it somewhere.

It is most definitely wrong to put this information solely in the slave
device DT (i.e., for the flash), when it is not a property of the flash
device at all. It's a property of the SPI master and/or its clocks and
DMA controllers.

Brian
