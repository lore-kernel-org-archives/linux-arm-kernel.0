From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 26 Sep 2014 12:53:26 +0100
Subject: Kprobes build failure
In-Reply-To: <1411725443.1529.10.camel@linaro1.home>
References: <20140925233720.GG5182@n2100.arm.linux.org.uk>
 <1411725443.1529.10.camel@linaro1.home>
Message-ID: <1411732406.1529.20.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-26 at 10:57 +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2014-09-26 at 00:37 +0100, Russell King - ARM Linux wrote:
> > So, Olof's kbuild found this while building my rc5 based for-next tree:
> > 
> >         arm.allmodconfig:
> > /tmp/ccoT403o.s:21439: Error: bad immediate value for offset (4168)
> > /tmp/ccoT403o.s:21440: Error: bad immediate value for offset (4176)
> > /tmp/ccoT403o.s:21475: Error: bad immediate value for offset (4260)
> > /tmp/ccoT403o.s:21476: Error: bad immediate value for offset (4260)
> > /tmp/ccoT403o.s:23566: Error: bad immediate value for offset (4132)
> > /tmp/ccoT403o.s:23567: Error: bad immediate value for offset (4148)
> > /tmp/ccoT403o.s:23606: Error: bad immediate value for offset (4236)
> > /tmp/ccoT403o.s:23607: Error: bad immediate value for offset (4248)
> > 
> > which, when looking at the logs, appears to be:
> > 
> > /tmp/ccoT403o.s:47583: Error: bad immediate value for offset (5464)
> > make[3]: *** [arch/arm/kernel/kprobes-test-arm.o] Error 1
> > make[3]: Target `__build' not remade because of errors.
> > make[2]: *** [arch/arm/kernel] Error 2
> > 
> > Any ideas?
> 
> Sounds vaguely familiar as a problem I hit before. Google finds someone
> else hitting similar problem [1] and the symptoms and cause match my
> memories of the old kprobe issue.
> 
> Where can I find a clue of to the config and compiler used in Olof's
> build, so I can have a go at reproducing and debugging?

I've now reproduced this and the cause _is_ the problem mentioned at the
bottom of this email because the following diff fixes the issue (now
need to try and think of a nicer and more robust fix...)

diff --git a/arch/arm/kernel/kprobes-test.h
b/arch/arm/kernel/kprobes-test.h
index eecc90a..783072d 100644
--- a/arch/arm/kernel/kprobes-test.h
+++ b/arch/arm/kernel/kprobes-test.h
@@ -113,7 +113,7 @@ struct test_arg_end {
        "bl     __kprobes_test_case_start               \n\t"   \
        /* don't use .asciz here as 'title' may be */           \
        /* multiple strings to be concatenated.  */             \
-       ".ascii "#title"                                \n\t"   \
+       ".ascii "#title";;;;;;;;;;;;;;;;;;;;            \n\t"   \
        ".byte  0                                       \n\t"   \
        ".align 2, 0                                    \n\t"


> 
> [1] https://lkml.org/lkml/2012/9/24/223
> 
> The relevant explanation of the above post copied below...
> 
> ------------------------------------------------------------------------
> 
> The compiler uses a pretty dumb heuristic to guess the size of asms:
> 4 * (number of ; or \n in the string)
> 
> Directives that the compiler can't predict the size of are not safe if
> they output into any segment that the compiler uses.  .fill/.skip are
> obvious candidates, but macro expansions, .rept, .irp etc. can cause
> these problems too.
> 
> For example:
> 
> 	void g(int);
> 	void f(void)
> 	{
> 		g(0xd00dfeed);
> 		asm(".skip 0x1000");
> 	}
> If you try building this with gcc -marm -Os for example:
> 
> /tmp/ccXYm1uP.s: Assembler messages:
> /tmp/ccXYm1uP.s:21: Error: bad immediate value for offset (4100)
> 
> ...because the assembler assumes that it can dump a literal at the end
> of the function and reference it from the g() callsite.
> 
> ------------------------------------------------------------------------
> 
> 
