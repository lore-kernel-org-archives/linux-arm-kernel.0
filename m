From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Apr 2015 10:10:47 +0200
Subject: [PATCH v2 06/10] KVM: arm64: guest debug, add SW break point
 support
In-Reply-To: <87tww0qqh9.fsf@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
 <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
 <87wq0wr6dd.fsf@linaro.org>
 <CAFEAcA85i_1JybEFBg91NA3-LpAzYh4RSDnqryOd=rZN7gZP5A@mail.gmail.com>
 <20150428125645.GA4137@cbox> <87tww0qqh9.fsf@linaro.org>
Message-ID: <20150429081047.GB4137@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 03:37:01PM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Tue, Apr 28, 2015 at 10:34:12AM +0100, Peter Maydell wrote:
> >> On 28 April 2015 at 09:42, Alex Benn?e <alex.bennee@linaro.org> wrote:
> >> > Peter Maydell <peter.maydell@linaro.org> writes:
> >> >> Does the kernel already have a conveniently implemented "inject
> >> >> exception into guest" lump of code? If so it might be less effort
> >> >> to do it that way round, maybe.
> >> >
> >> > So you pointed out we can't just re-inject the exceptions we get as we
> >> > need to map from things like ESR_ELx_EC_WATCHPT_LOW to
> >> > ESR_ELx_EC_WATCHPT_CUR before re-injection.
> >> >
> >> > Of course if it is as simple as modifying the ESR_EL1 register and
> >> > returning +ve in the handle_exit path then I can do that but I assumed
> >> > if any other wrangling needs doing it should be done in userspace.
> >> 
> >> Well, somebody's got to do it, and it's the same amount of work
> >> either way (fiddling with ESR, making sure we direct the guest
> >> to the right exception vector entry point, maybe a few other
> >> things).
> >> 
> > We already have code in the kernel to inject data/instruction aborts,
> > but not sure how much benefit there is in re-using that.  It's up to you
> > really, but I think the kernel code should be clear about what the
> > intention is so that we don't end up in a situation where: (1) The
> > intended behavior is unclear/vague, and (2) it doesn't actually work in
> > practice so nobody can follow the code.
> 
> Certainly there are some cases where the kernel doesn't have all the
> information. For example it doesn't know if the soft break was inserted
> by the guest or the host. That to me favours the "let userspace deal
> with the ugly" approach.
> 
Not sure I follow.

If it's an exception for the guest, then that must be because the guest
put in the breakpoint instruction, right?

However, that's a separate discussion from that of *how* userspace or
the kernel then injects an exception to the guest.

By using some QEMU TCG functionality or by QEMU calling back into KVM
and asking it to inject an exception for it.

What am I missing?

-Christoffer
