From: robherring2@gmail.com (Rob Herring)
Date: Mon, 05 Mar 2012 22:07:37 -0600
Subject: [PATCH v3 02/30] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1203051415150.31242@xanadu.home>
 <201203052013.26688.arnd@arndb.de>
 <alpine.LFD.2.02.1203051545200.31242@xanadu.home>
Message-ID: <4F558D89.7030905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2012 03:11 PM, Nicolas Pitre wrote:
> On Mon, 5 Mar 2012, Arnd Bergmann wrote:
> 
>> On Monday 05 March 2012, Nicolas Pitre wrote:
>>> Given that the majority of existing platforms don't need the 
>>> indirection, should we make this indirection conditional on 
>>> CONFIG_NEED_IOREMAP_HOOK and let those who need it select it?  Or maybe 
>>> this isn't performance critical and we just don't care?  In any case I'd 
>>> like to see such reasoning captured in the commit log.
>>
>> It's certainly not performance critical, but there may be some space overhead
>> in the .text section of the kernel that we could avoid by adding another
>> indirection.
> 
> Of course the size issue can be mitigated significantly by replacing:
> 
> extern void __iomem * (*arch_ioremap)(unsigned long, size_t, unsigned int);
> extern void (*arch_iounmap)(volatile void __iomem *);
> 
> #define __arch_ioremap                 arch_ioremap
> #define __arch_iounmap                 arch_iounmap
> 
> by:
> 
> extern void __iomem * (*arch_ioremap)(unsigned long, size_t, unsigned int);
> extern void (*arch_iounmap)(volatile void __iomem *);
> 
> extern void __iomem * __arch_ioremap(unsigned long, size_t, unsigned int);
> extern void __arch_iounmap(volatile void __iomem *);
> 
> and out of line:
> 
> void __iomem *__arch_ioremap(unsigned long phys_addr, size_t size, unsigned int mtype)
> {
> 	return arch_ioremap(phys_addr, size, mtype);
> }
> 
> void __arch_iounmap(volatile void __iomem *io_addr)
> {
> 	arch_iounmap(io_addr);
> }

This doesn't quite work if we keep the compile time option, but I came
up with something that accomplishes the same thing.

There's not much point in converting ixp4xx and ebsa110 to runtime hooks
as they still have other io.h needs.

Rob
