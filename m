From: svenkatr@ti.com (S, Venkatraman)
Date: Fri, 21 Sep 2012 23:03:42 +0530
Subject: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the EDMA
 DMAC
In-Reply-To: <20120921171840.GB10409@arwen.pp.htv.fi>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-9-git-send-email-mporter@ti.com>
 <CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
 <CANfBPZ-h7MD4X_NRYfwOmMnEyOKy0bTNNLNRmdbef2pe=2aHyg@mail.gmail.com>
 <20120921171840.GB10409@arwen.pp.htv.fi>
Message-ID: <CANfBPZ-q68qqpF0TvrY9HXH4mOjVE2j1T7+J0-aKKpg2ZaR+4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 10:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Sep 21, 2012 at 10:47:30PM +0530, S, Venkatraman wrote:
>> On Fri, Sep 21, 2012 at 10:45 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>> > On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter@ti.com> wrote:
>> >> The EDMA DMAC has a hardware limitation that prevents supporting
>> >> scatter gather lists with any number of segments. Since the EDMA
>> >> DMA Engine driver sets the maximum segments to 16, we do the
>> >> same.
>> >>
>> >> Note: this can be removed once the DMA Engine API supports an
>> >> API to query the DMAC's segment limitations.
>> >>
>> >
>> > I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
>> > suggests. Why don't we have a max_segs property, which when explicitly specified
>> > in DT, will override the default ?
>>
>> If you are adventurous, this can be a generic mmc DT binding instead
>> of restricting it to OMAP.
>
> I say if it's a limitation in the DMAC, then DMAC's driver should handle
> it, no ? Meaning that in this case you would copy from one multi-segment
> sg into a one-segment sg and when transfer is complete, before calling
> user's callback, copy data the other way around (?)
>

Right ! So even if the property is defined for MMC, Matt will end up coding the
limitation into every peripheral driver that uses EMAC, which doesn't scale.
Your solution is better.
