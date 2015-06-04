From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Jun 2015 11:40:31 +0100
Subject: [PATCH v3] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <1433257803-25318-1-git-send-email-michael@smart-africa.com>
References: <1432821287-31436-1-git-send-email-michael@smart-africa.com>
 <1433257803-25318-1-git-send-email-michael@smart-africa.com>
Message-ID: <20150604104031.GB10388@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 05:10:03PM +0200, Michael van der Westhuizen wrote:
> Fixes the TCM initialisation code to handle TCM banks that are
> present but inaccessible due to TrustZone configuration.  This is
> the default case when enabling the non-secure world.  It may also
> be the case that that the user decided to use TCM for TrustZone.
> 
> This change has exposed a bug in handling of TCM where no TCM bank
> was usable (the 0 size TCM case).  This change addresses the
> resulting hang.

[...]

> + *
> + * Encoding this as per A8.8.107 of DDI0406C, Encoding T1/A1, yields:
> + *  1111 1111 1111 1111 0000 1111 1101 1111 Required Mask
> + *  1110 1110 0001 1001 ???? 1111 0001 0001 mrc p15, 0, XX, c9, c1, 0
> + *  1110 1110 0001 1001 ???? 1111 0011 0001 mrc p15, 0, XX, c9, c1, 1
> + *  [  ] [  ] [ ]| [  ] [  ] [  ] [ ]| +--- CRm
> + *    |    |   | |   |    |    |   | +----- SBO
> + *    |    |   | |   |    |    |   +------- opc2
> + *    |    |   | |   |    |    +----------- coproc
> + *    |    |   | |   |    +---------------- Rt
> + *    |    |   | |   +--------------------- CRn
> + *    |    |   | +------------------------- SBO
> + *    |    |   +--------------------------- opc1
> + *    |    +------------------------------- instruction
> + *    +------------------------------------ condition
> + */
> +#define TCM_REGION_READ_MASK		0xffff0fdf
> +#define TCM_REGION_READ_INSTR		0xee190f11
> +#define DEST_REG_SHIFT			12
> +#define DEST_REG_MASK			0xf

What happens in a Thumb-2 kernel?

I think it is safe, since Thumb-2 kernel implies v7, and v7 mandates the
TCMTR.  Even if we did get an Undef, the code in traps.c rearranges the
bits of the offending insn into the "correct" order, and it so happens
that this also makes the encoding for MRC/MCR instructions identical
between ARM and Thumb.

For some other random instruction these assumptions may not hold, so
it is worth adding brief comment in case people blindly use this code
as a template for something else.

[...]

Cheers
---Dave
