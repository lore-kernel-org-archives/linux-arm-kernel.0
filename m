From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 23 Dec 2015 07:21:33 +0300
Subject: [PATCH v6 13/20] arm64: ilp32: share aarch32 syscall wrappers to
 ilp32
In-Reply-To: <20151222122514.GA1302@e104818-lin.cambridge.arm.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-14-git-send-email-ynorov@caviumnetworks.com>
 <20151222122514.GA1302@e104818-lin.cambridge.arm.com>
Message-ID: <20151223042133.GA18231@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:25:15PM +0000, Catalin Marinas wrote:
> On Wed, Dec 16, 2015 at 12:42:39AM +0300, Yury Norov wrote:
> > statfs64, fstat64 and mmap_pgoff has wrappers that needed both by aarch32 and
> > ilp32 to workaround some issues. Here we create common file to share aarch32
> > workarounds to with ilp32 code.
> [...]
> > --- /dev/null
> > +++ b/arch/arm64/kernel/entry32-common.S
> > @@ -0,0 +1,37 @@
> > +#include <linux/linkage.h>
> > +#include <linux/const.h>
> > +
> > +#include <asm/assembler.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/errno.h>
> > +#include <asm/page.h>
> > +
> > +ENTRY(compat_sys_statfs64_wrapper)
> > +	mov	w3, #84
> > +	cmp	w1, #88
> > +	csel	w1, w3, w1, eq
> > +	b	compat_sys_statfs64
> > +ENDPROC(compat_sys_statfs64_wrapper)
> > +
> > +ENTRY(compat_sys_fstatfs64_wrapper)
> > +	mov	w3, #84
> > +	cmp	w1, #88
> > +	csel	w1, w3, w1, eq
> > +	b	compat_sys_fstatfs64
> > +ENDPROC(compat_sys_fstatfs64_wrapper)
> 
> I'm not convinced we need these wrappers for ILP32. They've been
> introduced on arch/arm many years ago by commit Fixes: 713c481519f1
> ([ARM] 3108/2: old ABI compat: statfs64 and fstatfs64) to deal with user
> space passing a size of 88 (the EABI size of struct compat_statfs64
> without the packing and alignment attribute). Since that commit, the
> sizeof(struct compat_statfs64) is 84 already. This should be the case
> with the new ILP32 exported headers (no backwards compatibility), so
> user space should never pass 88 as size. Therefore we could call
> compat_sys_(f)statfs64 directly without wrappers.
> 

With current glibc, sizeof(struct compat_statfs64) is 88, so I added
wrappers just to make this couple of syscalls work. AFAIR, glibc
doesn't use exported headers here, so we'd change it. Maybe Andrew
will share more details.

> -- 
> Catalin
