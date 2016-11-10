From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Thu, 10 Nov 2016 16:33:10 +0800
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <1478647002.7430.69.camel@kernel.crashing.org>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <20161108120323.GC15297@leverpostej>
 <1478647002.7430.69.camel@kernel.crashing.org>
Message-ID: <582430C6.60307@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Ben,


On 2016/11/9 7:16, Benjamin Herrenschmidt wrote:
> On Tue, 2016-11-08 at 12:03 +0000, Mark Rutland wrote:
>> On Tue, Nov 08, 2016 at 11:47:07AM +0800, zhichang.yuan wrote:
>>>
>>> For arm64, there is no I/O space as other architectural platforms, such as
>>> X86. Most I/O accesses are achieved based on MMIO. But for some arm64 SoCs,
>>> such as Hip06, when accessing some legacy ISA devices connected to LPC, those
>>> known port addresses are used to control the corresponding target devices, for
>>> example, 0x2f8 is for UART, 0xe4 is for ipmi-bt. It is different from the
>>> normal MMIO mode in using.
>>
>> This has nothing to do with arm64. Hardware with this kind of indirect
>> bus access could be integrated with a variety of CPU architectures. It
>> simply hasn't been, yet.
> 
> On some ppc's we also use similar indirect access methods for IOs. We
> have a generic infrastructure for re-routing some memory or IO regions
> to hooks.
> 
I am interested on the generic infrastructure on PPC.
Could you point out where those drivers are?
want to take a look..

Thanks,
Zhichang

> On POWER8, our PCIe doesn't do IO at all, but we have an LPC bus behind
> firmware calls ;-) We use that infrastructure to plumb in the LPC bus.
> 
>>> To drive these devices, this patch introduces a method named indirect-IO.
>>> In this method the in/out pair in arch/arm64/include/asm/io.h will be
>>> redefined. When upper layer drivers call in/out with those known legacy port
>>> addresses to access the peripherals, the hooking functions corrresponding to
>>> those target peripherals will be called. Through this way, those upper layer
>>> drivers which depend on in/out can run on Hip06 without any changes.
>>
>> As above, this has nothing to do with arm64, and as such, should live in
>> generic code, exactly as we would do if we had higher-level ISA
>> accessor ops.
>>
>> Regardless, given the multi-instance case, I don't think this is
>> sufficient in general (and I think we need higher-level ISA accessors
>> to handle the indirection).
> 
> Multi-instance with IO is tricky to do generically because archs already
> have all sort of hacks to deal with the fact that inb/outb don't require
> an explicit ioremap, so an IO resource can take all sort of shape depending
> on the arch.
> 
> Overall it boils down to applying some kind of per-instance "offset" to
> the IO port number though.
> 
