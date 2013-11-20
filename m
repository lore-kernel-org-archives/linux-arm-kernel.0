From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 20 Nov 2013 19:12:42 +0000
Subject: [PATCH] arm: KVM: Don't return PSCI_INVAL if waitqueue is inactive
In-Reply-To: <1384973499-30659-1-git-send-email-christoffer.dall@linaro.org>
References: <1384973499-30659-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <CAFEAcA-b5CTMQLsYikHcExVDjy8BL3gnx=Z7f4jVGPCkJsD6Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2013 18:51, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> Therefore, set the pause flag on the vcpu at VCPU init time (which can
> reasonably be expected to be completed for all CPUs by user space before
> running any VCPUs) and clear both this flag and the feature (in case the
> feature can somehow get set again in the future) and ping the waitqueue
> on turning on a VCPU using PSCI.

Tangential, but your phrasing prompted me to ask: how does
the "start in PSCI power-off" boot protocol work for system reset?
Since the kernel doesn't currently provide a "reset this v CPU"
ioctl userspace has to do reset manually[*]; how do we say "take
this vCPU which has started up and run once, and put it back
into PSCI power-off" ?

[*] this is pretty tedious, since it involves reading every CPU
register on the vCPU before first run in order to feed the kernel
back a bunch of info it already knows about the reset state of
a vCPU.

thanks
-- PMM
