From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 10 Aug 2011 17:34:33 +0530
Subject: [RFC][PATCH 1/2] S5PV210: SPI: Add clkdev support
In-Reply-To: <4E413941.10307@samsung.com>
References: <1312898222-7165-1-git-send-email-padma.v@samsung.com>
	<4E413941.10307@samsung.com>
Message-ID: <CAAgF-BftGYkZ6aaSZgxd8gk1Zy9-sJEroZcaijd6zN3Qr9MEhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On Tue, Aug 9, 2011 at 7:12 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> [corrected Jassi's email address]
>
> On 08/09/2011 03:57 PM, Padmavathi Venna wrote:
>> Create a clkdev alias for spi bus clock and modify the spi
>> driver to lookup the clock using the alias name instead of
>> passing clock name and clock number from SPI platform data.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>> ---
>> This patch is tested for S5PV210 platform and similar
>> changes can be adopted for rest of the Samsung's s3c
>> and s5p platforms, if this approach is accepted.
>
> It is a bit surprising to me how you do intend to use the clock aliases.
> Are we seriously going to be creating clock con_id aliases for most
> of the available devices ? It doesn't sound sane to me..
We don't need to create the alias names for all the devices. But we need
to create only for those which need clock information from platform data.
As far as I know we need to create for spi,hsmmc,uart and iis.
>
> Wouldn't it be possible to avoid the aliases by correcting the clock
> registration process ?
Yes it is possible but we don't have the flexibility to create the alias names
only for the required clocks.
>
>> ?arch/arm/mach-s5pv210/dev-spi.c ? ? ? ? ? ? ? ? ?| ? 31 ++++++++++++++++++---
>> ?arch/arm/plat-samsung/include/plat/s3c64xx-spi.h | ? ?7 +----
>> ?2 files changed, 27 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/dev-spi.c b/arch/arm/mach-s5pv210/dev-spi.c
> ...
>> -void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
>> +void __init s5pv210_spi_set_info(int cntrlr, int num_cs)
>> ?{
>> ? ? ? struct s3c64xx_spi_info *pd;
>> + ? ? struct device *dev;
>> + ? ? char devname[16], clk_alias_name[16];
>> + ? ? int ret, i;
>>
>> ? ? ? /* Reject invalid configuration */
>> - ? ? if (!num_cs || src_clk_nr < 0
>> - ? ? ? ? ? ? ? ? ? ? || src_clk_nr > S5PV210_SPI_SRCCLK_SCLK) {
>> + ? ? if (!num_cs) {
>> ? ? ? ? ? ? ? printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>> @@ -159,9 +162,11 @@ void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
>> ? ? ? switch (cntrlr) {
>> ? ? ? case 0:
>> ? ? ? ? ? ? ? pd = &s5pv210_spi0_pdata;
>> + ? ? ? ? ? ? dev = &s5pv210_device_spi0.dev;
>> ? ? ? ? ? ? ? break;
>> ? ? ? case 1:
>> ? ? ? ? ? ? ? pd = &s5pv210_spi1_pdata;
>> + ? ? ? ? ? ? dev = &s5pv210_device_spi1.dev;
>> ? ? ? ? ? ? ? break;
>> ? ? ? default:
>> ? ? ? ? ? ? ? printk(KERN_ERR "%s: Invalid SPI controller(%d)\n",
>> @@ -169,7 +174,23 @@ void __init s5pv210_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
>> ? ? ? ? ? ? ? return;
>> ? ? ? }
>>
>> + ? ? sprintf(devname, "s3c64xx-spi.%d", cntrlr);
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(spi_src_clks); i++) {
>> + ? ? ? ? ? ? sprintf(clk_alias_name, "clk_spi_bus%d", i);
>> +
>> + ? ? ? ? ? ? if (!strcmp(spi_src_clks[i], "pclk"))
>> + ? ? ? ? ? ? ? ? ? ? ret = clk_add_alias(clk_alias_name, devname,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spi_src_clks[i], NULL);
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? ret = clk_add_alias(clk_alias_name, devname,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? spi_src_clks[i], dev);
>> + ? ? ? ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? ? ? ? printk(KERN_ERR "failed to create alias for"
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? " SPI%d source clock%d\n", cntrlr, i);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> ? ? ? pd->num_cs = num_cs;
>> - ? ? pd->src_clk_nr = src_clk_nr;
>> - ? ? pd->src_clk_name = spi_src_clks[src_clk_nr];
>> ?}
> ...
>
> --
> Thanks,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
