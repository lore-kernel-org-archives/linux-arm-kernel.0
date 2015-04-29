From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Apr 2015 12:38:14 +0200
Subject: [PATCH v2 06/10] KVM: arm64: guest debug, add SW break point
 support
In-Reply-To: <87r3r31eed.fsf@linaro.org>
References: <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
 <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
 <87wq0wr6dd.fsf@linaro.org>
 <CAFEAcA85i_1JybEFBg91NA3-LpAzYh4RSDnqryOd=rZN7gZP5A@mail.gmail.com>
 <20150428125645.GA4137@cbox> <87tww0qqh9.fsf@linaro.org>
 <20150429081047.GB4137@cbox> <87r3r31eed.fsf@linaro.org>
Message-ID: <20150429103814.GC4137@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 10:18:18AM +0100, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > On Tue, Apr 28, 2015 at 03:37:01PM +0100, Alex Benn?e wrote:
> >> 
> >> Christoffer Dall <christoffer.dall@linaro.org> writes:
> >> 
> >> > On Tue, Apr 28, 2015 at 10:34:12AM +0100, Peter Maydell wrote:
> >> >> On 28 April 2015 at 09:42, Alex Benn?e <alex.bennee@linaro.org> wrote:
> >> >> > Peter Maydell <peter.maydell@linaro.org> writes:
> >> >> >> Does the kernel already have a conveniently implemented "inject
> >> >> >> exception into guest" lump of code? If so it might be less effort
> >> >> >> to do it that way round, maybe.
> >> >> >
> >> >> > So you pointed out we can't just re-inject the exceptions we get as we
> >> >> > need to map from things like ESR_ELx_EC_WATCHPT_LOW to
> >> >> > ESR_ELx_EC_WATCHPT_CUR before re-injection.
> >> >> >
> >> >> > Of course if it is as simple as modifying the ESR_EL1 register and
> >> >> > returning +ve in the handle_exit path then I can do that but I assumed
> >> >> > if any other wrangling needs doing it should be done in userspace.
> >> >> 
> >> >> Well, somebody's got to do it, and it's the same amount of work
> >> >> either way (fiddling with ESR, making sure we direct the guest
> >> >> to the right exception vector entry point, maybe a few other
> >> >> things).
> >> >> 
> >> > We already have code in the kernel to inject data/instruction aborts,
> >> > but not sure how much benefit there is in re-using that.  It's up to you
> >> > really, but I think the kernel code should be clear about what the
> >> > intention is so that we don't end up in a situation where: (1) The
> >> > intended behavior is unclear/vague, and (2) it doesn't actually work in
> >> > practice so nobody can follow the code.
> >> 
> >> Certainly there are some cases where the kernel doesn't have all the
> >> information. For example it doesn't know if the soft break was inserted
> >> by the guest or the host. That to me favours the "let userspace deal
> >> with the ugly" approach.
> >> 
> > Not sure I follow.
> >
> > If it's an exception for the guest, then that must be because the guest
> > put in the breakpoint instruction, right?
> 
> No the host can add breakpoint instructions as well. They both generate
> the same (redirected) exception to the hypervisor which then has to
> figure out who planted the breakpoint and where the eventual exception
> will be handled.

I understand this; let's just rewind here.

If you've concluded that the exception is for the guest, then the guest
must have placed the breakpoint instruction there, correct?  Otherwise,
the exception is for the hypervisor and the discussion about how to
inject an exception for the guest is invalid.

Or are you talking about the corner case where the host uses a soft
breakpoint to get a breakpoint on an instruction which is also a
breakpoint in the guest?

> 
> > However, that's a separate discussion from that of *how* userspace or
> > the kernel then injects an exception to the guest.
> >
> > By using some QEMU TCG functionality or by QEMU calling back into KVM
> > and asking it to inject an exception for it.
> 
> I don't know if there is explicit TCG functionality to use but QEMU can
> set the registers and PC up for exception entry and re-enter KVM.
> 

I also understand this.  I think Peter's point was exactly that if we
have existing code somewhere which we can reuse, then we should consider
reusing it.

Again, I don't care particularly which way, I just want the expected
working behavior to be clearly defined.

-Christoffer
