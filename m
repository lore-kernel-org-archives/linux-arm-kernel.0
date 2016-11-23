From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 23 Nov 2016 17:02:11 +0100
Subject: [PATCH net-next 1/4] net: mvneta: Convert to be 64 bits compatible
In-Reply-To: <87mvgqmjiy.fsf@free-electrons.com>
References: <20161122164844.19566-1-gregory.clement@free-electrons.com>
 <2948812.F3se4ieqO6@wuerfel> <20161123175341.4777595f@xhacker>
 <9432400.S1OrxC027t@wuerfel> <87mvgqmjiy.fsf@free-electrons.com>
Message-ID: <CAPv3WKf0a63qQT+xwXfUatbgLFF58e6L8J10VtBOUTam+kUcjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

2016-11-23 14:07 GMT+01:00 Gregory CLEMENT <gregory.clement@free-electrons.com>:
> Hi Jisheng, Arnd,
>
>
> Thanks for your feedback.
>
>
>  On mer., nov. 23 2016, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Wednesday, November 23, 2016 5:53:41 PM CET Jisheng Zhang wrote:
>>> On Tue, 22 Nov 2016 22:04:12 +0100 Arnd Bergmann wrote:
>>>
>>> > On Tuesday, November 22, 2016 5:48:41 PM CET Gregory CLEMENT wrote:
>>> > > +#ifdef CONFIG_64BIT
>>> > > +       void *data_tmp;
>>> > > +
>>> > > +       /* In Neta HW only 32 bits data is supported, so in order to
>>> > > +        * obtain whole 64 bits address from RX descriptor, we store
>>> > > +        * the upper 32 bits when allocating buffer, and put it back
>>> > > +        * when using buffer cookie for accessing packet in memory.
>>> > > +        * Frags should be allocated from single 'memory' region,
>>> > > +        * hence common upper address half should be sufficient.
>>> > > +        */
>>> > > +       data_tmp = mvneta_frag_alloc(pp->frag_size);
>>> > > +       if (data_tmp) {
>>> > > +               pp->data_high = (u64)upper_32_bits((u64)data_tmp) << 32;
>>> > > +               mvneta_frag_free(pp->frag_size, data_tmp);
>>> > > +       }
>>> > >
>>> >
>>> > How does this work when the region spans a n*4GB address boundary?
>>>
>>> indeed. We also make use of this driver on 64bit platforms. We use
>>> different solution to make the driver 64bit safe.
>>>
>>> solA: make use of the reserved field in the mvneta_rx_desc, such
>>> as reserved2 etc. Yes, the field is marked as "for future use, PnC", but
>>> now it's not used at all. This is one possible solution however.
>>
>> Right, this sounds like the most straightforward choice.
>
> The PnC (which stands for Parsing and Classification) is not used yet
> indeed but this field will be needed when we will enable it. It is
> something we want to do but it is not planned in a near future. However
> from the datasheets I have it seems only present on the Armada XP. It is
> not mentioned on datasheets for the Armada 38x or the Armada 3700.
>

It is not mentioned in A38x spec, but this SoC has exactly the same
PnC as Armada XP (they differ only with used SRAM details). I wouldn't
be surprised if it was supported on A3700 as well.

> That would mean it was safe to use on of this field in 64-bits mode on
> the Armada 3700.
>
> So I am going to take this approach.
>

I think for now it's safe and is much easier than handling extra
software ring for virtual addresses.

Best regards,
Marcin
