From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 08 Nov 2016 16:53:40 +0100
Subject: [PATCH RFC 2/7] ARM: S3C64XX: Add DMA slave maps for PL080 devices
In-Reply-To: <20161108145534.GE1575@localhost.localdomain>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-4-git-send-email-s.nawrocki@samsung.com>
 <20161108144445.GD1575@localhost.localdomain>
 <CGME20161108145620epcas2p4b8e2ec5ffdd4bf04ab3bf0728b46e3f2@epcas2p4.samsung.com>
 <20161108145534.GE1575@localhost.localdomain>
Message-ID: <f53d533d-163f-31f3-4efb-0e39d201589d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2016 03:55 PM, Charles Keepax wrote:
>>> diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
>>> > > index 89c5a62..8c88680 100644
>>> > > --- a/arch/arm/mach-s3c64xx/pl080.c
>>> > > +++ b/arch/arm/mach-s3c64xx/pl080.c
>> > <snip>
>>> > > @@ -134,6 +153,8 @@ struct pl08x_platform_data s3c64xx_dma0_plat_data = {
>>> > >  	.put_xfer_signal = pl08x_put_xfer_signal,
>>> > >  	.slave_channels = s3c64xx_dma0_info,
>>> > >  	.num_slave_channels = ARRAY_SIZE(s3c64xx_dma0_info),
>>> > > +	.slave_map = s3c64xx_dma0_slave_map,
>>> > > +	.slavecnt = ARRAY_SIZE(s3c64xx_dma0_slave_map),
>>> > >  };
>> > 
>> > Here we add a .slavecnt but the pl08x_platform_data structure doesn't
>> > contain that field. I can't see it on the branch you linked in
>> > the cover letter either, is it added by a patch on another branch
>> > I am missing?
>> > 
> Ah I think I see it should be .slave_map_len here.

Yeah, sorry, I fixed it after getting report from the kbuild test
but have forgotten to push changes to the git tree.

I pushed now to branch for-v4.10/dma/pl080-s3c64xx-v2 with this
issue fixed and added initialization of the filer function.

-------------------8<-------------------------
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 939a7c3..d441c4b 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2307,6 +2307,10 @@ static int pl08x_probe(struct amba_device *adev, const
struct amba_id *id)
                        ret = -EINVAL;
                        goto out_no_platdata;
                }
+       } else {
+               pl08x->slave.filter.map = pl08x->pd->slave_map;
+               pl08x->slave.filter.mapcnt = pl08x->pd->slave_map_len;
+               pl08x->slave.filter.fn = pl08x_filter_id;
        }
-------------------8<-------------------------

--
Thanks,
Sylwester
