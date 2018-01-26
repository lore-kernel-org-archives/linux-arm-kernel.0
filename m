From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 17:10:36 +0000
Subject: [PATCH 4/4] efi/arm64: unmap the kernel while executing UEFI
 services
In-Reply-To: <CAKv+Gu84Dk1ZRicHNWr2SLn1GEpaj1YmekzgjvK4aC5t05TgSw@mail.gmail.com>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
 <20180125103131.19168-5-ard.biesheuvel@linaro.org>
 <20180126170505.GE16008@arm.com>
 <CAKv+Gu84Dk1ZRicHNWr2SLn1GEpaj1YmekzgjvK4aC5t05TgSw@mail.gmail.com>
Message-ID: <20180126171035.GG16008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 05:06:42PM +0000, Ard Biesheuvel wrote:
> On 26 January 2018 at 17:05, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jan 25, 2018 at 10:31:31AM +0000, Ard Biesheuvel wrote:
> >> Now that all UEFI runtime service wrappers ensure that byref
> >> arguments are moved into the UEFI marshalling buffer (which
> >> is not part of the kernel mapping), we can proceed and unmap
> >> the kernel while UEFI runtime service calls are in progress.
> >>
> >> This is done by setting the EPD1 bit and flushing the TLB of
> >> the local CPU. This makes it independent of KPTI or whether
> >> non-global mappings are being used.
> >
> > One snag with this is that it will break SPE, so I'd prefer this behaviour
> > to be predicated on kpti so that the arm64_kernel_unmapped_at_el0() check
> > in drivers/perf/arm_spe_pmu.c remains valid.
> >
> 
> The problem with that is that they serve two different purposes: kpti
> protects against meltdown, this protects against Spectre variant 1.

Fair enough, but we should do something because it renders SPE unusable
and it can be a really handy profiling feature. Having the new EFI behaviour
optional in some way would be my preference.

Will
