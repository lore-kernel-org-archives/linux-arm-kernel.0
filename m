From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 24 Feb 2018 09:34:24 +0100
Subject: [PATCH -stable] arm64: mm: don't write garbage into TTBR1_EL1
 register
In-Reply-To: <20180223182902.24873-1-ard.biesheuvel@linaro.org>
References: <20180223182902.24873-1-ard.biesheuvel@linaro.org>
Message-ID: <20180224083424.GC9681@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:29:02PM +0000, Ard Biesheuvel wrote:
> Stable backport commit 173358a49173 ("arm64: kpti: Add ->enable callback
> to remap swapper using nG mappings") of upstream commit f992b4dfd58b did
> not survive the backporting process unscathed, and ends up writing garbage
> into the TTBR1_EL1 register, rather than pointing it to the zero page to
> disable translations. Fix that.
> 
> Cc: <stable@vger.kernel.org> #v4.14
> Reported-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/mm/proc.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Any reason why you didn't cc: the stable list, as this is a patch that
is not needed in mainline, right?

> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 08572f95bd8a..2b473ddeb7a3 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -155,7 +155,7 @@ ENDPROC(cpu_do_switch_mm)
>  
>  .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
>  	adrp	\tmp1, empty_zero_page
> -	msr	ttbr1_el1, \tmp2
> +	msr	ttbr1_el1, \tmp1

I don't understand why this isn't also needed in Linus's tree.  What
commit there prevents this from being required?

thanks,

greg k-h
