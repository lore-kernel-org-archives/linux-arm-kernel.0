From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 11:18:00 -0700
Subject: [PATCH 2/9] arm64: Fix INVALID_HWID definition
In-Reply-To: <20140826155715.GH16482@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <6f84108ac880ef48548208738cbb169fba2fa51a.1408736066.git.geoff@infradead.org>
 <20140826155715.GH16482@arm.com>
Message-ID: <1409077080.11425.22.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, 2014-08-26 at 16:57 +0100, Catalin Marinas wrote:
> On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > Change the preprocessor macro INVALID_HWID definition from ULONG_MAX to (~0)
> > to allow INVALID_HWID to be used within assembly source files.
> > 
> > --- a/arch/arm64/include/asm/cputype.h
> > +++ b/arch/arm64/include/asm/cputype.h
> > @@ -16,7 +16,7 @@
> >  #ifndef __ASM_CPUTYPE_H
> >  #define __ASM_CPUTYPE_H
> >  
> > -#define INVALID_HWID		ULONG_MAX
> > +#define INVALID_HWID		UL(~0)
> 
> Does it actually expand to ULONG_MAX? ~0 is an int.

It seems to be OK, in C:

volatile unsigned long secondary_holding_pen_release = INVALID_HWID;

Disassembly of section .data:

0000000000000000 <secondary_holding_pen_release>:
   0:   ffffffff        .word   0xffffffff
   4:   ffffffff        .word   0xffffffff

In .S:

        mov     x10, INVALID_HWID               // clear secondary_holding_pen_release
 2b0:   9280000a        mov     x10, #0xffffffffffffffff        // #-1

-Geoff
