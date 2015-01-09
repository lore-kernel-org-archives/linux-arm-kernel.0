From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 Jan 2015 11:23:19 +0100
Subject: [PATCH v15 11/11] KVM: arm/arm64: Add support to dissolve huge PUD
In-Reply-To: <54AEB32B.3060504@samsung.com>
References: <1418628488-3696-1-git-send-email-m.smarduch@samsung.com>
 <1418628488-3696-12-git-send-email-m.smarduch@samsung.com>
 <20150107130514.GD21092@cbox> <54ADF2F6.8060906@samsung.com>
 <20150108113221.GK21092@cbox> <54AEB32B.3060504@samsung.com>
Message-ID: <20150109102319.GM21092@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 08:41:15AM -0800, Mario Smarduch wrote:

[...]

> >>>
> >>> I'm just thinking here, why do we need to check if we get a valid pud
> >>> back here, but we don't need the equivalent check in dissolve_pmd from
> >>> patch 7?
> >>
> >> kvm_pud_huge() doesn't check bit 0 for invalid entry, but
> >> pud_none() is not the right way to check either, maybe pud_bad()
> >> first. Nothing is done in patch 7 since the pmd is retrieved from
> >> stage2_get_pmd().
> >>
> > 
> > hmmm, but stage2_get_pmd() can return a NULL pointer if you have the
> > IOMAP flag set...
> > 
> >>>
> >>> I think the rationale is that it should never happen because we never
> >>> call these functions with the logging and iomap flags at the same
> >>> time...
> >>
> >> I'm little lost here, not sure how it's related to above.
> >> But I think a VFIO device will have a memslot and
> >> it would be possible to enable logging. But to what
> >> end I'm not sure.
> >>
> > 
> > As I said above, if you call the set_s2pte function with the IOMAP and
> > LOGGING flags set, then you'll end up in a situation where you can get a
> > NULL pointer back from stage2_get_pmd() but you're never checking
> > against that.
> 
> I see what you're saying now.
> > 
> > Now, this raises an interesting point, we have now added code that
> > prevents faults from ever happening on device maps, but introducing a
> > path here where the user can set logging on a memslot with device memory
> > regions, which introduces write faults on such regions.  My gut feeling
> > is that we should avoid that from ever happening, and not allow this
> > function to be called with both flags set.
> 
> Maybe kvm_arch_prepare_memory_region() can check if
> KVM_MEM_LOG_DIRTY_PAGES is being enabled for an IO region
> and don't allow it.
> 

Yeah, I think we need to add a check for that somewhere as part of this
series (patch 7 perhaps?).

-Christoffer
