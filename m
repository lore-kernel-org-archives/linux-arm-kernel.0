From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 3 Dec 2012 13:22:07 +0000
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
Message-ID: <CAFEAcA827i0RYShk+nV5_iSnqU_fF1nf8-YnUME9nD8Fj=JOtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2012 12:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> By far the largest part of the save/restore work here is figuring out
> what the right state to expose to userspace is so we can retain that
> compatibility guarantee.

Some further thoughts on this...

What we're really providing the guest here is a hardware-accelerated
software emulation of a no-virtualization GICv2. So it's better for
the state we expose to userspace to be the state of that emulated
hardware, and not to expose details of exactly what that hardware
acceleration is. The hw accel is a property of the host CPU,
not of the guest VM environment, so it could be different on
different kernels or host CPUs, which would make migration potentially
tedious. For instance, consider migration where the source machine
has a VGIC with more list registers than the destination machine.

Obviously you could convert between different representations
in a number of places (source kernel, source qemu, destination
qemu, destination kernel), but I think it makes sense for the
canonical representation to be the guest-visible representation
of the emulated hardware, rather than privileging any one
acceleration implementation above another.

-- PMM
