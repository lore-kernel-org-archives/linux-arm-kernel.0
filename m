From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 8 Jul 2015 22:55:23 +0200 (CEST)
Subject: [RFC PATCH v6 3/3] drivers: nvmem: Add Vybrid OCOTP support
In-Reply-To: <20150708053920.GA4089@Sanchayan-Arch.toradex.int>
References: <cover.1435574288.git.maitysanchayan@gmail.com>
 <9593ca1f925aff20a6671262efd2f45e256ea676.1435574288.git.maitysanchayan@gmail.com>
 <1877493336.206622.1436177794342.JavaMail.open-xchange@oxbsltgw01.schlund.de>
 <20150707051953.GA3712@Sanchayan-Arch.toradex.int>
 <1488361449.258303.1436273347081.JavaMail.open-xchange@oxbsltgw01.schlund.de>
 <20150708053920.GA4089@Sanchayan-Arch.toradex.int>
Message-ID: <24856127.49152.1436388923583.JavaMail.open-xchange@oxbsltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sanchayan,

> maitysanchayan at gmail.com hat am 8. Juli 2015 um 07:39 geschrieben:
>
>
> [...]
> > > >
> > > > Looking at valid_fuse_addr shows me 0x3F as last valid register. So the
> > > > rest
> > > > of the buffer ( 0xD00 - sizeof(valid_fuse_addr) ) in case of raw access
> > > > could be
> > > > uninitializied.
> > >
> > > Sorry I did not exactly get you here. The intention behind using the
> > > valid_fuse_addr
> > > is to allow reading only from valid fuse addresses and avoid reading from
> > > all
> > > other
> > > locations as per the Fuse map address table 35-1.
> >
> > Yes, i got your intention. But from my unterstand the read function should
> > fill
> > up
> > the complete buffer with defined values. My MXS OCOTP driver have the same
> > problem
> > and fill up the invalid registers with zero.
>
> I must admit I had not thought of that. Thats a valid point. I dont know at
> the
> moment however what would be the correct approach here. Perhaps filling
> locations
> other than the valid fuse addresses as per the fuse map table with 0xBADABADA
> is
> the right thing? Anyways that's what is going to be returned if we were to
> read
> a location which is read locked or reserved.

since we are operating in userspace the behavior shouldn't be specific to the
device.
It would be good when all drivers behave the same. But i think it would be much
better
as the nvmem framework take care of it and preinit the buffer with a defined
value.

>
> However since the fuse address and base address mapping is not exactly linear,
> this would require some additional logic than the simple thing I did. 

I defined a regmap_access_table for valid read registers in my case. But i think
in your case
an implementation of the readable_reg callback in the regmap_config would be
more elegant.

You can validate your implementation under /sys/kernel/debug/regmap/

Sorry, i'm a newbie to regmap.

Stefan

> Also OCOTP requires the fuse address to be written. May be using the nvmem
> consumer DT property
> gets something?! Not sure atm.
>
> - Sanchayan.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
