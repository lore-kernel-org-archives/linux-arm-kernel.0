From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Oct 2015 11:44:58 +0100
Subject: [PATCH v2 4/5] drivers: firmware: psci: add extended stateid
 power_state support
In-Reply-To: <3982126.UybqODJKJo@wuerfel>
References: <1436375811-10529-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1436375811-10529-5-git-send-email-lorenzo.pieralisi@arm.com>
 <CAMAWPa9ZLGidg3r8RJY9MANdmjPdJ07S7mmixQBf_g3YPce1_g@mail.gmail.com>
 <3982126.UybqODJKJo@wuerfel>
Message-ID: <20151023104457.GA9309@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 12:23:53PM +0200, Arnd Bergmann wrote:
> On Thursday 22 October 2015 15:07:06 Kevin Hilman wrote:
> > On Wed, Jul 8, 2015 at 10:16 AM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > PSCI v1.0 augmented the power_state parameter format specification
> > > (extended stateid) and introduced a way to probe it through the
> > > PSCI_FEATURES interface.
> > >
> > > This patch implements code that detects the power_state format at
> > > run-time through the PSCI_FEATURES interface, so that the power_state
> > > argument can be properly detected and validated in the kernel according
> > > to the information provided through firmware.
> > >
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > 
> > kernelci.org started finding a new boot failures in the arm-soc tree
> > on arm64 qemu[1] and it was bisected down to this patch, which is in
> > arm-soc in the form of commit a5c00bb28da0 (drivers: firmware: psci:
> > add extended stateid power_state support)
> > 
> > The patch doesn't revert cleanly, so I didn't dig much further, but
> > this suggests that some more testing on qemu is needed (or does qemu
> > need to be upgraded?)
> > 
> > Kevin
> > 
> > [1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.3-rc5-557-g159ca7e43189/
> > 
> 
> Could it be that qemu claims to support psci-1.0 but is actually not
> compatible?

Yes, the problem is, PSCI functions that are not implemented must return
NOT_SUPPORTED according to the SMC calling convention and the PSCI
spec. The KVM implementation was not compliant and we patched the
kernel already:

commit e2d997366dc5b ("ARM: kvm: psci: fix handling of unimplemented
functions")

So the KVM PSCI implementation is fine now.

Problem with Qemu emulation is that it does not emulate the PSCI 1.0
specs correctly (it does not even consider PSCI 1.0 functions proper PSCI
calls), I tested it and I think we should update Qemu as we
did with KVM kernel code instead of working around it by dodging the
problem in the PSCI implementation by adding code that checks the
PSCI version before issuing the PSCI calls through the respective
conduit.

Thoughts appreciated.

Thanks,
Lorenzo
