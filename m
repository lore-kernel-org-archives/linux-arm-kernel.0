From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2011 23:33:19 +0100
Subject: [PATCH 1/1] ARM: thumb: Have the machine name indicate
	operation in thumb mode.
In-Reply-To: <alpine.LFD.2.00.1105181803090.14430@xanadu.home>
References: <20110513195316.9AD0940CD1@eskimo.mtv.corp.google.com>
	<BANLkTikhRuk2ZfYjriTcP7oFdbr7h1oP5g@mail.gmail.com>
	<20110514100232.GC30539@n2100.arm.linux.org.uk>
	<20110516121657.GA7715@arm.com>
	<alpine.LFD.2.00.1105161008320.14430@xanadu.home>
	<20110516144311.GC7715@arm.com>
	<BANLkTik0LL+dFCo_H-YhF+BUOXyP7MAKzA@mail.gmail.com>
	<alpine.LFD.2.00.1105181803090.14430@xanadu.home>
Message-ID: <20110518223319.GB21384@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 06:27:56PM -0400, Nicolas Pitre wrote:
> On Wed, 18 May 2011, Vadim Bendebury (??) wrote:
> 
> > On Mon, May 16, 2011 at 7:43 AM, Dave Martin <dave.martin@linaro.org> wrote:
> > >On Mon, May 16, 2011 at 10:32:16AM -0400, Nicolas Pitre wrote:
> > >> I think this can be useful to know how the kernel was compiled for bug
> > >> tracking purposes, just like we record the Git commit ID of the checked
> > >> out source tree, the gcc version, the build date, etc. ?Which pretty
> > >> much indicates that the thumbness of the kernel should probably be
> > >> stored in the kernel banner not the platform name.
> > >
> > > That seems a reasonable approach to me.
> > >
> > 
> > guys, thank you for your comments. Indeed, this is meant to be just a
> > convenience to allow to quickly tell what kind of kernel a system is
> > running, comes handy when there are many systems around with
> > differently compiled kernels.
> > 
> > So, would it be acceptable if I move this information into the kernel
> > banner (namely, add it to the machine hardware name part of the output
> > included in 'uname -m' and 'uname -a')?
> 
> Yes, I think that would be the most sensible place.  Looking at 
> scripts/mkcompile_h which is used to create include/generated/compile.h, 
> it appears that $CONFIG_FLAGS would be the most appropriate place for 
> this, however it is not currently set up to allow architecture specific 
> flags to be passed in.

We already have a way of adding stuff for bug tracking purposes.  The
"Internal error" line is perpended with 'PREEMPT' or 'SMP' depending
on what build options were enabled.  We just need to do the same with
T2.  IOW, something like this:

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 3b54ad1..78d7714 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -225,6 +225,11 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 #else
 #define S_SMP ""
 #endif
+#ifdef CONFIG_THUMB2_KERNEL
+#define S_ISA " T2"
+#else
+#define S_ISA " ARM"
+#endif
 
 static int __die(const char *str, int err, struct thread_info *thread, struct pt_regs *regs)
 {
@@ -232,8 +237,8 @@ static int __die(const char *str, int err, struct thread_info *thread, struct pt
 	static int die_counter;
 	int ret;
 
-	printk(KERN_EMERG "Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
-	       str, err, ++die_counter);
+	printk(KERN_EMERG "Internal error: %s: %x [#%d]" S_PREEMPT S_SMP
+	       S_ISA "\n", str, err, ++die_counter);
 	sysfs_printk_last_file();
 
 	/* trap and error numbers are mostly meaningless on ARM */
