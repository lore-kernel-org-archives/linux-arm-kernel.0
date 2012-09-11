From: chanho0207@gmail.com (Chanho Min)
Date: Tue, 11 Sep 2012 10:53:14 +0900
Subject: [PATCH] ARM: Fix build warning in do_alignment.
In-Reply-To: <20120910084025.GP13739@n2100.arm.linux.org.uk>
References: <CAOAMb1CTk1_dQAUiHy5ch=UxN7vSe0of81KcKbjPjCFqR9e9tw@mail.gmail.com>
 <20120910084025.GP13739@n2100.arm.linux.org.uk>
Message-ID: <CAOAMb1A71iNuRHkuTynBF35DjZx0jHMz+SrwbMUzkdp4i1FZ7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What it's caused by is do_alignment_t32_to_handler(), and its assignment
> through a pointer of this variable.  You can see that this is the cause
> because the patch below fixes the warning.
We couldn't fix the warning with your patch. the patch below fixes it instead.
IMHO, gcc can't seems to know that do_alignment_ldmstm never returns TYPE_LDST.
So It just warn that do_alignment_finish_ldst is called with the
uninitialized value.
I know gcc is not smart enough to see all the reasons. So, It is optional.
Also, I'm not sure these optional warning should be fixed.
Anyway, this is the last build warning in our whole source when using gcc-4.6.3

Thanks
Chanho,

diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 9107231..978db1f 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -856,8 +856,10 @@ do_alignment(unsigned long addr, unsigned int
fsr, struct pt_regs *regs)
 	case 0x08000000:	/* ldm or stm, or thumb-2 32bit instruction */
 		if (thumb2_32b)
 			handler = do_alignment_t32_to_handler(&instr, regs, &offset);
-		else
+		else {
+			offset.un = 0;
 			handler = do_alignment_ldmstm;
+		}
 		break;

 	default:
