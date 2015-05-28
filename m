From: greg@kroah.com (Greg KH)
Date: Thu, 28 May 2015 08:59:22 -0700
Subject: [PATCH 2/3] Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA
 don't overlap the MBus bridge window"
In-Reply-To: <5566DD16.9030706@free-electrons.com>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5566DD16.9030706@free-electrons.com>
Message-ID: <20150528155922.GB14460@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 11:17:10AM +0200, Gregory CLEMENT wrote:
> Hi Thomas,
> 
> On 28/05/2015 10:40, Thomas Petazzoni wrote:
> > This reverts commit 1737cac69369 ("bus: mvebu-mbus: make sure SDRAM CS
> > for DMA don't overlap the MBus bridge window"), because it breaks DMA
> > on platforms having more than 2 GB of RAM.
> > 
> > This commit changed the information reported to DMA masters device
> > drivers through the mv_mbus_dram_info() function so that the returned
> > DRAM ranges do not overlap with I/O windows.
> > 
> > This was necessary as a preparation to support the new CESA Crypto
> > Engine driver, which will use DMA for cryptographic operations. But
> > since it does DMA with the SRAM which is mapped as an I/O window,
> > having DRAM ranges overlapping with I/O windows was problematic.
> > 
> > To solve this, the above mentioned commit changed the mvebu-mbus to
> > adjust the DRAM ranges so that they don't overlap with the I/O
> > windows. However, by doing this, we re-adjust the DRAM ranges in a way
> > that makes them have a size that is no longer a power of two. While
> > this is perfectly fine for the Crypto Engine, which supports DRAM
> > ranges with a granularity of 64 KB, it breaks basically all other DMA
> > masters, which expect power of two sizes for the DRAM ranges.
> > 
> > Due to this, if the installed system memory is 4 GB, in two
> > chip-selects of 2 GB, the second DRAM range will be reduced from 2 GB
> > to a little bit less than 2 GB to not overlap with the I/O windows, in
> > a way that results in a DRAM range that doesn't have a power of two
> > size. This means that whenever you do a DMA transfer with an address
> > located in the [ 2 GB ; 4 GB ] area, it will freeze the system. Any
> > serious DMA activity like simply running:
> > 
> >   for i in $(seq 1 64) ; do dd if=/dev/urandom of=file$i bs=1M count=16 ; done
> > 
> > in an ext3 partition mounted over a SATA drive will freeze the system.
> > 
> > Since the new CESA crypto driver that uses DMA has not been merged
> > yet, the easiest fix is to simply revert this commit. A follow-up
> > commit will introduce a different solution for the CESA crypto driver.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Fixes: 1737cac69369 ("bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window")
> > Cc: <stable@vger.kernel.org> # v4.0+
> 
> applied on mvebu/fixes
> 
> I hope that the 100 lines rules will be not a problem for this case

It will not be, don't worry.

thanks,

greg k-h
