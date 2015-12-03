From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 3 Dec 2015 10:07:50 -0500
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151203114823.GC11337@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <20151202131659.GA5621@arm.com>
 <56600DEC.7050703@huawei.com> <20151203114823.GC11337@arm.com>
Message-ID: <20151203100750.1d612e1b@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Dec 2015 11:48:24 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hmm, so this should all be fine if we exclusively use the probe_kernel_*
> functions and handle the -EFAULT gracefully. Now, that leaves an
> interesting scenario with the flush_icache_range call in
> aarch64_insn_patch_text_nosync, since that's not run with
> KERNEL_DS/pagefault_disable() and so we'll panic if the text disappears
> underneath us.

Nothing should remove the text from underneath you if everything
matches up fine before that. Module unloading will block on the
ftrace_lock if it has any functions that can be traced.

-- Steve


> 
> So we probably need to add that code and call __flush_cache_user_range
> instead.
> 
> What do you think?
> 
> Will
