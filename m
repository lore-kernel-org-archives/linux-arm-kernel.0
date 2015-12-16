From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 17:24:39 +0100
Subject: [RFC3 PATCH v6 00/20] ILP32 for ARM64
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <3878732.mE36CZOJlR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 00:42:26 Yury Norov wrote:
> This is still RFC because we have no glibc yet, that correspnds new ABI
> introduced here. And so we cannot run tests. LP64 and AARCH32 tests show
> no regression though.
> 
>   v3: https://lkml.org/lkml/2014/9/3/704
>   v4: https://lkml.org/lkml/2015/4/13/691
>   v5: https://lkml.org/lkml/2015/9/29/911
> 
>   v6:
>  - time_t, __kenel_off_t and other types turned to be 32-bit
>    for compatibility reasons (after v5 discussion);
>  - related changes applied to ILP32 syscall table and handlers;
>  - ILP32 VDSO code excluded. It's not mandatory, and caused questions
>    during review process. We definitely make sure we will follow up
>    with a VDSO later on because it is needed for performance reasons;
>  - fixed build issues with different combinations of AARCH32 / ILP32
>    enabling in config;
>  - ILP32 TLS bug fixed;
>  - entry32-common.S introduced to hold wrappers needed for both ILP32
>    and AARCH32_EL0;
>  - documentation updated according to latest changes;
>  - rebased to the current head;
>  - coding style re-checked;
>  - ILP32 syscall table turned around.

Hi Yury,

This version looks very good overall, thanks for addressing all my previous
comments!

I've commented on a few things, but it's mostly about style, and there
are no show-stoppers. Please reply to my questions about the binfmt_elf.c,
I must be missing something here as I can't even find which patch adds
support for the new ELF32 executable format.

Regarding my sys_sigaltstack comment, I've looked at the compat handling
in kernel/signal.c and see that it's really ugly. Is that the reason
you didn't want to use it? I think it's a good idea to clean that up
so we don't need the get_fs()/set_fs() hack, but that can be done
independent from your series and would benefit all 32-bit compat handling.

	Arnd
