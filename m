From: will.deacon@arm.com (Will Deacon)
Date: Tue, 20 Aug 2013 14:12:45 +0100
Subject: [PATCH] AArch64: Add single-step and breakpoint handler hooks
In-Reply-To: <CA+b37P11oFTo8SHWMB8ijy__sqj5HXBPXWd-svkTK3bPTeARuA@mail.gmail.com>
References: <1375769526-3526-1-git-send-email-sandeepa.prabhu@linaro.org>
 <20130813113253.GF30280@mudshark.cambridge.arm.com>
 <CA+b37P11oFTo8SHWMB8ijy__sqj5HXBPXWd-svkTK3bPTeARuA@mail.gmail.com>
Message-ID: <20130820131245.GC26129@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 03:45:30PM +0100, Sandeepa Prabhu wrote:
> On 13 August 2013 17:02, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Aug 06, 2013 at 07:12:06AM +0100, Sandeepa Prabhu wrote:
> >> +     cmp     x24, #ESR_EL1_EC_WATCHPT_EL1
> >> +     csel    x0, x25, x22, eq        //addr: x25->far_el1, x22->elr_el1
> >> +     b.ge    do_dbg
> >>       tbz     x24, #0, el1_inv                // EL1 only
> >
> > I'd rather you left the tbz as the first instruction in el1_dbg, then you
> > can also lose the b.ge.
> well, my understanding is that the tbz check is needed only for
> Exception Class < 0x35 as per debug spec. If this is true, and if tbz
> is first instruction, it fails for breakpoint (EC=0x3A) case and call
> el1_inv to panic instead of routing to do_debug_exception. I am not
> sure if we can optimize the code further to eliminate this one
> branching as well.

Well, you're actually only interested in 0x3c (BRK instruction executed in
AArch64 state), so you should check for that explicitly. I guess it doesn't
matter where you check bit #0 first or not, provided you have the branch
logic correct.

Will
