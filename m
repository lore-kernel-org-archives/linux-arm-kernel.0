From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Feb 2010 11:20:48 +0000
Subject: [RFC PATCH v2 1/2] ARM: VFP: add support to sync the VFP state
	of the current thread
In-Reply-To: <20100206103230.GC1923@n2100.arm.linux.org.uk>
References: <b8a1d37c5f981cdd2e83c9fd98198832324cd57c.1265315249.git.imre.deak@nokia.com>
	<b8a1d37c5f981cdd2e83c9fd98198832324cd57d.1265315249.git.imre.deak@nokia.com>
	<20100206103230.GC1923@n2100.arm.linux.org.uk>
Message-ID: <20100206112048.GD1923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 06, 2010 at 10:32:30AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 04, 2010 at 11:38:02PM +0200, Imre Deak wrote:
> > So far vfp_sync_state worked only for threads other than the current
> > one. This worked for tracing other threads, but not for PTRACE_TRACEME.
> > Syncing for the current thread will also be needed by an upcoming patch
> > adding support for VFP context save / restore around signal handlers.
> > 
> > For SMP we need get_cpu now, since we have to protect the FPEXC
> > register, other than this things remained the same for threads other
> > than the current.
> 
> I don't think we should make this function any more complicated than it
> already is.

... and the more I look at vfp_sync_state(), the more I believe it's
trying to do its job in a really obscure way.

Essentially, last_VFP_context[] tracks who owns the state in the VFP
hardware.  If last_VFP_context[] is the context for the thread which
we're interested in, then the VFP hardware has context which is not
saved in the software state - so we need to bring the software state
up to date.

If last_VFP_context[] is for some other thread, we really don't care
what state the VFP hardware is in; it doesn't contain any information
pertinent to the thread we're trying to deal with - so leave the
hardware well alone.

As a side effect, this makes vfp_sync_state() callable for the current
thread, and allows it to do the right thing there as well.

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index f60a540..6447d78 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -444,32 +444,28 @@ void vfp_sync_state(struct thread_info *thread)
 void vfp_sync_state(struct thread_info *thread)
 {
 	unsigned int cpu = get_cpu();
-	u32 fpexc = fmrx(FPEXC);
 
 	/*
-	 * If VFP is enabled, the previous state was already saved and
-	 * last_VFP_context updated.
+	 * If the thread we're interested in is the current owner of the
+	 * hardware VFP state, then we need to save its state.
 	 */
-	if (fpexc & FPEXC_EN)
-		goto out;
-
-	if (!last_VFP_context[cpu])
-		goto out;
+	if (last_VFP_context[cpu] == &thread->vfpstate) {
+		u32 fpexc = fmrx(FPEXC);
 
-	/*
-	 * Save the last VFP state on this CPU.
-	 */
-	fmxr(FPEXC, fpexc | FPEXC_EN);
-	vfp_save_state(last_VFP_context[cpu], fpexc);
-	fmxr(FPEXC, fpexc);
+		/*
+		 * Save the last VFP state on this CPU.
+		 */
+		fmxr(FPEXC, fpexc | FPEXC_EN);
+		vfp_save_state(&thread->vfpstate, fpexc | FPEXC_EN);
+		fmxr(FPEXC, fpexc);
 
-	/*
-	 * Set the context to NULL to force a reload the next time the thread
-	 * uses the VFP.
-	 */
-	last_VFP_context[cpu] = NULL;
+		/*
+		 * Set the context to NULL to force a reload the next time
+		 * the thread uses the VFP.
+		 */
+		last_VFP_context[cpu] = NULL;
+	}
 
-out:
 	put_cpu();
 }
 #endif
