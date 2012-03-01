From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 1 Mar 2012 11:49:42 +0000
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler framework
In-Reply-To: <20120228192458.GC3617@n2100.arm.linux.org.uk>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
 <20120228192458.GC3617@n2100.arm.linux.org.uk>
Message-ID: <20120301114942.GA2040@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 07:24:59PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 28, 2012 at 06:59:44PM +0000, Dave Martin wrote:
> > #ifdef __ASSEMBLY__
> > stuff
> > for
> > the
> > assembler
> > #else
> > asm("stuff");
> > asm("for");
> > asm("the");
> > asm("assembler");
> 
> That's invalid - nothing guarantees that the compiler won't place
> anything in between these asm statements in the output assembly
> file.

Are you still interested in this series?

I have a workaround for the above now, but it's not pretty -- I seem to
have opened a can of worms here.


We would need something like

#define EXTENDED_ASM(stuff) asm ( ".include \"macros.inc\"\n\t" stuff )
#define EXTENDED_VASM(stuff) asm volatile ( ".include \"macros.inc\"\n\t" stuff )

...where macros.inc includes some logic to protect against multiple
inclusion.

This would avoid problems caused by reordering done by the compiler.

I think this can work, but it may be a step too far...


The above could help fix the incorrect way that asm/unified.h defines
the it* macros (though admittedly that does not seem to have caused
problems for anyone so far...)

Cheers
---Dave
