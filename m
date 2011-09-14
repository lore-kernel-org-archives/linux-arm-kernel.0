From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 14 Sep 2011 17:49:20 +0800
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CABb+yY36xmq3mKpWOn+ZZuvPehRkSGe720WrQtMie2C-udgZyQ@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
	<CABb+yY1=P=D3GFFxMOUM0a2yWCiAHNqwVU0a--t+pJnUhqKHKA@mail.gmail.com>
	<CABb+yY3F+DMn2SxeO0chjpiMBkgLvSK5EVYMdhQsfQoZNZ4_7Q@mail.gmail.com>
	<CAGsJ_4x0isAUgmTkRavUC6p3K38ho70A+q8Pp2cMLnxbgMEL7Q@mail.gmail.com>
	<CABb+yY36xmq3mKpWOn+ZZuvPehRkSGe720WrQtMie2C-udgZyQ@mail.gmail.com>
Message-ID: <CAGsJ_4wNFjcvrF2=HbD3xAwpySVaHoB0hMfqNXcYncuZNMca6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/14 Jassi Brar <jassisinghbrar@gmail.com>:
> On Wed, Sep 14, 2011 at 12:16 PM, Barry Song <21cnbao@gmail.com> wrote:
>
>>> Anyways, every case can be easily expressed using the generic api
>>> I proposed. See 'struct xfer_template' in https://lkml.org/lkml/2011/8/12/128
>>>
>>> Roughly speaking, the following should be done...
>>> Client driver :-
>>> **************
>>> For a 'Rectangular' transfer (2d-dma.PNG) :-
>>> ? ? ?xfer_template.numf = Ylen; ?/* height of rectangle */
>>> ? ? ?xfer_template.frame_size = 1;
>>> ? ? ?xfer_template.sgl[0].size = Xlen; /* width of rectangle */
>>> ? ? ?xfer_template.sgl[0].icg = start_addr_Y(n) - end_addr_Y(n-1);
>>
>> For prima2:
>>
>> xfer_template.numf = ylen + 1
>> xfer_template.frame_size = 1;
>> xfer_template.sgl[0].size = xlen;
>> xfer_template.sgl[0].icg = dma_width - xlen;
>>
> All is same as I suggested except for 'numf'.
> You might want to keep 'numf' same as well. Because the client
> driver shouldn't need to know that the DMAC's register expect "+1" value.
> Remember the client is supposed to be reusable over other DMACs as well.
> So, rather in the DMAC driver, please do
> ? ?schan->ylen = xfer_template.numf + 1;

clients should not know any thing like xlen, ylen, dma_width, which
are all dmac driver cares. clients only need to know the generic xfer.
here i am just listing the relationship between client and dmac driver
to get the confirmation from you  and make sure i haven't
misunderstood your api :-)

>
>
>>> DMAC driver :-
>>> ***************
>>> ? ? ?if (xfer_template.frame_size == 1) {
>>> ? ? ? ? ? /* rectangle */
>>> ? ? ? ? ? schan->xlen = xfer_template.sgl[0].size;
>>> ? ? ? ? ? schan->width = schan->xlen + xfer_template.sgl[0].icg;
>>> ? ? ?} else if (xfer_template.frame_size == 2 &&
>>> ? ? ? ? ? ? ? ? ?xfer_template.numf == 1 &&
>>> ? ? ? ? ? ? ? ? ?xfer_template.sgl[1].size == xfer_template.sgl[0].icg){
>>> ? ? ? ? ? /* a line and some */
>>> ? ? ? ? ? schan->xlen = xfer_template.sgl[0].size + ?xfer_template.sgl[1].size.
>>> ? ? ? ? ? schan->width = xfer_template.sgl[0].size;
>>> ? ? ?} else {
>>> ? ? ? ? ? /* _Hardware_ doesn't support the transfer as such. *
>>> ? ? ? ? ? return -EINVAL;
>>> ? ? ?}
>>> ? ? ?schan->ylen = xfer_template.numf /* -1? */;
>>>
>>
>> For prima2:
>> xfer_template.frame_size is always 1, then
>> schan->xlen = xfer_template.sgl[0].size;
>> schan->width = schan->xlen + xfer_template.sgl[0].icg;
>>
> Ok, you don't need the 'else if' clause because as you said
> {xlen > width} is not an option.
> But you do need the other two checks, so that the DMAC driver
> cleanly rejects any interleaved-format that it doesn't support.
>
> Point being, the clients and DMAC drivers are supposed to be
> very 'promiscuous' - any Client could be 'riding' any DMAC ;)

yes. of course.

>

-barry
