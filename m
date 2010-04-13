From: imre.deak@nokia.com (Imre Deak)
Date: Tue, 13 Apr 2010 14:42:18 +0300
Subject: [RFC PATCH v5 0/2] ARM: VFP: Save / restore VFP state on the
	signal handler path
In-Reply-To: <20100412220440.GF6148@shareable.org>
References: <1270070606-5732-1-git-send-email-imre.deak@nokia.com>
	<cover.1270199787.git.imre.deak@nokia.com>
	<20100412220440.GF6148@shareable.org>
Message-ID: <20100413114218.GA22424@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 12:04:40AM +0200, ext Jamie Lokier wrote:
> imre.deak at nokia.com wrote:
> > From: Imre Deak <imre.deak@nokia.com>
> > 
> > Changes since v4:
> > - Do not add the packed attribute to user_vfp or user_vfp_exc.
> >   I added packed to these structs to prevent the extra padding in
> >   vfp_sigframe. But actually the padding is in accordance with the
> >   ARM ABI.
> 
> EABI, OABI or both?

I checked only EABI, which specifies alignment to the struct's alignment,
which is 8 bytes for struct user_vfp.

I haven't found an official OABI spec, but some googling turned up
that there the requirement is only to align to word size, so we'd
have a difference in the struct vfp_sigframe's size and the alignment
of the user_vfp_exc within.

> In general it's a really good idea, if you know there will be padding,
> to insert dummy fields where the padding goes so that it doesn't make
> any difference what compiler, ABI and settings are used.

Ok. If I understand correctly this is needed for kernels with support
for both OABI and EABI.

There is implicit alignment in struct user_vfp and struct user_vfp_exc.
I can fix up user_vfp_exc since it's new and not used by anyone, but
user_vfp is used by ptrace. I don't see a problem adding the padding to
it either since the kernel ever accesses it on a field-by-field basis,
but for kernels built with an OABI compiler this would mean an increase
in the struct's size. If this is not a problem I'd follow up with a 2/2
patch according to the following.

Please let me know if it's ok with you.

--Imre

--- a/arch/arm/include/asm/ucontext.h
+++ b/arch/arm/include/asm/ucontext.h
@@ -59,23 +59,19 @@ struct iwmmxt_sigframe {
 #endif /* CONFIG_IWMMXT */

 #ifdef CONFIG_VFP
-#if __LINUX_ARM_ARCH__ < 6
-/* For ARM pre-v6, we use fstmiax and fldmiax.  This adds one extra
- * word after the registers, and a word of padding@the end for
- * alignment.  */
 #define VFP_MAGIC              0x56465001
-#define VFP_STORAGE_SIZE       152
-#else
-#define VFP_MAGIC              0x56465002
-#define VFP_STORAGE_SIZE       144
-#endif

 struct vfp_sigframe
 {
        unsigned long           magic;
        unsigned long           size;
-       union vfp_state         storage;
-};
+       struct user_vfp         ufp;
+       struct user_vfp_exc     ufp_exc;
+} __attribute__((__aligned__(8)));
+
+/* 8 bytes for magic and size, 264 bytes for ufp, 16 bytes for ufp_exc. */
+#define VFP_STORAGE_SIZE       sizeof(struct vfp_sigframe)
+
 #endif /* CONFIG_VFP */

 /*
@@ -91,7 +87,7 @@ struct aux_sigframe {
 #ifdef CONFIG_IWMMXT
        struct iwmmxt_sigframe  iwmmxt;
 #endif
-#if 0 && defined CONFIG_VFP /* Not yet saved.  */
+#ifdef CONFIG_VFP
        struct vfp_sigframe     vfp;
 #endif
        /* Something that isn't a valid magic number for any coprocessor.  */
diff --git a/arch/arm/include/asm/user.h b/arch/arm/include/asm/user.h
index df95e05..07e66fa 100644
--- a/arch/arm/include/asm/user.h
+++ b/arch/arm/include/asm/user.h
@@ -83,11 +83,23 @@ struct user{

 /*
  * User specific VFP registers. If only VFPv2 is present, registers 16 to 31
- * are ignored by the ptrace system call.
+ * are ignored by the ptrace system call and the signal handler.
  */
 struct user_vfp {
        unsigned long long fpregs[32];
        unsigned long fpscr;
+       unsigned long pad;
+};
+
+/*
+ * VFP exception registers exposed to user space during signal delivery.
+ * Fields not relavant to the current VFP architecture are ignored.
+ */
+struct user_vfp_exc {
+       unsigned long   fpexc;
+       unsigned long   fpinst;
+       unsigned long   fpinst2;
+       unsigned long   pad;
 };

 #endif /* _ARM_USER_H */
