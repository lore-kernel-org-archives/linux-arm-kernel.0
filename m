From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 20 Nov 2013 11:37:49 -0800
Subject: [PATCH] arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
In-Reply-To: <CAFEAcA8Eobge+o8FiQgUYZv7=rHBpbQOpa7Y36OS904v_-MMNA@mail.gmail.com>
References: <1384973499-30659-1-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA-b5CTMQLsYikHcExVDjy8BL3gnx=Z7f4jVGPCkJsD6Ew@mail.gmail.com>
 <20131120192102.GF9314@cbox>
 <CAFEAcA8Eobge+o8FiQgUYZv7=rHBpbQOpa7Y36OS904v_-MMNA@mail.gmail.com>
Message-ID: <20131120193749.GG9314@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 07:27:52PM +0000, Peter Maydell wrote:
> On 20 November 2013 19:21, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Wed, Nov 20, 2013 at 07:12:42PM +0000, Peter Maydell wrote:
> >> Tangential, but your phrasing prompted me to ask: how does
> >> the "start in PSCI power-off" boot protocol work for system reset?
> >> Since the kernel doesn't currently provide a "reset this v CPU"
> >> ioctl userspace has to do reset manually[*]; how do we say "take
> >> this vCPU which has started up and run once, and put it back
> >> into PSCI power-off" ?
> >>
> >> [*] this is pretty tedious, since it involves reading every CPU
> >> register on the vCPU before first run in order to feed the kernel
> >> back a bunch of info it already knows about the reset state of
> >> a vCPU.
> >>
> > So, from looking at the code and the API specification calling
> > KVM_ARM_VCPU_INIT does exactly this and also resets all core and cp15
> > registers for you - you would here be able to set the power-off flag and
> > pause those CPUs so PSCI can wake them up again.
> >
> > Am I missing something here?
> 
> Well, we call KVM_ARM_VCPU_INIT as part of our CPU init,
> but I didn't think you were allowed to call it a second time
> later on to do a CPU reset (ie as part of system reset when
> the guest asks for a system reset as part of 'shutdown -r now').
> Is that valid? If so, it would probably be good to specifically document it...
> 
I don't see anything technically preventing you from doing so nor
anything in the documentation telling you that you shouldn't be doing
it.

However, I agree that we haven't thought about this ioctl in that way so
far, but we can start doing that.  If nobody objects I can add a patch
that clarifies this in the api.txt documentation; I don't believe this
would break or change the API, it's merely clarifying the
recommendations on how user space can leverage the functionality.

-Christoffer
