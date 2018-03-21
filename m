From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Mar 2018 05:26:06 +0000
Subject: [PATCH] arm/arm64: smccc: Fix CLANG compilation for ARM 64 bit
 archs
In-Reply-To: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
References: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
Message-ID: <20180321052555.lfnnhcp5iapwgrzt@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 20, 2018 at 03:14:06PM -0700, Isaac J. Manjarres wrote:
> Currently, there are references to registers that
> have had their names changed in 64 bit ARM architectures,
> such as "r0." While GCC automatically does the conversion of
> these registers to their 64 bit counterparts, CLANG
> does not, resulting in compilation failures when
> building the kernel. Allow for differentiation of
> which register names to use, based on ARM architecture.

Please note that the architecture still calls these registers rN, the xN and wN
names are aliases. The commit message is a little misleading, and it sounds
like this is a deficiency in clang.

Is there a plan to fix clang to accept this format?

> Change-Id: If89d47b2feb217d97bb61a3f99e61096705a4984

Please remove these tags when submitting patches upstream.

[...]

> +#define R0_STR		"x0"
> +#define R1_STR		"x1"
> +#define R2_STR		"x2"
> +#define R3_STR		"x3"
> +#define R4_STR		"x4"
> +#define R5_STR		"x5"
> +#define R6_STR		"x6"
> +#define R7_STR		"x7"

This would be simpler if we had:

  /* aarch64 */
  #define SMCCC_REG(n)		"x" #n

  /* aarch32 */
  #define SMCCC_REG(n)		"r" #n

... then later we do:

  register <type> rN asm(SMCCC_REG(N));

Thanks,
Mark.
