From: rabin@rab.in (Rabin Vincent)
Date: Fri, 24 Feb 2012 22:18:21 +0530
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <20120222212821.GE7041@n2100.arm.linux.org.uk>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-2-git-send-email-rabin@rab.in>
 <20120220161601.GH26840@n2100.arm.linux.org.uk>
 <20120222141317.GB9031@debian>
 <20120222212821.GE7041@n2100.arm.linux.org.uk>
Message-ID: <20120224164821.GA22856@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 09:28:21PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 22, 2012 at 07:43:17PM +0530, Rabin Vincent wrote:
> > On Mon, Feb 20, 2012 at 04:16:01PM +0000, Russell King - ARM Linux wrote:
> > > On Sat, Jan 28, 2012 at 07:05:20PM +0530, Rabin Vincent wrote:
> > > > diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> > > > index c0062ad..e9488ad 100644
> > > > --- a/arch/arm/kernel/ftrace.c
> > > > +++ b/arch/arm/kernel/ftrace.c
> > > > @@ -125,11 +125,13 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
> > > >  {
> > > >  	unsigned long replaced;
> > > >  
> > > > -	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> > > > -		return -EFAULT;
> > > > +	if (old) {
> > > 
> > > So, we're using the instruction value '0' to mean that we don't want to
> > > check?  Wouldn'it it be better to pass a flag in to indicate this instead
> > > of creating a magic value?
> > 
> > OK.  I think you applied this patch as-is anyway, so here is a follow-on
> > patch:
> 
> I'd still much prefer it to be part of the original patch.  I can replace
> the patch I've merged or augment it with another patch - whichever way
> you prefer.

Replacing the original is OK with me, new patch below.  Note that "ARM:
ftrace: use canonical Thumb-2 wide instruction format" will need to be
manually rebased on top of it since there is a change in the context.

8<----------------
>From 11a4aea10f1b2d56c70c34def29b3f8d56b88dd5 Mon Sep 17 00:00:00 2001
From: Rabin Vincent <rabin@rab.in>
Date: Sat, 21 Jan 2012 21:52:19 +0530
Subject: [PATCH] ARM: ftrace: remove useless memory checks

Before replacing an instruction, the ftrace code determines what the old
instruction should be and verifies that that's what's really there in
memory before replacing it.  This is useful if for example a bug in
mcountrecord causes it to record wrong locations.

However, in cases where we replace call sites in entry-common.S, these
checks are not needed.  For these, we currently just memcpy() the memory
content and then "verify" it -- this is quite useless and can be
removed.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/kernel/ftrace.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index c0062ad..6fd7c4a 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -121,15 +121,17 @@ static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 }
 
 static int ftrace_modify_code(unsigned long pc, unsigned long old,
-			      unsigned long new)
+			      unsigned long new, bool validate)
 {
 	unsigned long replaced;
 
-	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
-		return -EFAULT;
+	if (validate) {
+		if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
+			return -EFAULT;
 
-	if (replaced != old)
-		return -EINVAL;
+		if (replaced != old)
+			return -EINVAL;
+	}
 
 	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
 		return -EPERM;
@@ -141,23 +143,21 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
 
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
-	unsigned long pc, old;
+	unsigned long pc;
 	unsigned long new;
 	int ret;
 
 	pc = (unsigned long)&ftrace_call;
-	memcpy(&old, &ftrace_call, MCOUNT_INSN_SIZE);
 	new = ftrace_call_replace(pc, (unsigned long)func);
 
-	ret = ftrace_modify_code(pc, old, new);
+	ret = ftrace_modify_code(pc, 0, new, false);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (!ret) {
 		pc = (unsigned long)&ftrace_call_old;
-		memcpy(&old, &ftrace_call_old, MCOUNT_INSN_SIZE);
 		new = ftrace_call_replace(pc, (unsigned long)func);
 
-		ret = ftrace_modify_code(pc, old, new);
+		ret = ftrace_modify_code(pc, 0, new, false);
 	}
 #endif
 
@@ -172,7 +172,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 	old = ftrace_nop_replace(rec);
 	new = ftrace_call_replace(ip, adjust_address(rec, addr));
 
-	return ftrace_modify_code(rec->ip, old, new);
+	return ftrace_modify_code(rec->ip, old, new, true);
 }
 
 int ftrace_make_nop(struct module *mod,
@@ -185,7 +185,7 @@ int ftrace_make_nop(struct module *mod,
 
 	old = ftrace_call_replace(ip, adjust_address(rec, addr));
 	new = ftrace_nop_replace(rec);
-	ret = ftrace_modify_code(ip, old, new);
+	ret = ftrace_modify_code(ip, old, new, true);
 
 #ifdef CONFIG_OLD_MCOUNT
 	if (ret == -EINVAL && addr == MCOUNT_ADDR) {
@@ -193,7 +193,7 @@ int ftrace_make_nop(struct module *mod,
 
 		old = ftrace_call_replace(ip, adjust_address(rec, addr));
 		new = ftrace_nop_replace(rec);
-		ret = ftrace_modify_code(ip, old, new);
+		ret = ftrace_modify_code(ip, old, new, true);
 	}
 #endif
 
@@ -254,7 +254,7 @@ static int __ftrace_modify_caller(unsigned long *callsite,
 	unsigned long old = enable ? nop : branch;
 	unsigned long new = enable ? branch : nop;
 
-	return ftrace_modify_code(pc, old, new);
+	return ftrace_modify_code(pc, old, new, true);
 }
 
 static int ftrace_modify_graph_caller(bool enable)
-- 
1.7.9
