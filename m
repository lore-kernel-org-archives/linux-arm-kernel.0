From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 22 Mar 2016 04:49:48 +0300
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160321184312.GB26563@yury-N73SV>
References: <20160218223506.GA7816@yury-N73SV>
 <mvm8u29ukqw.fsf@hawking.suse.de>
 <20160225202855.GD16123@yury-N73SV> <56EBD84D.2060009@huawei.com>
 <20160318154918.GA1595@yury-N73SV> <56EC24EE.6020803@suse.de>
 <20160318164627.GA3201@yury-N73SV> <56EE5B6E.6030305@huawei.com>
 <56EFD9B0.6080004@huawei.com> <20160321184312.GB26563@yury-N73SV>
Message-ID: <20160322014948.GA9275@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 09:43:12PM +0300, Yury Norov wrote:
> On Mon, Mar 21, 2016 at 07:23:28PM +0800, Zhangjian (Bamvor) wrote:
> > >>So this most probably means that ilp32 code doesn't handle one of cloned
> > >>item properly. I have already discovered a bug where child processes
> > >>used parent TLS,
> > >It is a kernel bug or glibc bug? Could you please explain it or show the patch?
> > >The current ILP32 patches looks good to me. Recently, I backport these patches
> > >to our 4.1 kernel. And I saw crash frequently even if I only do a single print
> > >or infinite loop. There is some small changes about tls register after 4.1. I
> > >am not sure if it is a similar issue. It is great if you have some suggestions/
> > >ideas.
> > My issue is because I forget to change is_compat_task to
> > is_a32_compat_task in arch/arm64/kernel/process.c such piece of code
> > is delete after commit d00a3810c162 ("arm64: context-switch user tls
> > register tpidr_el0 for compat tasks). It is not exist in upstream
> > kernel, never mind.
> > 
> > Meanwhile, I found that it seem that there is another is_compat_task
> > in tls_thread_flush. Is it relative the issue you mentioned?
> > 
> > ```
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 432b094..9ab968c 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -209,7 +209,7 @@ static void tls_thread_flush(void)
> >  {
> >         asm ("msr tpidr_el0, xzr");
> > 
> > -       if (is_compat_task()) {
> > +       if (is_a32_compat_task()) {
> >                 current->thread.tp_value = 0;
> > 
> >                 /*
> > ```
> > 
> > Regards
> > 
> > Bamvor
> 
> Hi,
> 
> This fix looks correct, though doesn't fix issue.
> Thank you.
> 
> Yury.

Hi again.

Next fix helps with SIGSEGV crash of trigo test. But now it hangs on
futex, so work is not finished yet. Nevertheless, you can apply it and
do your tests.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/signal_ilp32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
index 455b0fb..1bb0ea8 100644
--- a/arch/arm64/kernel/signal_ilp32.c
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -107,6 +107,7 @@ int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
 
 	if (!frame)
 		return 1;
+	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
 
 	__put_user_error(0, &frame->sig.uc.uc_flags, err);
 	__put_user_error(NULL, &frame->sig.uc.uc_link, err);
@@ -115,12 +116,9 @@ int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
 	err |= setup_sigframe(&frame->sig, regs, set);
 	if (err == 0) {
 		setup_return(regs, &ksig->ka, frame,
-			offsetof(struct ilp32_rt_sigframe, sig), usig);
-		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-			err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
-			regs->regs[1] = (unsigned long)&frame->info;
-			regs->regs[2] = (unsigned long)&frame->sig.uc;
-		}
+				offsetof(struct ilp32_rt_sigframe, sig), usig);
+		regs->regs[1] = (unsigned long)&frame->info;
+		regs->regs[2] = (unsigned long)&frame->sig.uc;
 	}
 
 	return err;
-- 
2.5.0
