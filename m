From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 31 Aug 2017 14:41:16 -0700
Subject: [PATCH v2] nd_blk: Remove mmio_flush_range()
In-Reply-To: <c92a50f21a01a0c1c809c3910251f596ddbc3acd.1504178199.git.robin.murphy@arm.com>
References: <c92a50f21a01a0c1c809c3910251f596ddbc3acd.1504178199.git.robin.murphy@arm.com>
Message-ID: <CAPcyv4h=1seS9OS4KMk6EFYy1LzX2J7+qX_ocEfp4MVJ88q0qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 4:27 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> mmio_flush_range() suffers from a lack of clearly-defined semantics,
> and is somewhat ambiguous to port to other architectures where the
> scope of the writeback implied by "flush" and ordering might matter,
> but MMIO would tend to imply non-cacheable anyway. Per the rationale
> in 67a3e8fe9015 ("nd_blk: change aperture mapping from WC to WB"), the
> only existing use is actually to invalidate clean cache lines for
> ARCH_MEMREMAP_PMEM type mappings *without* writeback. Since the recent
> cleanup of the pmem API, that also now happens to be the exact purpose
> of arch_invalidate_pmem(), which would be a far more well-defined tool
> for the job.
>
> Rather than risk potentially inconsistent implementations of
> mmio_flush_range() for the sake of one callsite, streamline things by
> removing it entirely and instead move the ARCH_MEMREMAP_PMEM related
> definitions up to the libnvdimm level, so they can be shared by NFIT
> as well. This allows NFIT to be enabled for arm64.
>

Thanks, applied.
