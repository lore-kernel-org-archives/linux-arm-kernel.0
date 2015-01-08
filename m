From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 8 Jan 2015 11:44:43 +0000
Subject: [PATCH] arm64/efi: add missing call to early_ioremap_reset()
In-Reply-To: <20150108113655.GF11583@arm.com>
References: <1420710898-32298-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150108113655.GF11583@arm.com>
Message-ID: <20150108114443.GO3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 11:36:55AM +0000, Will Deacon wrote:
> On Thu, Jan 08, 2015 at 09:54:58AM +0000, Ard Biesheuvel wrote:
> > The early ioremap support introduced by patch bf4b558eba92
> > ("arm64: add early_ioremap support") failed to add a call to
> > early_ioremap_reset() at an appropriate time. Without this call,
> > invocations of early_ioremap etc. that are done too late will go
> > unnoticed and may cause corruption.
> > 
> > This is exactly what happened when the first user of this feature
> > was added in patch f84d02755f5a ("arm64: add EFI runtime services").
> > The early mapping of the EFI memory map is unmapped during an early
> > initcall, at which time the early ioremap support is long gone.
> > 
> > Fix by adding the missing call to early_ioremap_reset() to
> > setup_arch(), and move the offending early_memunmap() to right after
> > the point where the early mapping of the EFI memory map is last used.
> > 
> > Fixes: f84d02755f5a ("arm64: add EFI runtime services")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > 
> > After discussing off-list between Mark Salter, Leif and myself, this is the
> > bare minimum to fix the early ioremap issue in kernels up to 3.19, combined
> > into a single patch. Considering that the early_ioremap support was added in
> > 3.15 (eol), but not used until EFI runtime services support was added in 3.16,
> > there is no reason to split this up. Also, we have work underway to drastically
> > change the way runtime services etc are mapped during early boot [which we hope
> > will make it into 3.20] so it makes sense to do the bare minimum here and handle
> > any fallout in terms of style etc later.
> 
> Ok, so this replaces the two patch series sent earlier by Leif and should be
> appied for 3.19?

Correct.

/
    Leif
