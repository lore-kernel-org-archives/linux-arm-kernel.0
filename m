From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Feb 2014 11:46:38 +0000
Subject: [PATCH v2 2/3] ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
In-Reply-To: <CAMwBHsbQ_5tGNuHC=OBs7+CxZ4xJ-s6HHEX04ZKo4FtofpgGgA@mail.gmail.com>
References: <1391078479-7406-1-git-send-email-anup.patel@linaro.org>
 <1391078479-7406-3-git-send-email-anup.patel@linaro.org>
 <20140203105409.GF30209@e106331-lin.cambridge.arm.com>
 <CAMwBHsbQ_5tGNuHC=OBs7+CxZ4xJ-s6HHEX04ZKo4FtofpgGgA@mail.gmail.com>
Message-ID: <20140203114638.GA2784@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 11:16:35AM +0000, Anup Patel wrote:
> Hi Mark,

Hi Anup,

> On Mon, Feb 3, 2014 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jan 30, 2014 at 10:41:18AM +0000, Anup Patel wrote:
> >> Currently, the in-kernel PSCI emulation provides PSCI v0.1 interface to
> >> VCPUs. This patch extends current in-kernel PSCI emulation to provide
> >> PSCI v0.2 interface to VCPUs.
> >>
> >> By default, ARM/ARM64 KVM will always provide PSCI v0.1 interface for
> >> keeping the ABI backward-compatible.
> >>
> >> To select PSCI v0.2 interface for VCPUs, the user space (i.e. QEMU or
> >> KVMTOOL) will have to set KVM_ARM_VCPU_PSCI_0_2 feature when doing VCPU
> >> init using KVM_ARM_VCPU_INIT ioctl.
> >
> > I have an issue with this. PSCI 0.2 makes all but two functions (MIGRATE
> > and MIGRATE_INFO_CPU_UP) mandatory, and hence not allowed to return
> > NOT_SUPPORTED.
> >
> > Additionally, for correct behaviour across a kexec in future, we'll
> > require AFFINITY_INFO for PSCI 0.2+ systems to determint when a CPU is
> > actually dead (and cannot affect the cache hierarchy). I'd very much
> > like to make that a hard requirement to ensure correctness.
> >
> > I would very much like to see at least trivial implementations of those
> > mandatory functions, so that we don't need a
> > KVM_ARM_VCPU_PSCI_REALLY_0_2 or similar in future. As it stands this
> > series does not implement PSCI 0.2.
> 
> The intention behind this series was to provide a base implementation of
> PSCI v0.2 which can be extended by subsequent patches that implement
> other PSCI v0.2 functions.

I understand your intention, however I disagree with the approach.

This exposes the implementation to userspace before _mandatory_
functionality is present. This exposes a feature flag to userspace
advertising functionality which is not present, and violates the PSCI
0.2 specification.

Userspace will check if the functionality is present, and then advertise
it to whatever kernel it wants to run with KVM. However, as _mandatory_
functionality is missing, the guest cannot use the information, and must
assume that the PSCI implementation violates the spec. This is broken.

The only things that this series does is change the set of IDs in use,
and add PSCI_VERSION. Worse, PSCI_VERSION lies, because the mandatory
functionality isn't present. Guests requiring PSCI 0.2 don't get
everything they need, and existing supported guests work with the
existing function IDs, so _nothing_ of value is added.

We also haven't got the PSCI 0.2 binding finalised, so no guest can even
make use of the PSCI_VERSION call. The only apparent change of the
series is therefore to rearrange some IDs. This holds _no_ value.

The only sane thing to do is to implement the mandatory functionality
before exposing it.

The only way to make that work would be to later add more flags stating
that we _really_ have PSCI 0.2 support, and then have userspace use that
to figure out when to advertise PSCI 0.2 support to a guest. So
_nothing_ can make use of the flag as it currently stands.

Thanks,
Mark.
