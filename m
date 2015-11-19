From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 19 Nov 2015 11:49:08 -0800
Subject: [PATCH v9 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <564C9558.4020100@sigmadesigns.com> (Marc Gonzalez's message of
 "Wed, 18 Nov 2015 16:12:24 +0100")
References: <564C94A5.4060301@sigmadesigns.com>
 <564C9558.4020100@sigmadesigns.com>
Message-ID: <7hwptdu5vv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> Add support for Sigma Designs ARM-based Tango4 "Secure Media Processor"
> platforms (i.e. smp8734, smp8756, smp8758, smp8759) built around the
> Cortex-A9 MPCore r3p0 (all dual-core, except the 8756).
>
> Support for older MIPS-based platforms can be found elsewhere:
> https://github.com/mansr/linux-tangox
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

[...]

> +static void tango_l2c_write(unsigned long val, unsigned int reg)
> +{
> +	pr_debug("%s: reg=0x%x val=0x%lx\n", __func__, reg, val);

leftover debugging aid?

> +	if (reg == L2X0_CTRL)
> +		tango_set_l2_control(val);
> +}
> +

[...]

> diff --git a/arch/arm/mach-tangox/smc.S b/arch/arm/mach-tangox/smc.S
> new file mode 100644
> index 000000000000..5d932ce3c1bd
> --- /dev/null
> +++ b/arch/arm/mach-tangox/smc.S
> @@ -0,0 +1,9 @@
> +#include <linux/linkage.h>
> +
> +ENTRY(tango_smc)
> +	push	{lr}
> +	mov	ip, r1
> +	dsb	/* This barrier is probably unnecessary */

Then remove it?

> +	smc	#0
> +	pop	{pc}
> +ENDPROC(tango_smc)

Otherwise looks pretty simple and straight forward to me.

FWIW, one of the benefits of starting with the small/minimum set and
adding as you go is that it's much easier on reviewers.

Kevin
