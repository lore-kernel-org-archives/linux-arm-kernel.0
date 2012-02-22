From: rabin@rab.in (Rabin Vincent)
Date: Wed, 22 Feb 2012 19:43:17 +0530
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <20120220161601.GH26840@n2100.arm.linux.org.uk>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-2-git-send-email-rabin@rab.in>
 <20120220161601.GH26840@n2100.arm.linux.org.uk>
Message-ID: <20120222141317.GB9031@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 04:16:01PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 28, 2012 at 07:05:20PM +0530, Rabin Vincent wrote:
> > diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> > index c0062ad..e9488ad 100644
> > --- a/arch/arm/kernel/ftrace.c
> > +++ b/arch/arm/kernel/ftrace.c
> > @@ -125,11 +125,13 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
> >  {
> >  	unsigned long replaced;
> >  
> > -	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> > -		return -EFAULT;
> > +	if (old) {
> 
> So, we're using the instruction value '0' to mean that we don't want to
> check?  Wouldn'it it be better to pass a flag in to indicate this instead
> of creating a magic value?

OK.  I think you applied this patch as-is anyway, so here is a follow-on
patch:

8<------------
>From 18ad9e696a3b3986babb1c91807d3f39d6468176 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Wed, 22 Feb 2012 19:11:46 +0530
Subject: [PATCH] ARM: ftrace: use flag for memory check

We currently use a (magic) value of 0 for the old instruction value
to detect if we should verify the old value in memory or not.  Pass
a flag instead.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/ftrace.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 858c63f..df0bf0c 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -69,7 +69,7 @@ static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 }
 
 static int ftrace_modify_code(unsigned long pc, unsigned long old,
-			      unsigned long new)
+			      unsigned long new, bool validate)
 {
 	unsigned long replaced;
 
@@ -81,7 +81,7 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 		new = __opcode_to_mem_arm(new);
 	}
 
-	if (old) {
+	if (validate) {
 		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
 			return -EFAULT;
 
@@ -106,14 +106,14 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	pc = (unsigned long)&ftrace_call;
 	new = ftrace_call_replace(pc, (unsigned long)func);
 
-	ret = ftrace_modify_code(pc, 0, new);
+	ret = ftrace_modify_code(pc, 0, new, false);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
 		new = ftrace_call_replace(pc, (unsigned long)func);
 
-		ret = ftrace_modify_code(pc, 0, new);
+		ret = ftrace_modify_code(pc, 0, new, false);
 	}
 #endif
 
@@ -128,7 +128,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	old = ftrace_nop_replace(rec);
 	new = ftrace_call_replace(ip, adjust_address(rec, addr));
 
-	return ftrace_modify_code(rec->ip, old, new);
+	return ftrace_modify_code(rec->ip, old, new, true);
 }
 
 int ftrace_make_nop(struct module *mod,
@@ -141,7 +141,7 @@ int ftrace_make_nop(struct module *mod,
 
 	old = ftrace_call_replace(ip, adjust_address(rec, addr));
 	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new);
+	ret = ftrace_modify_code(ip, old, new, true);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
@@ -149,7 +149,7 @@ int ftrace_make_nop(struct module *mod,
 
 		old = ftrace_call_replace(ip, adjust_address(rec, addr));
 		new = ftrace_nop_replace(rec);
-		ret = ftrace_modify_code(ip, old, new);
+		ret = ftrace_modify_code(ip, old, new, true);
 	}
 #endif
 
@@ -210,7 +210,7 @@ static int __ftrace_modify_caller(unsigned long *callsite,
 	unsigned long old = enable ? nop : branch;
 	unsigned long new = enable ? branch : nop;
 
-	return ftrace_modify_code(pc, old, new);
+	return ftrace_modify_code(pc, old, new, true);
 }
 
 static int ftrace_modify_graph_caller(bool enable)
-- 
1.7.9
