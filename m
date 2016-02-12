From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Feb 2016 20:48:58 +0100
Subject: [PATCH] Revert "ASoC: qcom: Specify LE device endianness"
In-Reply-To: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
References: <1455298217-15744-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <2686474.cvCA6vY47l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 February 2016 09:30:17 Stephen Boyd wrote:
> This reverts commit 18560a4e3b07438113b50589e78532d95f907029.
> 
> The commit that caused us to specify LE device endianness here,
> 29bb45f25ff3 (regmap-mmio: Use native endianness for read/write,
> 2015-10-29), has been reverted in mainline so now when we specify
> LE it actively breaks big endian kernels because the byte
> swapping in regmap-mmio is incorrect. Let's revert this change
> because it will 1) fix the big endian kernels and 2) be redundant
> to specify LE because that will become the default soon.
> 
> Cc: Kenneth Westfield <kwestfie@codeaurora.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Ah, too bad to have to revert a correct change until the infrastructure
is fixed properly, but I guess it's the easier way out here.

What about the other uses of REGMAP_ENDIAN_LITTLE in the kernel?
In particular I see 

drivers/clk/nxp/clk-lpc32xx.c:  .val_format_endian = REGMAP_ENDIAN_LITTLE,

drivers/clk/qcom/gcc-apq8084.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-ipq806x.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-msm8660.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-msm8916.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/gcc-msm8974.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/lcc-ipq806x.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/lcc-msm8960.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/mmcc-apq8084.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/mmcc-msm8960.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/mmcc-msm8960.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,
drivers/clk/qcom/mmcc-msm8974.c:        .val_format_endian = REGMAP_ENDIAN_LITTLE,

drivers/nvmem/qfprom.c: .val_format_endian = REGMAP_ENDIAN_LITTLE,

and of course

drivers/mfd/syscon.c:   syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;

which all look like they are regmap_mmio users as well. Do they 
suffer from the same problem?

	Arnd
