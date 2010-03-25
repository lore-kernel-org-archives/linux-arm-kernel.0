From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 25 Mar 2010 18:01:00 +0900
Subject: [PATCH v2] PL330: Add PL330 DMA controller driver
In-Reply-To: <20100325054430.165311fa@taxman.wild-wind.fr.eu.org>
References: <4BAAD5BB.7050101@samsung.com>
	<20100325054430.165311fa@taxman.wild-wind.fr.eu.org>
Message-ID: <4BAB264C.2090502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/25/2010 2:44 PM, Marc Zyngier wrote:
> On Thu, 25 Mar 2010 12:17:15 +0900
> Joonyoung Shim <jy0922.shim@samsung.com> wrote:
> 
>> +/* instruction set functions */
>> +static inline int pl330_dmaaddh(u8 *desc_pool_virt, u16 imm, bool ra)
>> +{
>> +	u8 opcode = DMAADDH | (ra << 1);
>> +
>> +	writeb(opcode, desc_pool_virt++);
> 
> desc_pool_virt is a virtual address (from dma_alloc_coherent). In such
> case, write[bwl] seems to be the wrong interface. I suggest the
> following code:
> 
> 	*desc_pool_virt++ = opcode;
> 
>> +	writew(imm, desc_pool_virt);
> 

Right. The write[bwl] is api for address ioremapped of io device. I will
change these.

> Does anything ensure that this won't generate an unaligned access?
> 

PL330 DMA controller fetches variable length instructions that consist of
one to six bytes, so i think unaligned access is no problem.

>> +	return 3;
>> +}
> 
> 	M.
