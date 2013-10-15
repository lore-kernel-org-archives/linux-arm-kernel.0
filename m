From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Oct 2013 11:11:30 +0100
Subject: [PATCH v2 01/13] arm64: kernel: add MPIDR_EL1 accessors macros
In-Reply-To: <1381748590-14279-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20131015101130.GA30411@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 12:02:58PM +0100, Lorenzo Pieralisi wrote:
> In order to simplify access to different affinity levels within the
> MPIDR_EL1 register values, this patch implements some preprocessor
> macros that allow to retrieve the MPIDR_EL1 affinity level value according
> to the level passed as input parameter.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/cputype.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 5fe138e..2c9e295 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -30,6 +30,16 @@
>  
>  #define MPIDR_HWID_BITMASK	0xff00ffffff
>  
> +#define MPIDR_LEVEL_BITS 8
> +#define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
> +
> +#define MPIDR_LEVEL_SHIFT(level) ({					\
> +	(level == 3) ? 32 : MPIDR_LEVEL_BITS * level;			\

You can avoid the check if you do:

  ((1 << level) >> 1) << 3)

where that '3' is log2 MPIDR_LEVEL_BITS, so you could factor that out and
redefine MPIDR_LEVEL_BITS in terms of a shift.

Will
