From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 1 Jul 2011 11:01:16 -0300
Subject: [BUGFIX][PATCH] fix the parent of i2c[12]_clk
In-Reply-To: <1309525326-4762-1-git-send-email-LW@KARO-electronics.de>
References: <1309525326-4762-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <BANLkTi=hBamK2JE1KykAJQWiyrhC8qPB_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2011 at 10:02 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> The clock from which the I2C timing is derived is the ipg_perclk not ipg_clk.
>
> I2C bus frequency was too low by a factor of ~8 due to the clock divider
> calculation being based on 66.5MHz IPG clock while the bus actually
> uses 8MHz ipg_perclk.
>
> Kernel version: 3.0.0-rc2 branch 'imx-for-next' of git://git.pengutronix.de/git/imx/linux-2.6
>
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
> ?arch/arm/mach-mx5/clock-mx51-mx53.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> index 699b0d2..fe977d0 100644
> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> @@ -1282,9 +1282,9 @@ DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
>
> ?/* I2C */
> ?DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
> - ? ? ? NULL, NULL, &ipg_clk, NULL);
> + ? ? ? NULL, NULL, &ipg_perclk, NULL);
> ?DEFINE_CLOCK(i2c2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG10_OFFSET,
> - ? ? ? NULL, NULL, &ipg_clk, NULL);
> + ? ? ? NULL, NULL, &ipg_perclk, NULL);
> ?DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
> ? ? ? ?NULL, NULL, &ipg_clk, NULL);
> ?DEFINE_CLOCK(i2c3_mx53_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,

Shouldn't i2c3_mx53_clk have the same change applied?

Regards,

Fabio Estevam
