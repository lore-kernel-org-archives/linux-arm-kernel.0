From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 16 Feb 2016 11:19:35 +0100
Subject: [PATCH] arm64/efi: Make strnlen() available to the EFI namespace
In-Reply-To: <CAKv+Gu86oyHJcBhkjouLQk8FMR=0obrPpwnYvXMFSJkOa3c2pA@mail.gmail.com>
References: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
 <CAKv+Gu86oyHJcBhkjouLQk8FMR=0obrPpwnYvXMFSJkOa3c2pA@mail.gmail.com>
Message-ID: <20160216101935.GA4868@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 08:23:22PM +0100, Ard Biesheuvel wrote:
> Hi Thierry,
> 
> On 15 February 2016 at 20:17, Thierry Reding <thierry.reding@gmail.com> wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Changes introduced in the upstream version of libfdt pulled in by commit
> > 91feabc2e224 ("scripts/dtc: Update to upstream commit b06e55c88b9b") use
> > the strnlen() function, which isn't currently available to the EFI name-
> > space. Add it to the EFI namespace to avoid a linker error.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  arch/arm64/kernel/image.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> > index c9c62cab25a4..8a1978f4a555 100644
> > --- a/arch/arm64/kernel/image.h
> > +++ b/arch/arm64/kernel/image.h
> > @@ -96,6 +96,8 @@ __efistub_strcmp              = KALLSYMS_HIDE(__pi_strcmp);
> >  __efistub_strncmp              = KALLSYMS_HIDE(__pi_strncmp);
> >  __efistub___flush_dcache_area  = KALLSYMS_HIDE(__pi___flush_dcache_area);
> >
> > +__efistub_strnlen              = KALLSYMS_HIDE(strnlen);
> > +
> 
> To align with the existing code, we should use __pi_strnlen here, and
> declare the asm version of strnlen with ENDPIPROC()

Yes, you're absolutely right. For some reason I had missed the ARM64
implementation of strnlen() in the grep output. Sent a v2 now which is
consistent with the existing code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160216/a3e4386c/attachment.sig>
