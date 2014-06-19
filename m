From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Jun 2014 15:01:49 +0100
Subject: [PATCH v5 04/20] arm64: boot protocol documentation update for
 GICv3
In-Reply-To: <1403169583-13668-5-git-send-email-marc.zyngier@arm.com>
References: <1403169583-13668-1-git-send-email-marc.zyngier@arm.com>
 <1403169583-13668-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140619140149.GA30188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Jun 19, 2014 at 10:19:27AM +0100, Marc Zyngier wrote:
> Linux has some requirements that must be satisfied in order to boot
> on a system built with a GICv3.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  Documentation/arm64/booting.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
> index 37fc4f6..e28ccec 100644
> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -141,6 +141,12 @@ Before jumping into the kernel, the following conditions must be met:
>    the kernel image will be entered must be initialised by software at a
>    higher exception level to prevent execution in an UNKNOWN state.
>  
> +  For systems with a GICv3 interrupt controller, it is expected that:
> +  - If EL3 is present, it must program ICC_SRE_EL3.Enable (bit 3) to
> +    0b1 and ICC_SRE_EL3.SRE (bit 0) to 0b1.
> +  - If the kernel is entered at EL1, EL2 must set ICC_SRE_EL2.Enable
> +    (bit 3) to 0b1 and ICC_SRE_EL2.SRE (bit 0) to 0b1.

Apologies for spotting this so late, but to me this sounds slightly
ambiguous. The use of "it is expected" doesn't read like a hard
requirement, and in the first point, it's ambiguous as to what "it" is.

I assume that if the GIC is communicated to the kernel as a GICv2 then
these points do not hold?

How about:

  For systems with a GICv3 interrupt controller, where the presence of
  GICv3 is communicated to the kernel:
  - If EL3 is present:
    ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
    ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
  - If the kernel is entered at EL1:
    ICC.SRE_EL2.Enable (bit 3) must be initialised to 0b1
    ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b1.

Thanks,
Mark.
