From: agraf@suse.de (Alexander Graf)
Date: Mon, 14 Oct 2013 15:10:26 +0200
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525BEBB4.4050603@redhat.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com>
Message-ID: <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 14.10.2013, at 15:03, Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 11/10/2013 16:36, Marc Zyngier ha scritto:
>> This small patch series adds just enough kernel infrastructure and
>> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
>> that the host actually supports such madness.
> 
> More precisely, it allows the guest drivers to pick the endianness they
> prefer.  Mixed-endian virtio works fine on QEMU with e.g. a mips guest
> in emulation mode, because then any given QEMU binary will always use
> the same endianness (e.g. big for qemu-system-mips).

We have the same problem (runtime switchable endianness) on PowerPC. IBM POWER is gaining Little Endian support in Linux now, so we could easily end up with an LE guest on a BE host.

IIRC the way we're going to solve this is to hack up virtio_is_big_endian() to evaluate the first CPU's endianness mode (which will always be the same as all other CPU's endianness mode due to hypercall restrictions).

You could do the same with ARM if you need to support guest kernels before the new virtio stuff is there. LE POWER is definitely already reality upstream.


Alex
