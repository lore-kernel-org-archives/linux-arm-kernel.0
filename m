From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sat, 28 Apr 2018 08:57:04 +0100
Subject: [PATCH] arm64: fix single step issue in kgdb
In-Reply-To: <1e85a456.a65d.162e3213af2.Coremail.liwei1412@163.com>
References: <3a4aff03.a762.162dddc3d1b.Coremail.liwei1412@163.com>
 <20180420082110.wus3np2w7n5tqx6v@holly.lan>
 <1e85a456.a65d.162e3213af2.Coremail.liwei1412@163.com>
Message-ID: <20180428075704.ejy4srbpuovcria3@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 08:57:08PM +0800, Wei Li wrote:
> Because the former mail is in html by my mistake, it is rejected by
> the mailing list server.

I'm afraid that switching to plain text isn't quite enough; the patch
appears to be corrupt.

I'd personally suggest switching over to `git send-email` but there are
many other ways to send out patches. If you can't use git perhaps take a
look at the following for configuration hints:
https://www.kernel.org/doc/html/latest/process/email-clients.html


> I just update the diffstat info and resend it
> in plain text. There is no difference in patch. Sorry to make you
> confused, please ignore the former one.

Didn't you also change the patch description? That would usually be a
reason to increment the patch version.


> >> diff -uprN linux-4.16.2_org/arch/arm64/include/asm/debug-monitors.h linux-4.16.2_mod/arch/arm64/include/asm/debug-monitors.h
> >> --- linux-4.16.2_org/arch/arm64/include/asm/debug-monitors.h?? ?2018-04-12 18:30:01.000000000 +0800
> >> +++ linux-4.16.2_mod/arch/arm64/include/asm/debug-monitors.h?? ?2018-04-19 00:19:10.134999268 +0800
> >> @@ -135,6 +135,9 @@ static inline int reinstall_suspended_bp
> >> ?
> >> ?int aarch32_break_handler(struct pt_regs *regs);
> >> ?
> >> +void set_regs_spsr_ss(struct pt_regs *regs);
> >> +void clear_regs_spsr_ss(struct pt_regs *regs);

Why do we need to bring out clear_regs_spsr_ss()?  It does not seem to 
be being used.


> >> @@ -252,7 +253,7 @@ static int kgdb_step_brk_fn(struct pt_re
> >> ??? ?if (!kgdb_single_step)
> >> ??? ??? ?return DBG_HOOK_ERROR;
> >> ?
> >> -?? ?kgdb_handle_exception(1, SIGTRAP, 0, regs);
> >> +?? ?kgdb_handle_exception(0, SIGTRAP, 0, regs);

Based on a quick glance this change looks sensible to me, but I don't
think it was mentioned clearly in the patch header.


Daniel.
