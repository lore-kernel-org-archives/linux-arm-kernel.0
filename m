From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 2 Mar 2011 10:59:50 +0000
Subject: [RFC PATCH] ARM: Use generic BUG() handler
In-Reply-To: <AANLkTinMnZAupxn7oYFhqkN1Y0OD-eyN=UeRpw96no9r@mail.gmail.com>
References: <1298939263-16421-1-git-send-email-sjg@chromium.org>
	<20110301084949.GA16733@n2100.arm.linux.org.uk>
	<20110301085911.GB16733@n2100.arm.linux.org.uk>
	<19820.47240.801312.507393@pilspetsen.it.uu.se>
	<20110301100306.GA18007@n2100.arm.linux.org.uk>
	<AANLkTinMnZAupxn7oYFhqkN1Y0OD-eyN=UeRpw96no9r@mail.gmail.com>
Message-ID: <20110302105930.GA2363@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 08:34:37AM -0800, Simon Glass wrote:

[...]

> 
> It seems I am lucky with the gcc I am using. I would have thought this
> would be a pretty fundamental feature, but yes I did notice that %c
> wasn't used anywhere.
> 
> Would this kernel feature be acceptable as a selectable config option
> on ARM then?
> 
> Thanks,
> Simon

+/* A suitable undefined instruction to use for ARM bug handling */
+#define BUG_INSTR ".word 0xec000000"

^ This needs to be changed, since it's not an architecturally
undefined encoding -- i.e., it may get used in the future to
mean something real.

See arch/arm/kernel/{ptrace,kprobes}.c for examples of
suitable encodings.



Rather than relying on the %c inline asm feature, can we work
around it?

Since we are writing a macro anyway, we can paste most of the
arguments in when the macro is expanded, rather than relying on
the inline assembler to do it.

This works for everything except sizeof (struct bug_entry)
which the preprocessor obviously can't understand.  But I suspect
we don't really need that: we need to keep the directives that
generate the bug entry in sync with the definition of struct bug_entry
anyway (don't we?) -- so the amount of extra padding needed is
currently zero and should always be a constant.

So, maybe something like this would work:

(Note -- I haven't tested this!)

+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define BUG() __BUG(__FILE__, __LINE__, BUG_INSTR)
+#define __BUG(__file, __line, __bug_instr)			\
+do {								\
+	asm volatile("1:\t" __bug_instr "\n"		q	\
+		     ".pushsection .rodata.str, \"a\"\n"	\
+		     "2:\t.asciz \"" #__file "\"\n"		\
+		     ".popsection\n"				\ 
+		     ".pushsection __bug_table,\"a\"\n"		\
+		     "3:\t.word 1b, 2b\n"			\
+		     "\t.hword " #__line ", 0\n"		\
+		     ".popsection"				\
+	unreachable();						\
+} while (0)

Cheers
---Dave
