From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Feb 2012 17:12:28 -0800
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers
In-Reply-To: <878vk6cl5z.fsf@rustcorp.com.au>
References: <20120213212401.GH1426@atomide.com>
 <20120213222652.GL14173@pengutronix.de>
 <20120213225118.GC31482@n2100.arm.linux.org.uk>
 <878vk6cl5z.fsf@rustcorp.com.au>
Message-ID: <20120214011228.GM1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rusty Russell <rusty@rustcorp.com.au> [120213 16:07]:
> On Mon, 13 Feb 2012 22:51:18 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Mon, Feb 13, 2012 at 11:26:52PM +0100, Uwe Kleine-K?nig wrote:
> > > On Mon, Feb 13, 2012 at 01:24:01PM -0800, Tony Lindgren wrote:
> > > Maybe:
> > > 
> > > #ifndef R_ARM_CALL
> > > #warning "you're elf.h include is outdated"
> > 
> > "You are elf.h include is outdated" does not make sense.
> > 
> > Why are you calling Tony an elf.h include?
> 
> Because he knew it would attract the attention of pedants to the patch?
> :)

I've been called worse than that :)
 
> Just do the #ifndef, and skip the warning.  There's not much the poor
> user receiving the warning can do about it.

OK
 
> Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Assuming your ack applies for this patch below, let me know if that's
not the case.  
Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 13 Feb 2012 12:30:09 -0800
Subject: [PATCH] modpost: Fix section warnings for ARM for many compilers

It turns out that many compilers don't show section warnings on ARM
currently because handling for ARM_CALL relocs are missing from
modpost.c.

Based on commit c2e26114 ([ARM] 3205/1: Handle new EABI relocations when
loading kernel modules) it seems that R_ARM_PC24, R_ARM_CALL and
R_ARM_JUMP24 can be handled the same way.

Note that at least Debian libc6-dev is missing defines for both
R_ARM_CALL and R_ARM_JUMP24 in /usr/include/elf.h. So for now
we need to define them in modpost.c if not defined.

Acked-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Anders Kaseorg <andersk@ksplice.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1494,6 +1494,13 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 	return 0;
 }
 
+#ifndef R_ARM_CALL
+#define R_ARM_CALL	28
+#endif
+#ifndef R_ARM_JUMP24
+#define R_ARM_JUMP24	29
+#endif
+
 static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 {
 	unsigned int r_typ = ELF_R_TYPE(r->r_info);
@@ -1505,6 +1512,8 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 		              (elf->symtab_start + ELF_R_SYM(r->r_info));
 		break;
 	case R_ARM_PC24:
+	case R_ARM_CALL:
+	case R_ARM_JUMP24:
 		/* From ARM ABI: ((S + A) | T) - P */
 		r->r_addend = (int)(long)(elf->hdr +
 		              sechdr->sh_offset +
