From: marex@denx.de (Marek Vasut)
Date: Sun, 2 Oct 2016 20:29:14 +0200
Subject: [PATCH] ARM: dts: imx6sx: Fix LCDIF interrupt type
In-Reply-To: <CAOMZO5DwZYawBOiXWn0FMy9SgO4+-C=y-CFCQBPSO_mDYk-a6g@mail.gmail.com>
References: <20161002164435.5812-1-marex@denx.de>
 <CAOMZO5DwZYawBOiXWn0FMy9SgO4+-C=y-CFCQBPSO_mDYk-a6g@mail.gmail.com>
Message-ID: <1494ec1a-139f-d0e5-db9f-4dc33e9e9a7f@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2016 07:43 PM, Fabio Estevam wrote:
> Hi Marek,

Hi!

> On Sun, Oct 2, 2016 at 1:44 PM, Marek Vasut <marex@denx.de> wrote:
>> The LCDIF interrupt should be triggered by the rising edge of the
>> IRQ line because we only want the interrupt to trigger once per each
>> frame. It seems the LCDIF IRQ line cannot be explicitly de-asserted
>> by software, so the previous behavior before this patch, where the
>> interrupt was triggered by level-high status of the IRQ line, caused
>> the interrupt to fire again immediatelly after it was handled, which
>> caused the system to lock up due to the high rate of interrupts.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> ---
>>  arch/arm/boot/dts/imx6sx.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
>> index 1a473e8..9526c38 100644
>> --- a/arch/arm/boot/dts/imx6sx.dtsi
>> +++ b/arch/arm/boot/dts/imx6sx.dtsi
>> @@ -1143,7 +1143,7 @@
>>                                 lcdif1: lcdif at 02220000 {
>>                                         compatible = "fsl,imx6sx-lcdif", "fsl,imx28-lcdif";
>>                                         reg = <0x02220000 0x4000>;
>> -                                       interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +                                       interrupts = <GIC_SPI 5 IRQ_TYPE_EDGE_RISING>;
> 
> What about mx6ul and mx6sl.dtsi? Shouldn't they be also updated?

Probably, but I don't have the hardware to test MXSFB DRM/KMS driver on
those. I can mail you the necessary patches if you want to try it out,
the latest version is not in the ML yet as there is some DRM
infrastructure work going on.

-- 
Best regards,
Marek Vasut
