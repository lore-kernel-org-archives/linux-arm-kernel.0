From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 24 Jun 2014 23:28:28 +0100
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <53A9D14D.2020802@amd.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
 <53A9D14D.2020802@amd.com>
Message-ID: <CAFEAcA-8vOz34NPPqkh1trU5C1irGatcJjAr1f-wWEPzhpy95w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2014 20:28, Joel Schopp <joel.schopp@amd.com> wrote:
>
> On 06/19/2014 04:21 AM, Marc Zyngier wrote:
>>
>> The GIC CPU interface is always 4k aligned. If the host is using
>> 64k pages, it is critical to place the guest's GICC interface at the
>> same relative alignment as the host's GICV. Failure to do so results
>> in an impossibility for the guest to deal with interrupts.
>>
>> Add a KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET attribute for the VGIC, allowing
>> userspace to retrieve the GICV offset in a page. It becomes then trivial
>> to adjust the GICC base address for the guest.
>
>
> Does this mean there is a corresponding patch for qemu?

Not as far as I know. It's a bit awkward on the QEMU end because
we really want to provide the guest a consistent memory map
regardless of the host CPU. So at best we'd probably use it to
say "sorry, can't run on this CPU/host kernel".

(That said, if you think you can make QEMU usefully use the
information and want to write a QEMU patch I'm not averse
to the idea.)

kvmtool is probably better placed to take advantage of it since
it takes more of a "deal with what the host provides you"
philosophy.

thanks
-- PMM
