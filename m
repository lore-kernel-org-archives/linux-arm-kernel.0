From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Dec 2014 14:23:21 +0000
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <20141208130727.GK16827@intel.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
 <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
 <20141208130727.GK16827@intel.com>
Message-ID: <20141208142321.GE11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 06:37:27PM +0530, Vinod Koul wrote:
> I actually like the split model, you can also prepare txn ahead of time and
> submit them when needed.

Actually, you can't - that's not permitted.  I have email(s) from Dan
explicitly stating that it is permitted for a driver to take a spinlock
in their prepare callback, and release it when the descriptor is
submitted.  Several DMA engine drivers (particularly those in for
async_tx) do exactly that.

The reason that submit is separate from prepare is to allow DMA engine
users to set a callback - if it weren't for that, there wouldn't be a
submit step, prepare would have done everything.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
