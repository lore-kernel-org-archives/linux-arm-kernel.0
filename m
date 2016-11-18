From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Fri, 18 Nov 2016 19:12:35 +0800
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <2436881.9RqUVYxmDf@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478806353.7430.137.camel@kernel.crashing.org>
 <5825984B.3030303@hisilicon.com> <2436881.9RqUVYxmDf@wuerfel>
Message-ID: <582EE223.4090605@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd,


On 2016/11/18 17:20, Arnd Bergmann wrote:
> On Friday, November 11, 2016 6:07:07 PM CET zhichang.yuan wrote:
>>
>> I have similar idea as your PPC MMIO.
>>
>> We notice the prototype of {in/out()} is something like that:
>>
>> static inline u8 inb(unsigned long addr)
>> static inline void outb(u8 value, unsigned long addr)
>>
>> The type of parameter 'addr' is unsigned long. For I/O space, it is big enough.
>> So, could you divide this 'addr' into several bit segments? The top 8 bits is
>> defined as bus index. For normal direct IO, the bus index is 0. For those bus
>> device which need indirectIO or some special I/O accessors, when these devices
>> are initializing, can request to allocate an unique ID to them, and register
>> their own accessors to the entry which is corresponding to the ID.
> 
> Ah, have you looked at the IA64 code? It does exactly this.
> For ARM64 we decided to use the same basic approach as powerpc with
> a single range of virtual memory for mapping it as that somewhat
> simplified all cases we knew about at the time.

Yes. I spent some time to trace how to work on PPC. But the code is a bit long,
I am not clear on how the indirectIO there was supported.

I noticed there are CONFIG_PPC_INDIRECT_PIO and CONFIG_PPC_INDIRECT_MMIO on PPC.
It seems that only CONFIG_PPC_INDIRECT_MMIO applied some MSB to store the bus
tokens which are used to get iowa_busses[] for specific operation helpers.
I can not find how CONFIG_PPC_INDIRECT_PIO support multiple ISA domains. It
seems only Opal-lpc.c adopt this INDIRECT_PIO method.

Although CONFIG_PPC_INDIRECT_MMIO is for MMIO, seems not suitable for ISA/LPC
I/O. But this idea is helpful.

what else did I miss??

> 
>> In this way, we can support multiple domains, I think.
>> But I am not sure whether it is feasible, for example, are there some
>> architectures/platforms had populated the top 8 bits? Do we need to request IO
>> region from ioport_resource for those devices?  etc...
> 
> On a 64-bit architecture, the top 32 bits of the port number are
> definitely free to use for this, and 8 bits are probably sufficient.
> 
> Even on 32 bit architectures, I can't see why we'd ever need more than
> 16 bits worth of addressing within a domain, so using 8 bit domain
> and 16 bit address leaves 8 or 40 unused bits.

Yes. 8 bits are enough.
But the maximal PIO on some architectures are defined as ~0 or -1. There is no
any bare space left. Probably we can not ensure the upper 8 bits available.


Thanks,
Zhichang


> 
> 	Arnd
> 
> .
> 
