From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Sep 2014 10:17:50 +0100
Subject: [PATCH 1/3 repost] clocksource: sh_cmt: Document SoC specific
 bindings
In-Reply-To: <20140903012724.GE2903@verge.net.au>
References: <1409117300-2133-1-git-send-email-horms+renesas@verge.net.au>
 <1409117300-2133-2-git-send-email-horms+renesas@verge.net.au>
 <20140827095103.GB7295@leverpostej>
 <20140903012724.GE2903@verge.net.au>
Message-ID: <20140903091750.GA8322@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 02:27:25AM +0100, Simon Horman wrote:
> Hi Mark,
> 
> On Wed, Aug 27, 2014 at 10:51:03AM +0100, Mark Rutland wrote:
> > Hi Simon,
> > 
> > On Wed, Aug 27, 2014 at 06:28:18AM +0100, Simon Horman wrote:
> > > In general Renesas hardware is not documented to the extent
> > > where the relationship between IP blocks on different SoCs can be assumed
> > > although they may appear to operate the same way. Furthermore the
> > > documentation typically does not specify a version for individual
> > > IP blocks. For these reasons a convention of using the SoC name in place
> > > of a version and providing SoC-specific compat strings has been adopted.
> > > 
> > > Although not universally liked this convention is used in the bindings
> > > for the drivers a number of drivers for Renesas hardware. The purpose
> > > of this patch is to update the Renesas R-Car Compare Match Timer (CMT)
> > > driver to follow this convention.
> > 
> > Having really specific strings to give us the flexibility if necessary
> > makes sense, so I the addition of the strings below is fine.
> > 
> > I see in the example update the existing "renesas,cmt-48-gen2" string
> > remains. I take it we expect that as a fallback in the compatible list
> > for all of the new strings, and the driver can jsut match on that for
> > the moment?
> > 
> > If so, it would be nice to be more explicit as to what we expect as
> > fallback compatible entries.
> 
> Yes, that is the desired behaviour.
> Would this address your concerns?
> It incorporates some suggestions made by Geert Uytterhoeven
> and explicitly talks about fallback entries.
> 
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> [PATCH v1.1] clocksource: sh_cmt: Document SoC specific bindings
> 
> In general Renesas hardware is not documented to the extent
> where the relationship between IP blocks on different SoCs can be assumed
> although they may appear to operate the same way. Furthermore the
> documentation typically does not specify a version for individual
> IP blocks. For these reasons a convention of using the SoC name in place
> of a version and providing SoC-specific compat strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> a number of drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas R-Car Compare Match Timer (CMT) driver to follow this
> convention.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

I'm happy with this.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> ---
> * I plan to follow up with patches to use these new bindings in the
>   dtsi files for the affected SoCs.
> 
> v2
> * Reorder compat entries so more-specific entries and their fallbacks
>   are grouped with the fallback entry coming last.
> * Explicitly document fallback
> ---
>  .../devicetree/bindings/timer/renesas,cmt.txt      | 44 +++++++++++++++++++---
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> index a17418b..7b44f4b 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> @@ -11,15 +11,47 @@ datasheets.
>  
>  Required Properties:
>  
> -  - compatible: must contain one of the following.
> -    - "renesas,cmt-32" for the 32-bit CMT
> +  - compatible: must contain one or more of the following:
> +    - "renesas,cmt-32-r8a7740" for the R8a7740 32-bit CMT
> +		(CMT0)
> +    - "renesas,cmt-32-sh7372" for the SH7372 32-bit CMT
> +		(CMT0)
> +    - "renesas,cmt-32-sh73a0" for the SH73a0 32-bit CMT
> +		(CMT0)
> +    - "renesas,cmt-32" for all 32-bit CMT without fast clock support
>  		(CMT0 on sh7372, sh73a0 and r8a7740)
> -    - "renesas,cmt-32-fast" for the 32-bit CMT with fast clock support
> +		This is a fallback for the above renesas,cmt-32-* entries.
> +
> +    - "renesas,cmt-32-fast-r8a7740" for the R8A7740 32-bit CMT with fast
> +		clock support (CMT[234])
> +    - "renesas,cmt-32-fast-sh7372" for the SH7372 32-bit CMT with fast
> +		clock support (CMT[234])
> +    - "renesas,cmt-32-fast-sh73a0" for the SH73A0 32-bit CMT with fast
> +		clock support (CMT[234])
> +    - "renesas,cmt-32-fast" for all 32-bit CMT with fast clock support
>  		(CMT[234] on sh7372, sh73a0 and r8a7740)
> -    - "renesas,cmt-48" for the 48-bit CMT
> +		This is a fallback for the above renesas,cmt-32-fast-* entries.
> +
> +    - "renesas,cmt-48-sh7372" for the SH7372 48-bit CMT
> +		(CMT1)
> +    - "renesas,cmt-48-sh73a0" for the SH73A0 48-bit CMT
> +		(CMT1)
> +    - "renesas,cmt-48-r8a7740" for the R8A7740 48-bit CMT
> +		(CMT1)
> +    - "renesas,cmt-48" for all non-second generation 48-bit CMT
>  		(CMT1 on sh7372, sh73a0 and r8a7740)
> -    - "renesas,cmt-48-gen2" for the second generation 48-bit CMT
> +		This is a fallback for the above renesas,cmt-48-* entries.
> +
> +    - "renesas,cmt-48-r8a73a4" for the R8A73A4 48-bit CMT
> +		(CMT[01])
> +    - "renesas,cmt-48-r8a7790" for the R8A7790 48-bit CMT
> +		(CMT[01])
> +    - "renesas,cmt-48-r8a7791" for the R8A7791 48-bit CMT
> +		(CMT[01])
> +    - "renesas,cmt-48-gen2" for all second generation 48-bit CMT
>  		(CMT[01] on r8a73a4, r8a7790 and r8a7791)
> +		This is a fallback for the renesas,cmt-48-r8a73a4,
> +		renesas,cmt-48-r8a7790 and renesas,cmt-48-gen2 entries.
>  
>    - reg: base address and length of the registers block for the timer module.
>    - interrupts: interrupt-specifier for the timer, one per channel.
> @@ -36,7 +68,7 @@ Example: R8A7790 (R-Car H2) CMT0 node
>  	them channels 0 and 1 in the documentation.
>  
>  	cmt0: timer at ffca0000 {
> -		compatible = "renesas,cmt-48-gen2";
> +		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
>  		reg = <0 0xffca0000 0 0x1004>;
>  		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
>  			     <0 142 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.0.1
> 
> 
