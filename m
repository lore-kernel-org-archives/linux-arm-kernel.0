From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 17:26:12 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130913041208.GD3051@gmail.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
 <1378999322.4210.95.camel@i7.infradead.org>
 <20130913041208.GD3051@gmail.com>
Message-ID: <1379003172.4210.114.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-09-13 at 00:12 -0400, Huang Shijie wrote:
> I will send you the datasheet tomorrow.

Thanks. Although according to the date header on your email, it is
*already* tomorrow. Any chance of fixing your clock, please?

> Mark and you want to create the LUT instruction sequence at the runtime,
> But there is some disadvantage if we do so:
>   [1] low efficiency: 
>       If you want to change the LUT regitster, you should unlock the LUT
>       register, and change the LUT regitsters, and lock the LUT
>       regitsters again.

Although there aren't *that* many operations we perform, so you'd quite
quickly find yourself using things which are *already* programmed into
the LUT instead of having to re-program them again, surely?

>   [2] we may can not create all the LUT instruction sequence at the
>       runtime. For example, the buffer program(OPCODE_PP):
>       the m25p80_write() may write 256bytes at a time, but the Quadspi
>       controller only has a 64-byte TX-FIFO, so the controller should
>       write a 64bytes firstly, then sends to the NOR with a read-status
>       command. Do you want to create a read-status LUT instruction 
>       sequence at run time? This is not good solution, we should
>       pre-populate the read-status LUT information.

I'm not entirely sure I understand this. What *exactly* happens "on the
wire" in this case? Do you really send an OPCODE_RDSR (0x05) byte on the
wire somehow, when you're supposed to be in the middle of sending the
page data to the chip? How does the chip handle that?

>   [3] We may can not create the LUT instruction sequence at the runtime,
>       since we can not get enough information from the spi_transfer{}.
>       A whole LUT instruction sequence may needs the following info:
>        1.) spi command.
>        2.) lines info: single line, dual lines, quad lines.
>        3.) Address width: 3 bytes address or 4 bytes address.
>        4.) instruction type: Read or write or other. 
>        5.) length info: how many bytes for this transaction .
>        6.) dummy info: how many dummy is needed for this transaction.
> 
>       We can not get the dummy info from the spi_transfer{} 

Again, what does that actually *mean*, on the wire?

I thought SPI was just 'send some bytes, fetch some bytes'. Why is the
controller doing anything other than that?

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/1198ff3f/attachment.bin>
