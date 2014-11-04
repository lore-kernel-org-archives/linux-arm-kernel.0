From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Nov 2014 18:05:17 +0000
Subject: [PATCH v3 15/19] arm/arm64: KVM: add opaque private pointer to
 MMIO accessors
In-Reply-To: <54590BDA.3050609@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-16-git-send-email-andre.przywara@arm.com>
 <20141104154414.GN16132@cbox> <54590BDA.3050609@arm.com>
Message-ID: <5459155D.3070203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/14 17:24, Andre Przywara wrote:
> Hi,
> 
> On 04/11/14 15:44, Christoffer Dall wrote:
>> On Fri, Oct 31, 2014 at 05:26:50PM +0000, Andre Przywara wrote:
>>> For a GICv2 there is always only one (v)CPU involved: the one that
>>> does the access. On a GICv3 the access to a CPU redistributor is
>>> memory-mapped, but not banked, so the (v)CPU affected is determined by
>>> looking at the MMIO address region being accessed.
>>> To allow passing the affected CPU into the accessors, extend them to
>>> take an opaque private pointer parameter.
>>> For the current GICv2 emulation we ignore it and simply pass NULL
>>> on the call.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>
>> Why does it have to be an opaque private pointer?  Would it not always
>> be a struct vcpu * or a vcpu_id then?
> 
> IIRC Marc suggested this once be more future proof. Also a pointer makes
> it easier to pass NULL in the GICv2 parts of the code, which makes it
> more obvious that this value is not used in this case.
> 
> Marc, did I miss some more rationale?
> Does that still hold?

The main idea was to have a general purpose pointer that you can
associate with the decoded region. Some form of private context, just
like we have for a lot of other kernel structures.

Now, I think having that as a explicit pointer looks truly awful. Can't
that be folded into struct kvm_exit_mmio that is already passed around?
It would make some sense that the private context is associated with the
actual access... I haven't seen how that interacts with the GICv3 code
though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
