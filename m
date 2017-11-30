From: ndesaulniers@google.com (Nick Desaulniers)
Date: Wed, 29 Nov 2017 16:32:52 -0800
Subject: [PATCH 1/7] kbuild: add ld-name macro and support for GNU gold
In-Reply-To: <20171129234442.655-2-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171129234442.655-2-samitolvanen@google.com>
Message-ID: <CAKwvOdme29UPfaV1CCbMXRM=LzZJ-asytEjGm_F7ARN0WrMsEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 3:44 PM, Sami Tolvanen <samitolvanen@google.com> wrote:
> GNU gold may require different flags than GNU ld. Add a macro for
> detecting the linker and conditionally add gold specific flags from
> LDFLAGS_GOLD.

Right, but you're still only ever using one linker per build, correct?
 Can we get away without 2 distinct flags?

> +# Add any flags specific to ld.gold
> +ifeq ($(ld-name),gold)
> +LDFLAGS                += $(LDFLAGS_GOLD)
> +endif
> +

Patch 1 and 6 have this pattern of always assigning to LDFLAGS_GOLD,
then that to LDFLAGS.  Wouldn't it be better to check the ld-name and
conditionally assign to LDFLAGS? Then LDFLAGS_GOLD is not necessary.
For example, what I'm suggesting is what is done in patch 4.

> +# ld-name
> +# Expands to either bfd or gold
> +ld-name = $(shell $(LD) -v 2>&1 | grep -q "GNU gold" && echo gold || echo bfd)
> +

This part LGTM.
