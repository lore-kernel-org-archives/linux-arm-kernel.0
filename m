From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 10:00:34 +0100
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <53B1D6B8.7080806@amacapital.net>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <53B1D6B8.7080806@amacapital.net>
Message-ID: <20140701090034.GB28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:29:28PM +0100, Andy Lutomirski wrote:
> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
> > diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
> > new file mode 100644
> > index 000000000000..fbf36d75da06
> > --- /dev/null
> > +++ b/arch/arm/kernel/vdso/datapage.S
> > @@ -0,0 +1,15 @@
> > +#include <linux/linkage.h>
> > +#include <asm/asm-offsets.h>
> > +
> > +	.align 2
> > +.L_vdso_data_ptr:
> > +	.long	_start - . - VDSO_DATA_SIZE
> > +
> > +ENTRY(__get_datapage)
> > +	.cfi_startproc
> > +	adr	r0, .L_vdso_data_ptr
> > +	ldr	r1, [r0]
> > +	add	r0, r0, r1
> > +	bx	lr
> > +	.cfi_endproc
> > +ENDPROC(__get_datapage)
> 
> Can you translate this into English for the non-ARM-speakers here?

Also, I'm not sure .cfi directives are the right things to use for AArch32.
ARM has special .fnstart, .fnend, .movsp diretives for its own unwind
format.

Maybe GDB works with both -- have you tried unwinding out of this with
anything?

Will
