From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 3 Mar 2015 08:31:32 +0100
Subject: [PATCH v2 0/5] split ET_DYN ASLR from mmap ASLR
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Message-ID: <20150303073132.GA30602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> To address the "offset2lib" ASLR weakness[1], this separates ET_DYN
> ASLR from mmap ASLR, as already done on s390. The architectures
> that are already randomizing mmap (arm, arm64, mips, powerpc, s390,
> and x86), have their various forms of arch_mmap_rnd() made available
> via the new CONFIG_ARCH_HAS_ELF_RANDOMIZE. For these architectures,
> arch_randomize_brk() is collapsed as well.
> 
> This is an alternative to the solutions in:
> https://lkml.org/lkml/2015/2/23/442

Looks good so far:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

While reviewing this series I also noticed that the following code 
could be factored out from architecture mmap code as well:

  - arch_pick_mmap_layout() uses very similar patterns across the 
    platforms, with only few variations. Many architectures use 
    the same duplicated mmap_is_legacy() helper as well. There's 
    usually just trivial differences between mmap_legacy_base() 
    approaches as well.

  - arch_mmap_rnd(): the PF_RANDOMIZE checks are needlessly
    exposed to the arch routine - the arch routine should only 
    concentrate on arch details, not generic flags like
    PF_RANDOMIZE.

In theory the mmap layout could be fully parametrized as well: i.e. no 
callback functions to architectures by default at all: just 
declarations of bits of randomization desired (or, available address 
space bits), and perhaps an arch helper to allow 32-bit vs. 64-bit 
address space distinctions.

'Weird' architectures could provide special routines, but only by 
overriding the default behavior, which should be generic, safe and 
robust.

Thanks,

	Ingo
