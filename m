From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 4 Oct 2018 11:12:09 +0530
Subject: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
In-Reply-To: <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com>
 <20181001142914.GD9716@arm.com>
 <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
Message-ID: <CAKTKpr5+p=X6QcRp+tsxYYgirwWW=cfs7GOKyKegutEfM_W2vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

can you please pull this patch?

On Mon, Oct 1, 2018 at 10:09 PM Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
>
> Hi Will,
>
> On Mon, Oct 1, 2018 at 7:58 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Hi Ganapat,
> >
> > On Mon, Oct 01, 2018 at 10:07:43AM +0000, Kulkarni, Ganapatrao wrote:
> > > Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
> > > armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
> > > since L1D_CACHE_REFILL counts both load and store misses.
> > > Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
> > > and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
> > > from armv8_pmuv3 cache mapping.
> > >
> > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > ---
> > >  arch/arm64/kernel/perf_event.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> >
> > The "generic" events are really implemented on a best-effort basis, as
> > they rarely tend to map exactly to what the hardware supports. I think
> > they originally stemmed from the x86 CPU PMU, but that doesn't really
> > help us.
>
> This works fairly well for DT based boots, since almost all SoCs have
> added remapping using custom dt object binding.
> However we have concluded in the past to drop SoC specific from the
> ACPI mapping and use json to add SoC/micro architecture specific
> events support.
> At present ,  When we boot with ACPI,  it is misleading for these events.
>
> In fact, this has been pointed internally from benchmark team and
> reported it as hardware bug!
> IMHO, it would be much simpler to delete these misleading events
> mapping rather explaining to perf tool users.
>
> We already have proper mapping for these events,
> armv8_pmuv3_0/l1d_cache_refill/
> armv8_pmuv3_0/l1d_cache/
> [core imp def:]
> l1d_cache_rd
> l1d_cache_wr
> l1d_cache_refill_rd
> l1d_cache_refill_wr
>
> >
> > I had a discussion with Ingo back when we originally implemented perf
> > because I actually preferred not to implement the generic events at all.
> > However, he was strongly of the opinion that a best-effort approach was
> > sufficient to get casual users going with the tool, so that's what we went
> > with.
>
> thanks for the background info, these generic mapping fairly works
> except these events.
>
> >
> > Will
>
> thanks,
> Ganapat

thanks,
Ganapat
