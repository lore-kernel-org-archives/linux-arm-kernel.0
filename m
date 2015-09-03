From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 3 Sep 2015 21:41:43 +0800
Subject: [PATCH v3 8/9] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <20150903125429.GA12027@sirena.org.uk>
References: <1441101381-1329-1-git-send-email-shawn.lin@rock-chips.com>
 <1441101524-1700-1-git-send-email-shawn.lin@rock-chips.com>
 <20150903125429.GA12027@sirena.org.uk>
Message-ID: <55E84E17.2090409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/3 20:54, Mark Brown wrote:
> On Tue, Sep 01, 2015 at 05:58:44PM +0800, Shawn Lin wrote:
>
>> Generic dma controller on Rockchips' platform cannot support
>> DMAFLUSHP instruction which make dma to flush the req of non-aligned
>> or non-multiple of what we need. That will cause an unrecoverable
>> dma bus error. The saftest way is to set dma max burst to 1.
>
> If this is a quirk of the DMA controller why is it being fixed with a
> property specific to the SPI controller?  Can't the DMA controller just
> override the burst size?
>

Cool...that's a good question. Actually DMA controller can't do that 
since block peripheral controller(e.g sd/emmc, they always access data 
by block-512Bytes.) can't meet the case. So It's hard for dma controller 
know who is the caller, and what should be done.

The only thing dma controller can do is avoid to execute DMAFLUSHP on 
its own. But how about peripheral controller trigger non-multiple 
access? So that's what I mentioned on covery letter that we should do 
"broken things" for both dma controller and some peripherals.

>> +#define ROCKCHIP_SPI_BORKEN_BURST_LEN (1<<0) /* broken burst len*/
>
> This is misspelt.

Woops, sorry for the bit. Thanks, Mark.

>


-- 
Best Regards
Shawn Lin
