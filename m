From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 14 Feb 2012 11:38:44 -0600
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <201202140106.32856.arnd@arndb.de>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F41FCB4EFA@AUSP01VMBX24.collaborationhost.net>
 <201202140106.32856.arnd@arndb.de>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FCB510C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, February 13, 2012 6:07 PM, Arnd Bergmann wrote:
> On Monday 13 February 2012, H Hartley Sweeten wrote:
>>> +#ifdef CONFIG_NEED_MACH_IO_H
>>>  #include <mach/io.h>
>>> +#else
>>> +#define __io(a)              ({ (void)(a); __typesafe_io(0); })
>>> +#define __mem_pci(a) (a)
>>> +#endif
>> 
>> Rob,
>> 
>> I compile and boot tested these patches on EP93xxbut did not check them
>> with sparse.
>> 
>> Most of the mach/io.h headers you remove in Patch 14/15 have the __io
>> macro defined like:
>> 
>> #define __io(a)         __typesafe_io(a)
>> 
>> Does your change above still keep the __io macro typesafe?
>> 
>> They don't appear equivalent to me...
>
> It's not equivalent, but the new version is more correct for most
> platforms because it turns a random pointer dereference into a NULL
> pointer dereference.
>
> If you have none of PCI/ISA/PCMCIA, then inb/outb should never be
> used. Ideally we would undefine __io in that case, which results
> in the inb/outb stuff also not getting defined, but some drivers
> like 8250 serial then fail to build even for systems that only
> use the readl/writel path.

Sorry... I don't quite understand the change here.

__typesafe_io is an inline function in asm/io.h. Most of the mach/io.h
headers simply define __io to be __typesafe_io so they basically get
this:

void __iomem *__io(unsigned long addr)
{
	return (void __iomem *)addr;
}

With the change in Rob's patch they will get this:

void __iomem *__io(unsigned long addr)
{
	(void)addr;
	return (void __iomem *)(0);
}

If you then push these into something like the outb macro you get this:

#define outb(v,p)	({ __iowmb(); __raw_writeb(v,__io(p)); })

Original:

outb(v,p)
{
	__iowmb();
	__raw_writeb(v, (void __iomem*)p);
}

Rob's change:

outb(v,p)
{
	__iowmb();
	__raw_writeb(v, /* not sure what happens to the (void)p */ (void __iomem *)0);
}

To me the original one looks more correct. With Rob's change it looks to me like all
the in/out macros end up reading/writing to address 0.

I don't get what's happening in Rob's change. Could you enlighten me?

Regards,
Hartley
