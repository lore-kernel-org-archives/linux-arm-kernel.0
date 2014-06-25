From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 25 Jun 2014 10:09:54 -0500
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <53AAE41C.1010103@arm.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
 <53A9D14D.2020802@amd.com>
 <CAFEAcA-8vOz34NPPqkh1trU5C1irGatcJjAr1f-wWEPzhpy95w@mail.gmail.com>
 <53AAE31C.2060506@amd.com> <53AAE41C.1010103@arm.com>
Message-ID: <53AAE642.7030704@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/25/2014 10:00 AM, Marc Zyngier wrote:
> On 25/06/14 15:56, Joel Schopp wrote:
>> On 06/24/2014 05:28 PM, Peter Maydell wrote:
>>> On 24 June 2014 20:28, Joel Schopp <joel.schopp@amd.com> wrote:
>>>> On 06/19/2014 04:21 AM, Marc Zyngier wrote:
>>>>> The GIC CPU interface is always 4k aligned. If the host is using
>>>>> 64k pages, it is critical to place the guest's GICC interface at the
>>>>> same relative alignment as the host's GICV. Failure to do so results
>>>>> in an impossibility for the guest to deal with interrupts.
>>>>>
>>>>> Add a KVM_DEV_ARM_VGIC_GRP_ADDR_OFFSET attribute for the VGIC, allowing
>>>>> userspace to retrieve the GICV offset in a page. It becomes then trivial
>>>>> to adjust the GICC base address for the guest.
>>>> Does this mean there is a corresponding patch for qemu?
>>> Not as far as I know. It's a bit awkward on the QEMU end because
>>> we really want to provide the guest a consistent memory map
>>> regardless of the host CPU. So at best we'd probably use it to
>>> say "sorry, can't run on this CPU/host kernel".
>> I think most arm64 servers are going to run with 64k pages.  It seems
>> like a major problem to have qemu not work on these systems.
> How many of them will be with the GICC *not* 64kB aligned?

If I'm reading the Server Base System Architecture v2.2 Appendix F 
correctly all of them.  Here's the relevant quote: "In a 64KB 
translation granule system this means that GICC needs to have its base 
at 4KB below a 64KB boundary."
>
>>> (That said, if you think you can make QEMU usefully use the
>>> information and want to write a QEMU patch I'm not averse
>>> to the idea.)
>> I'll have to think about this approach some more, but I'm not opposed to
>> doing the work if I thought it was the right thing to do.
>>
>>> kvmtool is probably better placed to take advantage of it since
>>> it takes more of a "deal with what the host provides you"
>>> philosophy.
>> kvmtool is fun as a play toy, but in the real world nobody is building
>> clouds using kvmtool, they use kvm with qemu.
> A play toy? Hmmm. Do you realise that most of KVM on arm64 has been
> written using this play toy?

I meant no insult.  I really like kvmtool.  I'm just saying that the 
eventual end users of these systems will want to run qemu and not kvmtool.
