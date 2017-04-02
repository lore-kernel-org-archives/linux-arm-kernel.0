From: jbrunet@baylibre.com (Jerome Brunet)
Date: Sun, 02 Apr 2017 16:49:37 +0200
Subject: [PATCH 1/2] clk: meson: mpll: fix division by zero in
 rate_from_params
In-Reply-To: <20170401130225.8811-2-martin.blumenstingl@googlemail.com>
References: <20170401130225.8811-1-martin.blumenstingl@googlemail.com>
 <20170401130225.8811-2-martin.blumenstingl@googlemail.com>
Message-ID: <1491144577.3480.1.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-04-01 at 15:02 +0200, Martin Blumenstingl wrote:
> According to the public datasheet all register bits in HHI_MPLL_CNTL7,
> HHI_MPLL_CNTL8 and HHI_MPLL_CNTL9 default to zero. On all GX SoCs these
> seem to be initialized by the bootloader to some default value.
> However, on my Meson8 board they are not initialized, leading to a
> division by zero in rate_from_params as the math is:
> (parent_rate * SDM_DEN) / ((SDM_DEN * 0) + 0)
> 
> Although the rate_from_params function was only introduced recently the
> original bug has been there for much longer. It was only exposed
> recently when the MPLL clocks were added to the Meson8b clock driver.

The Documentation of the S905 also state that N2 minimal value is 4 and SDM
minimal is 1 ... I should have been more careful ! Thanks for catching this
Martin. We definitely need to fix this.

Patch seems ok but I have one question. Is the rate actually zero when the
divisor is zero ?
I'll be away from my boards until Wednesday but I can check this when I get back
if you can't.

> 
> Fixes: 1c50da4f27 ("clk: meson: add mpll support")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> ?drivers/clk/meson/clk-mpll.c | 7 ++++++-
> ?1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> index 540dabe5adad..551aa2a5b291 100644
> --- a/drivers/clk/meson/clk-mpll.c
> +++ b/drivers/clk/meson/clk-mpll.c
> @@ -76,7 +76,12 @@ static unsigned long rate_from_params(unsigned long
> parent_rate,
> ?				??????unsigned long sdm,
> ?				??????unsigned long n2)
> ?{
> -	return (parent_rate * SDM_DEN) / ((SDM_DEN * n2) + sdm);
> +	unsigned long divisor = (SDM_DEN * n2) + sdm;
> +
> +	if (divisor == 0)
> +		return 0;
> +	else
> +		return (parent_rate * SDM_DEN) / divisor;
> ?}
> ?
> ?static void params_from_rate(unsigned long requested_rate,
