From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Dec 2015 13:16:59 +0000
Subject: [PATCH] arm64: ftrace: stop using kstop_machine to
 enable/disable tracing
In-Reply-To: <20151202123654.GC4523@arm.com>
References: <1448697009-17211-1-git-send-email-huawei.libin@huawei.com>
 <20151202123654.GC4523@arm.com>
Message-ID: <20151202131659.GA5621@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 12:36:54PM +0000, Will Deacon wrote:
> On Sat, Nov 28, 2015 at 03:50:09PM +0800, Li Bin wrote:
> > On arm64, kstop_machine which is hugely disruptive to a running
> > system is not needed to convert nops to ftrace calls or back,
> > because that modifed code is a single 32bit instructions which
> > is impossible to cross cache (or page) boundaries, and the used str
> > instruction is single-copy atomic.
> 
> This commit message is misleading, since the single-copy atomicity
> guarantees don't apply to the instruction-side. Instead, the architecture
> calls out a handful of safe instructions in "Concurrent modification and
> execution of instructions".
> 
> Now, those safe instructions *do* include NOP, B and BL, so that should
> be sufficient for ftrace provided that we don't patch condition codes
> (and I don't think we do).

Thinking about this some more, you also need to fix the validate=1 case
in ftrace_modify_code so that it can run outside of stop_machine. We
currently rely on that to deal with concurrent modifications (e.g.
module unloading).

Will
