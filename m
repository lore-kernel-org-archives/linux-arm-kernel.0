From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 8 Sep 2011 10:18:32 +0800
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
Message-ID: <CAGsJ_4yv-35P244TaVS8oodis9P8g0kbTOvj9bgMC2ygQJFU0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/8 Koul, Vinod <vinod.koul@intel.com>:
> On Thu, 2011-09-08 at 00:46 +0800, Barry Song wrote:
>> Hi Vinod,
>> thanks for your quick feedback.
>>
>> 2011/9/8 Koul, Vinod <vinod.koul@intel.com>:
>> > On Tue, 2011-09-06 at 22:41 -0700, Barry Song wrote:
>> >> From: Rongjun Ying <rongjun.ying@csr.com>
>> >
>> >> +config SIRF_DMA
>> >> + ? ? tristate "CSR SiRFprimaII DMA support"
>> >> + ? ? depends on ARCH_PRIMA2
>> >> + ? ? select DMA_ENGINE
>> >> + ? ? help
>> >> + ? ? ? Enable support for the CSR SiRFprimaII DMA engine.
>> > How different is it from the other primacell based DMA drivers, and why
>> > wouldn't it make sense to use/modify one of them?
>>
>> it is much different with primacell based DMA like pl080, pl330.
>> prima2 has a self-defined DMAC IP. basically it is a 2D mode dma with
>> two scales X and Y and direct way to start and stop DMA.
>> every channel has fixed function to serve only one perpheral. so you
>> find we have a filter id.
> okay, what do you mean by 2D mode? Is it similar to what TI folks, Linus
> W and Jassi Brar posted RFC's on?

In SiRFprimaII 2-D DMA, the system memory space is interpreted
as a 2-D layout instead of a linear 1-D layout. More specifically, the
system memory can be considered as
multiple data lines. The length of the data line is determined by the
user-selected DMA_WIDTH register.
The user can specify a data window that the user wants to access using
four parameters:
? Start address
? X length
? Y length
? Width

The idea of a 2-D DMA is shown in figure 2d-dma.png attached.

If you specifies the Y length as 0 or the X length equals to the DMA
width, then this 2-D DMA reduces to
1-D. If the user configures the X length greater than the DMA width,
then the extra data is wrapped around
to the next data line, this may corrupt the DMA transfer for
multiple-line 2-D DMA. If this is a 1-D DMA, then
there is no issue. The attached diagram 2d-dma2.png shows the
wrap-around of the extra data in case the X length
greater than DMA width.

Thanks
barry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2d-dma.PNG
Type: image/png
Size: 16675 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110908/de9ea7b0/attachment-0002.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2d-dma2.PNG
Type: image/png
Size: 9836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110908/de9ea7b0/attachment-0003.png>
