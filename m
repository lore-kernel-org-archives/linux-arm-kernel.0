From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 29 Feb 2012 19:28:19 +0000
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler framework
In-Reply-To: <20120228194403.GC2063@linaro.org>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
 <20120228192458.GC3617@n2100.arm.linux.org.uk>
 <20120228194403.GC2063@linaro.org>
Message-ID: <20120229192819.GD2077@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 07:44:03PM +0000, Dave Martin wrote:
> On Tue, Feb 28, 2012 at 07:24:59PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 28, 2012 at 06:59:44PM +0000, Dave Martin wrote:
> > > #ifdef __ASSEMBLY__
> > > stuff
> > > for
> > > the
> > > assembler
> > > #else
> > > asm("stuff");
> > > asm("for");
> > > asm("the");
> > > asm("assembler");
> > 
> > That's invalid - nothing guarantees that the compiler won't place
> > anything in between these asm statements in the output assembly
> > file.
> 
> Within a function that would be certainly true -- at the top-level, I'm
> less sure.  Since there is no sequential code at the top level, only
> declarations, it's hard to see why the compiler would ever consider
> pasting something in the middle of that block or reordering it.
> Without constraints, the compiler simply has no idea what's there
> (such asms are implicitly "volatile", though that could be added
> for clarity).  You're right that all this may amount to less than a
> guarantee, though...

A quick follow up on this -- having chatted to tools guys, it sounds
like you're quite right on this: it is indeed unsafe, without
-fno-toplevel-reorder (which would impair some optimisations)

Of course, this also means that unified.h is unsafe for the same
reasons -- there is no guarantee that the big asm block containing
all the IT macro definitions will precede compiler-generated code in
the input to the assembler (and, presumably, inline asms embedded in it)
in the compiler output...


Cheers
---Dave
