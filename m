From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Oct 2013 15:15:18 +0100
Subject: [PATCH] arm64: perf: add support for percpu pmu interrupt
In-Reply-To: <CAPrCYkdyCSEcUvQ4y-62wvQvuffaN+kJrzq8H-n87_SMEANjUQ@mail.gmail.com>
References: <1381733189-2745-1-git-send-email-vkale@apm.com>
 <20131014123436.GA10491@mudshark.cambridge.arm.com>
 <CAPrCYkc-ocBi6B6MP23gHqsovgQovvEWSv=khstS4wbD2dXzjw@mail.gmail.com>
 <20131015092149.GA30046@mudshark.cambridge.arm.com>
 <CAPrCYkdyCSEcUvQ4y-62wvQvuffaN+kJrzq8H-n87_SMEANjUQ@mail.gmail.com>
Message-ID: <20131016141517.GI5403@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 12:54:57PM +0100, Vinayak Kale wrote:
> On Tue, Oct 15, 2013 at 2:51 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > A better way to do this is to try request_percpu_irq first. If that fails,
> >> > then try request_irq. However, the error reporting out of request_percpu_irq
> >> > could do with some cleanup (rather than just return -EINVAL) so we can
> >> > detect the difference between `this interrupt isn't per-cpu' and `this
> >> > per-cpu interrupt is invalid'. This can help us avoid the WARN_ON in
> >> > request_irq when it is passed a per-cpu interrupt.
> >> >
> >>
> >> Trying request_percpu_irq first seems better. But if it fails then we
> >> would straight away
> >> assume it's not per-cpu interrupt and try request_irq. In this case we
> >> may not be able to
> >> detect 'this per-cpu interrupt is invalid' case.
> >
> > Right, but you could have a patch to fix the core code as part of this
> > series, as I hinted at above.
> >
> 
> Modifying core code to change return value of request_percpu_irq seems
> risky as other drivers might be checking the error code.

Well, grepping for "request_percpu_irq" shows a handful of callers, which
doesn't look too onerous to audit.

> As you said, passing invalid ppi to request_irq would cause unwanted
> WARN_ON. But this would be rare case and platform specific. Can we
> just live with this WARN_ON in such rare cases?

Just fix the fundamental problem rather than paper over it.

Will
