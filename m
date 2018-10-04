From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 5 Oct 2018 01:09:33 +0530
Subject: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
In-Reply-To: <20181004122207.GE4065@arm.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
 <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
 <20181004122207.GE4065@arm.com>
Message-ID: <CAKTKpr4a12FHkMtFNueWqQbAhT4TLw_4DLDrOD6Tjsbno28U3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Oct 4, 2018 at 5:51 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ganapat,
>
> On Thu, Oct 04, 2018 at 11:12:09AM +0530, Ganapatrao Kulkarni wrote:
> > can you please pull this patch?
>
> I still don't like the idea of just removing events like this, especially
> when other architectures (including some x86 and Power CPUs afaict) playa
> similar games for generic events, and these events do actually appear in
> user code.
>
> I also don't understand why you remove the TLB events. I think that logic
> would imply we should remove all of the events, because we can't distinguish
> prefetches from reads either. If we want to be consistent, then I think
> we should just remove the OP_WRITE events for L1D and BPU -- would you be
> ok with that instead?

IIUC, dTLB-load-misses is mapped to
ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL(event 0x05) and dTLB-loads is
mapped to ARMV8_PMUV3_PERFCTR_L1D_TLB(0x25). Which are as per spec,
counts TLB access/misses for both memory-read operation and
memory-write operation.

IMO, It won't help in keeping these events, knowingly that their
mapping is not accurate, only thing i can say to users is , dont use
events that are marked as "Hardware cache event"

>
> Also, looking at the code, I think our PMCEID parsing is broken for 8.1
> parts, where the upper 32 bits of the register are offset by 0x4000 in the
> event numbering space.

yes, i did not find any mapping in PMCEIDx registers for
implementation defined events, otherwise we would have remapped at
runtime.

>
> Will

thanks
Ganapat
