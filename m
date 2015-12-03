From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Dec 2015 09:38:21 +0000
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <56600992.4040005@huawei.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com> <56600992.4040005@huawei.com>
Message-ID: <20151203093821.GD7023@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 05:21:22PM +0800, libin wrote:
> 
> on 2015/12/2 20:36, Will Deacon wrote:
> > On Sat, Nov 28, 2015 at 03:50:09PM +0800, Li Bin wrote:
> >> On arm64, kstop_machine which is hugely disruptive to a running
> >> system is not needed to convert nops to ftrace calls or back,
> >> because that modifed code is a single 32bit instructions which
> >> is impossible to cross cache (or page) boundaries, and the used str
> >> instruction is single-copy atomic.
> > This commit message is misleading, since the single-copy atomicity
> > guarantees don't apply to the instruction-side. Instead, the architecture
> > calls out a handful of safe instructions in "Concurrent modification and
> > execution of instructions".
> 
> Right, thank you for your comments.
> 
> > Now, those safe instructions *do* include NOP, B and BL, so that should
> > be sufficient for ftrace provided that we don't patch condition codes
> > (and I don't think we do).
> 
> Yes, and so far this assumption has no probem, but in order to avoid exceeding these
> safe insturctions in the future, we can use aarch64_insn_hotpatch_safe() to verify the
> instruction to determine whether needs stop_machine() to synchronize or use
> aarch64_insn_patch_text directly. Right or I am missing something?

I think you're missing the case where the instruction changes under our
feet after we've read it but before we've replaced it (e.g. due to module
unloading). I think that's why ftrace_modify_code has the comment about
lack of locking thanks to stop_machine.

Will
