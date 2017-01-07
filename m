From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Sat, 7 Jan 2017 23:32:27 +0530
Subject: [PATCH WIP 4/4] ARM: remove compile time vector base for CP15 case
In-Reply-To: <20170107173832.GN14217@n2100.armlinux.org.uk>
References: <20170107171339.GA5044@afzalpc>
 <20170107172228.6451-1-afzal.mohd.ma@gmail.com>
 <20170107173832.GN14217@n2100.armlinux.org.uk>
Message-ID: <20170107180227.GA8130@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 07, 2017 at 05:38:32PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 07, 2017 at 10:52:28PM +0530, afzal mohammed wrote:

> > TODO:
> > Kill off VECTORS_BASE completely - this would require to handle MMU
> >  case as well as ARM_MPU scenario dynamically.

> Why do you think MMU doesn't already handle it?

i meant here w.r.t displaying vector base address in
arch/arm/mm/init.c, i.e. dynamically get it based on Hivecs setting as
either 0xffff0000 or 0x00000000
> 
> >  config VECTORS_BASE
> >  	hex
> > -	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
> > -	default DRAM_BASE if REMAP_VECTORS_TO_RAM
> > +	default 0xffff0000 if MMU
> >  	default 0x00000000
> 
> When MMU=y, the resulting VECTORS_BASE is always 0xffff0000.  The only
> case where this ends up zero after your change is when MMU=n.

> The MMU case does have to cater for CPUs wanting vectors at 0xffff0000
> and at 0x00000000, and this is handled via the page tables - but this
> has nothing to do with CONFIG_VECTORS_BASE.  CONFIG_VECTORS_BASE
> exists primarily for noMMU.

i had thought that for MMU case if Hivecs is not enabled,
CONFIG_VECTOR_BASE has to be considered as 0x00000000 at least for the
purpose of displaying exception base address.

One thing i have not yet understood is how CPU can take exception with
it base address as 0x00000000 (for Hivecs not enabled case) virtual
address as it is below Kernel memory map.

> For the Berlin and mm/dump code, we could very easily just have a
> #define VECTORS_BASE 0xffff0000 in a header file and drop the CONFIG_
> prefix.

Okay, thanks for the tip.

Regards
afzal
