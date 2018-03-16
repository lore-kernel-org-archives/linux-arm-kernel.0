From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 16 Mar 2018 15:13:37 -0700
Subject: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
In-Reply-To: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
Message-ID: <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Mar 2018 15:55:16 +0800 Huacai Chen <chenhc@lemote.com> wrote:

> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> ...
>
>  arch/arm/boot/compressed/head.S        | 4 ++++
>  arch/arm/boot/compressed/misc.c        | 7 -------
>  arch/mips/boot/compressed/decompress.c | 7 -------
>  arch/mips/boot/compressed/head.S       | 4 ++++
>  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
>  arch/sh/boot/compressed/head_64.S      | 4 ++++
>  arch/sh/boot/compressed/misc.c         | 7 -------
>  7 files changed, 20 insertions(+), 21 deletions(-)

Perhaps this should be split into three patches and each one routed via
the appropriate arch tree maintainer (for sh, that might be me).

But we can do it this way if the arm and mips teams can send an ack,
please?
