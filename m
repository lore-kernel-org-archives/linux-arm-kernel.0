From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Dec 2012 13:06:27 +0000
Subject: [PATCH v4 13/14] KVM: ARM: Handle guest faults in KVM
In-Reply-To: <CANM98qLNMTw5DGBJLPhXrMs_p5mvphxiEisrz4pLnMFpmm_eCQ@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154342.2836.9669.stgit@chazy-air>
 <20121119150737.GE3205@mudshark.cambridge.arm.com>
 <CANM98qLNMTw5DGBJLPhXrMs_p5mvphxiEisrz4pLnMFpmm_eCQ@mail.gmail.com>
Message-ID: <20121203130627.GA20074@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 09:40:37PM +0000, Christoffer Dall wrote:
> On Mon, Nov 19, 2012 at 10:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > Why are PIPT caches affected by this? The virtual address is irrelevant.
> >
> 
> The comment is slightly misleading, and I'll update it. Just so we're
> clear, this is the culprit:
> 
> 1. guest uses page X, containing instruction A
> 2. page X gets swapped out
> 3. host uses page X, containing instruction B
> 4. instruction B enters i-cache at page X's cache line
> 5. page X gets swapped out
> 6. guest swaps page X back in
> 7. guest executes instruction B from cache, should execute instruction A

Ok, that's clearer. Thanks for the explanation.

> The point is that with PIPT we can flush only that page from the
> icache using the host virtual address, as the MMU will do the
> translation on the fly. In the VIPT we have to nuke the whole thing
> (unless we .

Unless we what? Could we flush using the host VA + all virtual aliases
instead?

> >> +        * (or another VM) may have used this page at the same virtual address
> >> +        * as this guest, and we read incorrect data from the icache.  If
> >> +        * we're using a PIPT cache, we can invalidate just that page, but if
> >> +        * we are using a VIPT cache we need to invalidate the entire icache -
> >> +        * damn shame - as written in the ARM ARM (DDI 0406C - Page B3-1384)
> >> +        */
> >> +       if (icache_is_pipt()) {
> >> +               unsigned long hva = gfn_to_hva(kvm, gfn);
> >> +               __cpuc_coherent_user_range(hva, hva + PAGE_SIZE);
> >> +       } else if (!icache_is_vivt_asid_tagged()) {
> >> +               /* any kind of VIPT cache */
> >> +               __flush_icache_all();
> >> +       }
> >
> > so what if it *is* vivt_asid_tagged? Surely that necessitates nuking the
> > thing, unless it's VMID tagged as well (does that even exist?).
> >
> 
> see page B3-1392 in the ARM ARM, if it's vivt_asid_tagged it is also
> vmid tagged.

Great.

> >> +               write_fault = false;
> >> +       else
> >> +               write_fault = true;
> >> +
> >> +       if (fault_status == FSC_PERM && !write_fault) {
> >> +               kvm_err("Unexpected L2 read permission error\n");
> >> +               return -EFAULT;
> >> +       }
> >> +
> >> +       /* We need minimum second+third level pages */
> >> +       ret = mmu_topup_memory_cache(memcache, 2, KVM_NR_MEM_OBJS);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       mmu_seq = vcpu->kvm->mmu_notifier_seq;
> >> +       smp_rmb();
> >
> > What's this barrier for and why isn't there a write barrier paired with
> > it?
> >
> 
> The read barrier is to ensure that mmu_notifier_seq is read before we
> call gfn_to_pfn_prot (which is essentially get_user_pages), so that we
> don't get a page which is unmapped by an MMU notifier before we grab
> the spinlock that we would never see. I also added a comment
> explaining it in the patch below.
> 
> There is a write barrier paired with it, see virt/kvm/kvm_main.c,
> specifically kvm_mmu_notifier_invalidate_page (the spin_unlock), and
> kvm_mmu_notifier_invalidate_range_end.

Ok, so it sounds like a homebrew seqlock implementatiom. Any reason KVM
isn't just using those directly?

Will
