From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Nov 2017 14:16:33 +0000
Subject: [PATCH v1 1/3] arm64: add a macro for SError synchronization
In-Reply-To: <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
References: <1509563697-6359-1-git-send-email-gengdongjiu@huawei.com>
 <1509563697-6359-2-git-send-email-gengdongjiu@huawei.com>
 <6dc82768-8564-a54e-041b-3b9965fa038b@arm.com>
 <d7b8b779-9e00-8e8f-b44e-48e3d7e37058@huawei.com>
Message-ID: <20171101141603.4ppgwup4grnmcswe@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 08:54:44PM +0800, gengdongjiu wrote:
> On 2017/11/1 19:24, Robin Murphy wrote:
> >> +	esb
> >> +alternative_else_nop_endif
> >> +1:
> >> +	.endm
> > Having a branch in here is pretty horrible, and furthermore using label
> > number 1 has a pretty high chance of subtly breaking code where this
> > macro is inserted.
> > 
> > Can we not somehow nest or combine the alternative conditions here?
> 
> I found it will report error if combine the alternative conditions here.
> 
> For example:
> 
> +	.macro	error_synchronize
> +alternative_if ARM64_HAS_IESB
> +alternative_if ARM64_HAS_RAS_EXTN
> +	esb
> +alternative_else_nop_endif
> +alternative_else_nop_endif
> +	.endm
> 
> And even using b.eq/cbz instruction in the alternative instruction in arch/arm64/kernel/entry.S,
> it will report Error.

Alternatives cannot be nested. You need to define a cap like:

  ARM64_HAS_RAS_NOT_IESB

... which is set when ARM64_HAS_RAS_EXTN && !ARM64_HAS_IESB.

Then you can do:

alternative_if ARM64_HAS_RAS_NOT_IESB
	esb
alternative_else_nop_endif

See ARM64_ALT_PAN_NOT_UAO for an example.

That said, as Robin points out we may not even need the alternative.

Thanks,
Mark.
