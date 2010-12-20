From: prakity@marvell.com (Philip Rakity)
Date: Mon, 20 Dec 2010 14:42:22 -0800
Subject: [PATCH] mach-mmp: Support for SD/MMC clock adjustment in brownston=
Message-ID: <mailman.213.1303937599.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e

Set timing for brownstone for SD/MMC cards to enable detection
timing adjustments are needed when speed > 25MHz
remove limitation on maximum speed of 25MHz

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
index 36d5b82..55e891a 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -178,14 +178,22 @@ static struct i2c_board_info brownstone_twsi1_info[] =
=3D {
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 =3D {
-	.max_speed	=3D 25000000,
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 31,
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 15,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT,
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 31,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
--=20
1.7.0.4



On Apr 27, 2011, at 8:02 AM, Philip Rakity wrote:

>=20
>=20
>=20
>=20
> Begin forwarded message:
>=20
>> From: Philip Rakity <prakity@marvell.com>
>> Date: April 22, 2011 1:18:33 PM PDT
>> To: "linux-mmc at vger.kernel.org" <linux-mmc@vger.kernel.org>
>> Cc: Zhangfei Gao <zgao6@marvell.com>
>> Subject: [PATCH] sdhci: sdhci-pxa.c: Add post reset processing for chip =
specific registers=20
>>=20
>>=20
>> RESET_ALL resets chips private registers.
>> Reset to values specified in board file.
>>=20
>> depends on board specific mach-mmp/plat-pxa sdhci.h definitions
>>=20
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>> drivers/mmc/host/sdhci-pxa.c |   42 ++++++++++++++++++++++++++++++++++++=
++++++
>> 1 files changed, 42 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>> index c8abf0f..1dc0988 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -29,6 +29,13 @@
>>=20
>> #define DRIVER_NAME	"sdhci-pxa"
>>=20
>> +#define SD_CLOCK_AND_BURST_SIZE_SETUP   0x10A
>> +#define SDCLK_DELAY_MASK     0x1F
>> +#define SDCLK_SEL_MASK       0x1
>> +#define SDCLK_DELAY_SHIFT    9
>> +#define SDCLK_SEL_SHIFT      8
>> +
>> +
>> struct sdhci_pxa {
>> 	struct sdhci_host		*host;
>> 	struct sdhci_pxa_platdata	*pdata;
>> @@ -53,7 +60,42 @@ static void enable_clock(struct sdhci_host *host)
>> 	}
>> }
>>=20
>> +static void set_clock_and_burst_size(struct sdhci_host *host)
>> +{
>> +	u16 tmp;
>> +	struct sdhci_pxa *pxa =3D sdhci_priv(host);
>> +
>> +	pr_debug("%s:%s: adjust =3D %d\n",
>> +		__func__, mmc_hostname(host->mmc), pxa->pdata->adjust_clocks);
>> +
>> +	if (pxa->pdata->adjust_clocks) {
>> +		tmp =3D readw(host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +		pr_debug("%s:%s: (B) SD_CLOCK_AND_BURST =3D %04X, "
>> +			"delay =3D %d, sel =3D %d\n",
>> +			__func__, mmc_hostname(host->mmc), tmp,
>> +			pxa->pdata->clk_delay, pxa->pdata->clk_select);
>> +		tmp &=3D ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>> +		tmp &=3D ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>> +		tmp |=3D (pxa->pdata->clk_delay & SDCLK_DELAY_MASK) <<
>> +			SDCLK_DELAY_SHIFT;
>> +		tmp |=3D (pxa->pdata->clk_select & SDCLK_SEL_MASK) <<
>> +			SDCLK_SEL_SHIFT;
>> +		writew(tmp, host->ioaddr + SD_CLOCK_AND_BURST_SIZE_SETUP);
>> +		pr_debug("%s:%s: (A) SD_CLOCK_AND_BURST_SIZE_SETUP =3D %04X\n",
>> +			__func__, mmc_hostname(host->mmc), tmp);
>> +	}
>> +}
>> +
>> +static void platform_reset_exit(struct sdhci_host *host, u8 mask)
>> +{
>> +	if (mask =3D=3D SDHCI_RESET_ALL) {
>> +		/* reset private registers */
>> +		set_clock_and_burst_size(host);
>> +	}
>> +}
>> +
>> static struct sdhci_ops sdhci_pxa_ops =3D {
>> +	.platform_reset_exit =3D platform_reset_exit,
>> };
>>=20
>> /***********************************************************************=
******\
>> --=20
>> 1.7.0.4
>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> On Apr 27, 2011, at 2:33 AM, Russell King - ARM Linux wrote:
>=20
>> On Fri, Apr 22, 2011 at 01:13:28PM -0700, Philip Rakity wrote:
>>> The PXA168, PXA910, and MMP2 SoC have the ability to adjust the SD/MMC
>>> clock.  This feature is useful and required depending on the board
>>> design.  Add infrastructure to support SD clock tuning.
>>=20
>> It just adds fields to a structure which remain unused.  On its own this
>> patch is useless, and I don't see a patch which makes use of these new
>> fields in any way.  Did you forget to copy it to the linux-arm-kernel
>> list?
>=20
