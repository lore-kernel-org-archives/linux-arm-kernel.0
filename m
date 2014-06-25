From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 25 Jun 2014 18:34:55 +0100
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <53AAE31C.2060506@amd.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
 <53A9D14D.2020802@amd.com>
 <CAFEAcA-8vOz34NPPqkh1trU5C1irGatcJjAr1f-wWEPzhpy95w@mail.gmail.com>
 <53AAE31C.2060506@amd.com>
Message-ID: <CAFEAcA-5CaE6T2JkNdf7M9t3LTqv05Um-nWbWjSDVbu_Bo+a2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2014 15:56, Joel Schopp <joel.schopp@amd.com> wrote:
> On 06/24/2014 05:28 PM, Peter Maydell wrote:
>> On 24 June 2014 20:28, Joel Schopp <joel.schopp@amd.com> wrote:
>>> Does this mean there is a corresponding patch for qemu?
>>
>> Not as far as I know. It's a bit awkward on the QEMU end because
>> we really want to provide the guest a consistent memory map
>> regardless of the host CPU. So at best we'd probably use it to
>> say "sorry, can't run on this CPU/host kernel".
>
> I think most arm64 servers are going to run with 64k pages.  It seems like a
> major problem to have qemu not work on these systems.

QEMU should already work fine on servers with 64K pages;
you just need to have the host offset of the GICV within the 64K page
and the guest offset of the GICC within the 64K page be the same
(and at the moment both must also be zero, which I believe is true
for all of them at the moment except possibly the AEM model;
counterexamples welcome). Disclaimer: I haven't personally
tested this, but on the other hand I don't think anybody's
reported it as not working either.

Notice that we don't care at all about the host's GICC offset,
because it's the GICV we're going to use as the guest GICC.

That said, yes, QEMU ought really to be able to provide
support for "use what the host provides", in the same way
that we support "-cpu host" to mean 'virtualize whatever CPU
the host has'. It's just a little awkward because you're working
against the grain of some of QEMU's design; but it ought
to be usable for things like the "virt" machine model.

For the cases where QEMU is being used to emulate
specific hardware to the guest (which we don't do right
now because we don't model any 64 bit boards other than
virt), we could use this ioctl to say "can't run this guest
on this host"; this is basically diagnosing a case in the
same class as "can't run a guest with a GICv2 if your
host's GICv3 doesn't implement v2 compatibility mode".

thanks
-- PMM
