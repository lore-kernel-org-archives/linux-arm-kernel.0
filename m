From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 23 Dec 2013 16:32:09 +0100
Subject: [PATCH v4 15/16] ARM: add uprobes support
In-Reply-To: <1387564464.3404.106.camel@linaro1.home>
References: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
 <1387166930-13182-16-git-send-email-dave.long@linaro.org>
 <1387564464.3404.106.camel@linaro1.home>
Message-ID: <20131223153209.GA27754@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20, Jon Medhurst (Tixy) wrote:
>
> On Sun, 2013-12-15 at 23:08 -0500, David Long wrote:
> > From: "David A. Long" <dave.long@linaro.org>
> >
> > Caveats:
> >
> >  - Thumb is not supported
> >  - XOL abort/trap handling is not implemented
>
> I shall repeat my comment from version one of the patch...
>
> What are the consequences of this, e.g. is it possible for a probe to
> get stuck in an infinite loop of faulting? I hope there are no integrity
> issues for the kernel itself.

Unless there is something arm-specific, the kernel should be fine. The
task should notice a signal after handle_singlestep() before it returns
to the user-mode.

But of course the probed application can be confused. And I have no idea
what arm does if, say, a single-stepped xol insn triggers the page fault.
We need to change instruction_pointer() back to the faulted (probed) insn
if the page fault fails. But since because arch_uprobe_xol_was_trapped()
is not implemented this won't happen.

Oleg.
