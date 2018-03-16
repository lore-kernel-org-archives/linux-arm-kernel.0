From: dalias@libc.org (Rich Felker)
Date: Fri, 16 Mar 2018 19:13:59 -0400
Subject: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
In-Reply-To: <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
Message-ID: <20180316231359.GU1436@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 03:13:37PM -0700, Andrew Morton wrote:
> On Fri, 16 Mar 2018 15:55:16 +0800 Huacai Chen <chenhc@lemote.com> wrote:
> 
> > Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> > stack checking always fails for decompress_kernel() itself. So remove
> > __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> > call decompress_kernel().
> > 
> > Original code comes from ARM but also used for MIPS and SH, so fix them
> > together. If without this fix, compressed booting of these archs will
> > fail because stack checking is enabled by default (>=4.16).
> > 
> > ...
> >
> >  arch/arm/boot/compressed/head.S        | 4 ++++
> >  arch/arm/boot/compressed/misc.c        | 7 -------
> >  arch/mips/boot/compressed/decompress.c | 7 -------
> >  arch/mips/boot/compressed/head.S       | 4 ++++
> >  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
> >  arch/sh/boot/compressed/head_64.S      | 4 ++++
> >  arch/sh/boot/compressed/misc.c         | 7 -------
> >  7 files changed, 20 insertions(+), 21 deletions(-)
> 
> Perhaps this should be split into three patches and each one routed via
> the appropriate arch tree maintainer (for sh, that might be me).

Apologies for that. I'm trying to pick back up on things now, now that
I've got both some downtime from other things and funding for core sh
maintenance stuff. If you know any issues you'd especially like me to
put my attention on now, please let me know. I have a few patches
queued up from myself and others, but I believe there's a lot more I
haven't been able to get to for quite a while. I should have new SH
hardware to test on soon and in the meantime I've improved my qemu
setup.

One question I have about this specific patch is why any code is
needed at all. Why can't __stack_chk_guard just be moved to
initialized data, or left uninitialized, for the compressed kernel
image loader? Assuming it is needed, the code looks ok, but I question
the premise.

Rich
