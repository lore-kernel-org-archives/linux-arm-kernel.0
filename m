From: leif.lindholm@arm.com (Leif Lindholm)
Date: Mon, 2 Aug 2010 19:45:27 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100731112916.GN23886@n2100.arm.linux.org.uk>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<201007291313.29923.siarhei.siamashka@nokia.com>
	<20100729192855.GA4298@elf.ucw.cz>
	<201007301304.54559.siarhei.siamashka@nokia.com>
	<20100731105225.GI23886@n2100.arm.linux.org.uk>
	<20100731112916.GN23886@n2100.arm.linux.org.uk>
Message-ID: <000001cb3272$e8b64130$ba22c390$@lindholm@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: 31 July 2010 12:29

> First stab at merging these ARM ISA decoding macros/code - I'm sure
> there's more which can be done:
> 
> diff --git a/arch/arm/include/asm/arm-isa.h b/arch/arm/include/asm/arm-
> isa.h
> index e69de29..aad7dd3 100644
> --- a/arch/arm/include/asm/arm-isa.h
> +++ b/arch/arm/include/asm/arm-isa.h

> +#define RN_BITS(i)	(((i) >> 16) & 15)	/* Rn			*/
> +#define RD_BITS(i)	(((i) >> 12) & 15)	/* Rd			*/
> +#define RM_BITS(i)	((i) & 15)			/* Rm
*/

While I could bring the SWP emulation patch in line by just adding a
couple of defines here for RT_BITS and RT2_BITS, unfortunately, the
ARM instruction formats aren't 100% consistent about these offsets:

STREX* have their Rn and Rd fields at the same offsets as above, with
an Rt field at offset 0.
|    |    |    | Rn | Rd |    |    | Rt |
SWP/SWPB have Rt at offset 12 with an Rt2 at offset 0.
|    |    |    | Rn | Rt |    |    | Rt2|
STRD likewise has Rt at offset 12, but with an Rm at 0.
|    |    |    | Rn | Rt |    |    | Rm |
ASR has Rd at offset 12, but with Rm at 8 and Rn at 0.
|    |    |    |    | Rd | Rm |    | Rn |
MLA has Rd at 16, with Ra at 12, Rm at 8 and Rn at 0.
|    |    |    | Rd | Ra | Rm |    | Rn |

So in the long run we would either need to implement an instruction
decoder to extract the offsets of fields, or separate the least common
ones out into separate defines. The former having potential negative
impact on code size and performance.

If you'd like, I could update the SWP emulation patch to set up
separate SWP_RT_BITS and SWP_RT2_BITS in arm-isa.h for now, along with
a couple of other things I would need. At least that would gather the
encoding stuff into one file.

/
	Leif
