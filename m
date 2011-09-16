From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 16 Sep 2011 16:32:43 +0100
Subject: [ltt-dev] [PATCH] ARM: Set bit 0 for thumb mode in
	kallsyms_lookup_name returned address
In-Reply-To: <BLU0-SMTP31816889BA02407E5EEBA296060@phx.gbl>
References: <1316170684-1914-1-git-send-email-avik.sil@linaro.org>
	<BLU0-SMTP31816889BA02407E5EEBA296060@phx.gbl>
Message-ID: <CA+wbFdcWfCMNDGApUe=nBumAdy7wumrdG87edXviZL99zEP=RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 2:53 PM, Mathieu Desnoyers
<compudj@krystal.dyndns.org> wrote:
> * Avik Sil (avik.sil at linaro.org) wrote:
>> This patch fixes the undefined instruction oops due to execution
>> of thumb-2 code in ARM mode. The zero bit in the symbol address
>> returned by kallsyms_lookup_name is not set, leading to switching
>> to ARM mode that generates oops while executing thumb-2 code. For
>> detailed discussion, see [1].
>> [1] http://lists.casi.polymtl.ca/pipermail/ltt-dev/2011-September/005176.html
>
> Hi Avik,
>
> Instead of modifying all those wrappers individually, can you create a
> wrapper/kallsyms.h and create a wrapper for kallsyms_lookup_name ? This
> way, the ifdef for the ARM special-case would only appear once.

kallsyms_lookup_name() makes no distinction between function and data
symbols, so we should be wary of changing the behaviour of this
function globally.  I suspect that indiscriminately setting bit 0 of
the return of kallsyms_lookup_name() may lead to some wrong behaviour.

[ Aside: this problem is copounded by the fact that the kallsyms table
is built by parsing the output of nm, so the recorded symbol type
information is somewhat wrong: nm seems to classify symbols according
to what section they're in, _not_ according to the actual symbol type
declared in the ELF symbol table.  This means that if
kallsyms_lookup_name() is used to get the address of a data symbol
defined in the text segment of an assembler file, it's hard to
guarantee to return a sensible result.  (There are also plenty of
symbols in assembler files with no declared ELF symbol type at all,
but that's arguably a fixable coding bug in those files) ]

I think we do need an arch-specific wrapper with a separate, explicit
name such as kallsyms_lookup_funcptr(), and all code which really
wants a callable function pointer to be returned should use this
wrapper instead of kallsyms_lookup_name(), at least for all
arch-independent code, and arch-dependent code for arches where it
makes a difference.

In particular, I really think we shouldn't be pasting multiple
arch-specific #ifdefs like

+                addr = kallsyms_lookup_name("splice_to_pipe");
+#ifdef CONFIG_ARM
+#ifdef CONFIG_THUMB2_KERNEL
+        if (addr)
+                addr |= 1; /* set bit 0 in address for thumb mode */
+#endif
+#endif

into arch-independent code -- this will cerate a lot of patch noise
and frustrate maintenance.


Personally, I would much prefer

-               splice_to_pipe_sym = (void *)
kallsyms_lookup_name("splice_to_pipe");
+               splice_to_pipe_sym = (void *)
kallsyms_lookup_funcptr("splice_to_pipe");

...which also makes the code clearer IMHO.  kallsyms_lookup_funcptr()
must necessarily come from arch-specific headers for many arches,
including ARM.

Cheers
---Dave
