From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 28 Feb 2012 19:44:03 +0000
Subject: [RFC PATCH 0/2] ARM: assembler: Add uniform assembler framework
In-Reply-To: <20120228192458.GC3617@n2100.arm.linux.org.uk>
References: <1330455586-10353-1-git-send-email-dave.martin@linaro.org>
 <20120228192458.GC3617@n2100.arm.linux.org.uk>
Message-ID: <20120228194403.GC2063@linaro.org>
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

Within a function that would be certainly true -- at the top-level, I'm
less sure.  Since there is no sequential code at the top level, only
declarations, it's hard to see why the compiler would ever consider
pasting something in the middle of that block or reordering it.
Without constraints, the compiler simply has no idea what's there
(such asms are implicitly "volatile", though that could be added
for clarity).  You're right that all this may amount to less than a
guarantee, though...


One obvious improvement is to emit a single big asm statement for
each block.  There's still an assumption that the compiler will not
reorder stuff around that block -- unified.h actually already relies
on that prepoerty in order to work (though if we can find a better way,
we could migrate some of the unified.h stuff to use it).


Another option is to .include a separate file.

This is possible, but I hadn't figured out how to autogenerate the
correct dependencies if things are one that way.  Alternatively, the
.included file can be the header file itself, but this relies on
the fact that C preprocessor look like line comments to the assembler,
so it's rather painful.


If there is no other way to be certain that the included content really
does appear at the start of the compilation unit, it would be necessary
to wrap the assembler in a script which explicitly pastes that extra
stuff at the start -- but this doesn't feel like a desirable option,
since it's hard to avoid extra complexity and overheads when doing this.


Any thoughts?

Cheers
---Dave
