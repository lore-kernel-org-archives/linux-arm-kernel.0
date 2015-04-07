From: bp@alien8.de (Borislav Petkov)
Date: Tue, 7 Apr 2015 18:37:46 +0200
Subject: [RESEND PATCH 4.0-rc5 v19 5/6] x86/nmi: Use common printk
 functions
In-Reply-To: <20150407121942.627d2165@gandalf.local.home>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-1-git-send-email-daniel.thompson@linaro.org>
 <1428421083-9137-6-git-send-email-daniel.thompson@linaro.org>
 <20150407121942.627d2165@gandalf.local.home>
Message-ID: <20150407163746.GA14115@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 12:19:42PM -0400, Steven Rostedt wrote:
> Not sure what the others think, but I hate this polish notation for
> compares. One does not say "if zero does not equal
> printk_nmi_backtrace_prepare()", they say "if
> printk_nmi_backtrace_prepare() does not return zero".
> 
> And the reason for polish notation is to prevent the:
> 
> 	if (x = 0)
> 
> mistake. Which gcc warns about anyway. Also, this doesn't even pertain
> to this code because:
> 
> 	if (printk_nmi_backtrace_prepare() = 0)
> 
> would fail to compile.

I would simply say:

	err = printk_nmi_backtrace_prepare();
	if (err)

like sane kernel code does.

Besides, there's not a lot of such comparisons in the kernel anyway:

$ git grep -E "if\s+\(+[0-9]+\!?=.*"
drivers/ide/au1xxx-ide.c:246:                   if (1==i)

but my regex doesn't cover all possible variants, just the single-line
ones.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
