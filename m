From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Wed, 7 May 2014 17:44:03 +0530
Subject: [PATCH v4 10/15] clk: exynos5420: update clocks for FSYS and
 FSYS2 blocks
In-Reply-To: <53691F3D.8050104@gmail.com>
References: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
 <1399393610-23394-11-git-send-email-shaik.ameer@samsung.com>
 <53691F3D.8050104@gmail.com>
Message-ID: <CAOD6ATq+KO5i6BLzfL2+qY3eJ6Yvsjmsn_WO-o9NOjDdG8ip4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,


On Tue, May 6, 2014 at 11:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Shaik,
>
>
> On 06.05.2014 18:26, Shaik Ameer Basha wrote:
>>
>> This patch adds more clocks from FSYS and FSYS2 blocks
>> and uses GATE_IP_* registers for gating IPs.
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c |   41
>> ++++++++++++++++++++++------------
>>   1 file changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> index f0460b4..6d88ae2 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>
>
> [snip]
>
>
>> @@ -736,12 +749,9 @@ static struct samsung_gate_clock
>> exynos5420_gate_clks[] __initdata = {
>>         GATE(CLK_SCLK_USBPHY300, "sclk_usbphy300", "dout_usbphy300",
>>                 GATE_TOP_SCLK_FSYS, 8, CLK_SET_RATE_PARENT, 0),
>>         GATE(CLK_SCLK_USBD300, "sclk_usbd300", "dout_usbd300",
>> -               GATE_TOP_SCLK_FSYS, 9, CLK_SET_RATE_PARENT, 0),
>> +               GATE_TOP_SCLK_FSYS, 9, CLK_IGNORE_UNUSED, 0),
>
>
> Why CLK_IGNORE_UNUSED? Also CLK_SET_RATE_PARENT seems quite right for this
> clock.

Sorry, that was a hack for some internal USB testing. Some how it got
merged with this series.
I will revert it to CLK_SET_RATE_PARENT.

>
>
>>         GATE(CLK_SCLK_USBD301, "sclk_usbd301", "dout_usbd301",
>> -               GATE_TOP_SCLK_FSYS, 10, CLK_SET_RATE_PARENT, 0),
>> -
>> -       GATE(CLK_SCLK_USBD301, "sclk_unipro", "dout_unipro",
>> -               SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
>> +               GATE_TOP_SCLK_FSYS, 10, CLK_IGNORE_UNUSED, 0),
>
>
> Same here.

Same here :)

>
>
>>
>>         /* Display */
>>         GATE(CLK_SCLK_FIMD1, "sclk_fimd1", "dout_fimd1",
>> @@ -760,20 +770,23 @@ static struct samsung_gate_clock
>> exynos5420_gate_clks[] __initdata = {
>>                 GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
>>         GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
>>                 GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
>> -       /* FSYS */
>> +
>> +       /* FSYS Block */
>>         GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
>>         GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
>>         GATE(CLK_PDMA1, "pdma1", "aclk200_fsys", GATE_BUS_FSYS0, 2, 0, 0),
>>         GATE(CLK_UFS, "ufs", "aclk200_fsys2", GATE_BUS_FSYS0, 3, 0, 0),
>> -       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_BUS_FSYS0, 5, 0, 0),
>> -       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_BUS_FSYS0, 12, 0, 0),
>> -       GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_BUS_FSYS0, 13, 0, 0),
>> -       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_BUS_FSYS0, 14, 0, 0),
>> +       GATE(CLK_RTIC, "rtic", "aclk200_fsys", GATE_IP_FSYS, 9, 0, 0),
>> +       GATE(CLK_MMC0, "mmc0", "aclk200_fsys2", GATE_IP_FSYS, 12, 0, 0),
>> +       GATE(CLK_MMC1, "mmc1", "aclk200_fsys2", GATE_IP_FSYS, 13, 0, 0),
>> +       GATE(CLK_MMC2, "mmc2", "aclk200_fsys2", GATE_IP_FSYS, 14, 0, 0),
>>         GATE(CLK_SROMC, "sromc", "aclk200_fsys2",
>> -                       GATE_BUS_FSYS0, 19, CLK_IGNORE_UNUSED, 0),
>> -       GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_BUS_FSYS0, 20, 0,
>> 0),
>> -       GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_BUS_FSYS0, 21,
>> 0, 0),
>> -       GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_BUS_FSYS0, 28,
>> 0, 0),
>> +                       GATE_IP_FSYS, 17, CLK_IGNORE_UNUSED, 0),
>> +       GATE(CLK_USBH20, "usbh20", "aclk200_fsys", GATE_IP_FSYS, 18, 0,
>> 0),
>> +       GATE(CLK_USBD300, "usbd300", "aclk200_fsys", GATE_IP_FSYS, 19, 0,
>> 0),
>> +       GATE(CLK_USBD301, "usbd301", "aclk200_fsys", GATE_IP_FSYS, 20, 0,
>> 0),
>> +       GATE(CLK_SCLK_UNIPRO, "sclk_unipro", "dout_unipro",
>> +                       GATE_IP_FSYS, 23, CLK_SET_RATE_PARENT, 0),
>
>
> Gating an SCLK through an GATE_IP_* register looks a bit unusual. The
> original entry for this clock had SRC_MASK_FSYS register used. Also there is
> the GATE_TOP_SCLK_FSYS register, are you sure that there is no bit for this
> clock there?

Thanks for catching this. SRC_MASK_FSYS is the right offset for this clock.
I will update this in next series.

Regards,
Shaik

>
> Best regards,
> Tomasz
