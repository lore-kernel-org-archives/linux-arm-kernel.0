From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 May 2017 11:58:32 +0100
Subject: [PATCH v2 2/2] arm64: Add dump_backtrace() in show_regs
In-Reply-To: <20170524100949.GA24574@leverpostej>
References: <20170508145535.GF5480@leverpostej>
 <1494294817-29187-1-git-send-email-wangkefeng.wang@huawei.com>
 <1494294817-29187-2-git-send-email-wangkefeng.wang@huawei.com>
 <20170524100949.GA24574@leverpostej>
Message-ID: <20170525105832.GA2859@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 11:09:49AM +0100, Mark Rutland wrote:
> On Tue, May 09, 2017 at 09:53:37AM +0800, Kefeng Wang wrote:
> > Generic code expects show_regs() to dump the stack, but arm64's
> > show_regs() does not. This makes it hard to debug softlockups and
> > other issues that result in show_regs() being called.
> > 
> > This patch updates arm64's show_regs() to dump the stack, as common
> > code expects.
> > 
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

[...]

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0805b44..f452fcc 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -728,8 +728,6 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
>                 break;
>  
>         case BUG_TRAP_TYPE_WARN:
> -               /* Ideally, report_bug() should backtrace for us... but no. */
> -               dump_backtrace(regs, NULL);
>                 break;
>  
>         default:
> 
> ... since report_bug() will call show_regs(), and dump the stack itself
> now.
> 
> With that change, these patches will also fix *_ONCE() traps spewing
> backtraces every time they're invoked, which was a side-effect of
> commit:
> 
>   19d436268dde9538 ("debug: Add _ONCE() logic to report_bug()")
> 
> Would you mind folding that into a v3?

I've queued this locally, so I can just fold that in too. No need to repost.

I'll push what I have at -rc3.

Cheers,

Will
