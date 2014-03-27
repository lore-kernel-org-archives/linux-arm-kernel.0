From: b32955@freescale.com (Huang Shijie)
Date: Thu, 27 Mar 2014 17:59:58 +0800
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140326125502.0e8d0657@ipc1.ka-ro>
References: <532BCFCC.4080205@freescale.com>
 <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
 <20140326125502.0e8d0657@ipc1.ka-ro>
Message-ID: <20140327095956.GA29623@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 12:55:02PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Huang Shijie wrote:
> > ? 2014?03?26? 16:51, Lothar Wa?mann ??:
> > > I don't see why this should not be supported on i.MX28 (i.MX23 doesn't
> > > do byteswapping anyway, so this wouldn't change anything for i.MX23).
> > > The partitions used by Linux need not necessarily be accessible for the
> > > Boot ROM code (and vice versa).
> > But the first partition used to store the u-boot is accessible for the ROM.
> > 
> Whether this partition is available to Linux depends on the partition table
> passed in the DT.
yes, i agree.

But it is strange if we do not export this partition to Linux.

> 
> > Please see "Figure 12-13" in the 12.12.1.12:
> >    "In order to preserve the BI (bad block information), flash updater 
> > or gang programmer
> > applications need to swap Bad Block Information (BI) data to byte 0 of 
> > metadata area for
> > every page before programming NAND Flash. ROM when loading firmware, 
> > copies back
> > the value at metadata[0] to BI offset in page data. The following figure 
> > shows how the
> > factory bad block marker is preserved."
> > 
> The inspection of the BB markers is only a fallback for the case that
> there is no DBBT. From the same chapter that you quoted above:
> | ROM uses DBBT to skip any bad block that falls within firmware data
> | on NAND Flash device.
> | If the address of DBBT Search Area in FCB is 0, ROM will rely on
> | factory marked bad block markers to find out if a block is good or bad.
> 
> Thus, even the boot ROM of i.MX28 can well live without blockmark
> swapping.

Assume that there is a NAND block "A",  and the A consist of 256 pages.
the uboot is burned to the "A", can occupy 6 pages:

  -----------------------------------------------------------------------------
 | page 0 |  page 1 | page 2 | page 3 | page 4 | page 5 | ... | ... | page 255 |
  -----------------------------------------------------------------------------
 
  \-------------------------------------- ------------------------------------/
                                         V  
                                        "A"					 

The DBBT is used to track if "A" is bad or not.
Assume we know that "A" is a good block, ROM then need to read out the uboot.
When the ROM needs to read out the 6 pages one by one. And each time the ROM read
the page, it should do the swapping for this page.

In this case, the ROM will do the swapping six times.

Please read the sector again, you will see the "every page" in it:
--------------------------------------------------------------------
   "In order to preserve the BI (bad block information), flash updater 
or gang programmer applications need to swap Bad Block Information (BI) data to byte 0 of 
metadata area for every page before programming NAND Flash. ROM when loading firmware, 
copies back
--------------------------------------------------------------------

thanks
Huang Shijie
