From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Aug 2016 17:39:29 +0100
Subject: [PATCH 4/7] arm64: Disable TTBR0_EL1 during normal kernel
 execution
In-Reply-To: <20160815111857.GA2060@svinekod>
References: <1471015666-23125-1-git-send-email-catalin.marinas@arm.com>
 <1471015666-23125-5-git-send-email-catalin.marinas@arm.com>
 <20160815111857.GA2060@svinekod>
Message-ID: <20160815163929.GI22320@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 12:18:58PM +0100, Mark Rutland wrote:
> On Fri, Aug 12, 2016 at 04:27:43PM +0100, Catalin Marinas wrote:
> > diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> > index b5c3933ed441..9283e6b247f9 100644
> > --- a/arch/arm64/include/uapi/asm/ptrace.h
> > +++ b/arch/arm64/include/uapi/asm/ptrace.h
> > @@ -52,6 +52,8 @@
> >  #define PSR_Z_BIT	0x40000000
> >  #define PSR_N_BIT	0x80000000
> >  
> > +#define _PSR_PAN_BIT	22
> 
> Given this is under uapi/, shouldn't we lose the leading underscore to align
> with other PSR_* definitions?
> 
> Or should we not have this under uapi/?

I moved it to the non-uapi ptrace.h.

> [...]
> 
> > +	mrs	lr, ttbr0_el1
> > +	tst	lr, #0xffff << 48		// Check for the reserved ASID
> 
> Did we not have a regular register spare here? Not a problem, but using the lr
> here stands out as unusual.

LR is a general purpose register, we just have an alias for it. I've
replaced it with x21 so that it doesn't stand out.

-- 
Catalin
