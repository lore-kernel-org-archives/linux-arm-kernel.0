From: ricard.wanderlof@axis.com (Ricard Wanderlof)
Date: Thu, 2 Feb 2012 15:01:35 +0100 (CET)
Subject: [PATCH v3] mtd/gpmi : add BBT support to gpmi nand driver
In-Reply-To: <20266.36804.844286.216383@ipc1.ka-ro>
References: <1328008316-27258-1-git-send-email-b32955@freescale.com>
 <20120131121007.GO2471@pengutronix.de>
 <1328183611.28171.170.camel@sauron.fi.intel.com>
 <20266.36804.844286.216383@ipc1.ka-ro>
Message-ID: <Pine.LNX.4.64.1202021441330.554@lnxricardw.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2 Feb 2012, Lothar Wa?mann wrote:

> Hi,

> IMO it's just silly trying to write anything, even a bad block marker,to 
> a known bad block in NAND flash.
>
> The bad block markers in particular bytes in the OOB area are providedby 
> the manufacturer to identify "Factory Bad Blocks". That and no more! I 
> don't know why everybody is trying to interpret them as a general bad 
> block indicator.

Why not? It's just another byte within the block.

It depends on what you mean by the concept 'bad block'. In the data sheets 
manufacturers usually state that 'additional bad blocks can develop over 
time', and this basically means that a block becomes worn out so that they 
don't meet the specifications regarding data retention etc, but the block 
is not defective in the sense that there's been a destructive change in 
the silicon structure.

In contrast, factory bad blocks can be both blocks with physical defects 
preventing their use, as well as blocks which don't meet the 
specifications. In my experience with 1 GB SLC flashes, the latter type of 
'bad' dominates, so that in many cases it is possible to erase the bad 
block markers on factory bad blocks and use them just as any other block. 
Since they were marked bad from the factory it is not a wise idea and 
should definitely not be used for production but can be very handy for 
'unbricking' a device where something has gone wrong with the flash 
management and all blocks have been marked as 'bad' with no information as 
to whether they were factory bad or not.

(In fact in a test concluded by NASA the factory marked bad blocks did not 
seem to correlate with the blocks having the worst characteristics; I 
think the relevant document is 
http://trs-new.jpl.nasa.gov/dspace/bitstream/2014/40761/1/08-07.pdf but 
I'm not completely sure).

The Flash chip reports an error on a write or erase operation if the 
operation does not complete successfully within certain time constraints, 
which are grounds for marking a block as unusable, i.e. bad, but usually 
the block is worn out long before the on-chip write/erase algorithms 
report errors. Hence a block should really be marked 'bad' while it still 
is 'good', in a sense.

/Ricard
-- 
Ricard Wolf Wanderl?f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
