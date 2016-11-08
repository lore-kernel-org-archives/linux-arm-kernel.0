From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 08 Nov 2016 17:02:43 +0100
Subject: [PATCH RFC 0/7] DMA: S3C64XX: Conversion to the new channel
 request API
In-Reply-To: <20161108153949.GF1575@localhost.localdomain>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-2-git-send-email-s.nawrocki@samsung.com>
 <CGME20161108154037epcas4p34b3004ca2ffb63275be42edec4c91f6e@epcas4p3.samsung.com>
 <20161108153949.GF1575@localhost.localdomain>
Message-ID: <fbb81b22-48f7-5948-a48e-2375e2414efb@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2016 04:39 PM, Charles Keepax wrote:
> Hmm... fixing the bug I mentioned in my other email this still
> seems to cause some problems with my SPI on Cragganmore:
> 
> [  200.210213] wm0010 spi0.0: I/O Error: rx-1 tx-1 res:rx-f tx-f len-2632
> [  200.211275] wm0010 spi0.0: SPI transfer failed: -5
> 
> I am still looking into it, without your patches work the wm0010
> comes up. A few other small things seem to have been broken in
> mainline since last time I fired up this board as well which is
> slowing me down a little (network seems to have stopped coming
> up and one of the regulators on the SD card is spamming me with
> warnings).

Thanks for giving it a try.  Is it any better with a change as below?

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d5c75c8..d441c4b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2310,6 +2310,7 @@ static int pl08x_probe(struct amba_device *adev, const
struct amba_id *id)
        } else {
                pl08x->slave.filter.map = pl08x->pd->slave_map;
                pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
+               pl08x->slave.filter.fn = pl08x_filter_id;
        }
