From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 15 Oct 2018 14:04:43 +0200
Subject: [PATCH V4 00/15] x86/KVM/Hyper-v: Add HV ept tlb range flush
 hypercall support in KVM
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
Message-ID: <d9414a38-ca5c-4273-30dc-1fecd0f9268e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/2018 16:53, lantianyu1986 at gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> For nested memory virtualization, Hyper-v doesn't set write-protect
> L1 hypervisor EPT page directory and page table node to track changes 
> while it relies on guest to tell it changes via HvFlushGuestAddressLlist
> hypercall. HvFlushGuestAddressLlist hypercall provides a way to flush
> EPT page table with ranges which are specified by L1 hypervisor.
> 
> If L1 hypervisor uses INVEPT or HvFlushGuestAddressSpace hypercall to
> flush EPT tlb, Hyper-V will invalidate associated EPT shadow page table
> and sync L1's EPT table when next EPT page fault is triggered.
> HvFlushGuestAddressLlist hypercall helps to avoid such redundant EPT
> page fault and synchronization of shadow page table.

So I just told you that the first part is well understood but I must
retract that; after carefully reviewing the whole series, I think one of
us is actually very confused.

I am not afraid to say it can be me, but my understanding is that you're
passing L1 GPAs to the hypercall and instead the spec says it expects L2
GPAs.  (Consider that, because KVM's shadow paging code is shared
between nested EPT and !EPT cases, every time you see gpa/gfn in the
code it is for L1, while nested EPT GPAs are really what the code calls
gva.)

What's going on?

Paolo
