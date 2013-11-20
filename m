From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 20 Nov 2013 11:21:02 -0800
Subject: [PATCH] arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
In-Reply-To: <CAFEAcA-b5CTMQLsYikHcExVDjy8BL3gnx=Z7f4jVGPCkJsD6Ew@mail.gmail.com>
References: <1384973499-30659-1-git-send-email-christoffer.dall@linaro.org>
 <CAFEAcA-b5CTMQLsYikHcExVDjy8BL3gnx=Z7f4jVGPCkJsD6Ew@mail.gmail.com>
Message-ID: <20131120192102.GF9314@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 07:12:42PM +0000, Peter Maydell wrote:
> On 20 November 2013 18:51, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > Therefore, set the pause flag on the vcpu at VCPU init time (which can
> > reasonably be expected to be completed for all CPUs by user space before
> > running any VCPUs) and clear both this flag and the feature (in case the
> > feature can somehow get set again in the future) and ping the waitqueue
> > on turning on a VCPU using PSCI.
> 
> Tangential, but your phrasing prompted me to ask: how does
> the "start in PSCI power-off" boot protocol work for system reset?
> Since the kernel doesn't currently provide a "reset this v CPU"
> ioctl userspace has to do reset manually[*]; how do we say "take
> this vCPU which has started up and run once, and put it back
> into PSCI power-off" ?
> 
> [*] this is pretty tedious, since it involves reading every CPU
> register on the vCPU before first run in order to feed the kernel
> back a bunch of info it already knows about the reset state of
> a vCPU.
> 
So, from looking at the code and the API specification calling
KVM_ARM_VCPU_INIT does exactly this and also resets all core and cp15
registers for you - you would here be able to set the power-off flag and
pause those CPUs so PSCI can wake them up again.

Am I missing something here?

This makes me wonder if it's worth adding to
Documentation/virtual/kvm/api.txt that KVM_ARM_VCPU_INIT should be
called on all VCPUs before running any of the VCPUs...

-Christoffer
