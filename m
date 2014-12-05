From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Dec 2014 15:18:43 +0000
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
Message-ID: <20141205151843.GV11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 01:21:37PM +0530, Jassi Brar wrote:
> because the reasoning above seems incorrect considering the following
> documentation...
> 
> Documentation/crypto/async-tx-api.txt says
                       ^^^^^^^^^^^^

async-tx-api is not the DMA slave API.

>   " .... Once a driver-specific threshold is met the driver
> automatically issues pending operations.  An application can force this
> event by calling async_tx_issue_pending_all(). ...."
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^

DMA slave users do not call this function.  This documentation is not
relevant for DMA slave.

> include/linux/dmaengine.h says
>   dma_async_tx_descriptor.tx_submit(): set the prepared descriptor(s)
> to be executed by the engine

It doesn't say when.

> so theoretically a driver, not starting transfer until
> issue_pending(), is "broken".

It isn't.  DMA slave engine implementations have been needing the
issue_pending() call since their dawn, so it's something that they've
always needed.

> At best the patch at 04abf5daf7d makes the driver slightly more
> complicated and the reason behind confusion such as in this thread.

That may be, and yes, it _might_ be worth discussing whether this should
be relaxed or not, but that should be done as a proposal, not trying to
hide it as a bug fix.  It isn't.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
