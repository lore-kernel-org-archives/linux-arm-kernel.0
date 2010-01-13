From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Jan 2010 14:16:49 +0100
Subject: DesignWare DMA Controller on at91sam9263
In-Reply-To: <20100113132044.01a7f15c@hskinnemoen-d830>
References: <719c3e781001130408u1a126c2es7c7b6a047aa8c15b@mail.gmail.com>
	<20100113132044.01a7f15c@hskinnemoen-d830>
Message-ID: <4B4DC7C1.5010803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2010 13:20, Haavard Skinnemoen :
> Hi,
> 
> The DMA Controller is very configurable, and I am not familiar with how
> it is configured on the SAM9 devices. I'm Cc'ing one of our SAM9 gurus;
> hopefully he can help you.
> 
> Haavard
> 
> (fullquoting so that Nicolas can see your questions)
> 
> Valentin Sitdikov <v.sitdikov@gmail.com> wrote:
>> Hello Haavard.
>>
>> Could you please comment something on my problem?
>>
>> Currently i am working on getting at91sam9263 dmac working under demaenige
>> framework.
>> So I have investigating that it is a kind of copy Synopsys DesignWare DMA
>> Controller which is used in AVR32.
>> But there is at least one difference:
>> AVR32 BLOCK_TS is 11 bit wide but at91sam9263 BLOCK_TS is 5 bit size
>> So your driver is working on at91sam9263 taking in to account this
>> difference.
>>
>> As you can imagine to have such a small dma transaction is not quite
>> convenient.
>> May be you can recommend something to overcome 5 bit restriction?

As you noted, AT91SAM9263 has significantly reduced block size for
transfers, this lead into max transfer size of 124B in a single block
transfer:
ref. DMAC_CTLxL field SRC_TR_WIDTH (32 bits)
DMAC_CTLxH with BLOCK_TS (5 bits)  , Max value = 31

Single Block Size = Max_Block_TS (31) * Max_TR_Width (4) = 124B

Unless you loop on a reduced set of addresses, we usually consider it as
not so useful (you finally find it less resource consuming to retrieve
data using CPU power).

I have no workaround for this.
A dirty way to do mem2mem transfer is to use a peripheral in loopback
mode with PDC (SPI loopback for instance). But I suppose you will get
quite poor performance)...

>> There is also bit field in config register which is called MAX_ABRST the
>> meaning of
>> which is not quite clear. It is 10 bits long,
>> So why it 10 bits long if BLOCK_TS only 5 bits long?
>> What real meaning has it ?

It is related to the burst length that the AHB master can request on the
internal bus (here the AHB master is the DMA controller itself): in
short, in case of internal bus availability, the total amount of data
that this master can transfer on the internal bus without stopping burst.
It has nothing to do with the internal possibilities of the DMA controller.

Best regards,
-- 
Nicolas Ferre
