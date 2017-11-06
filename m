From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 6 Nov 2017 17:38:12 +0800
Subject: [PATCH] clk: meson: gxbb: fix wrong clock for SARADC/SANA
In-Reply-To: <1509959454.1328.8.camel@baylibre.com>
References: <20171106075212.14275-1-yixun.lan@amlogic.com>
 <1509959454.1328.8.camel@baylibre.com>
Message-ID: <9b1f5cb5-9029-8865-a867-54d819b42e1a@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome:

On 11/06/17 17:10, Jerome Brunet wrote:
> On Mon, 2017-11-06 at 15:52 +0800, Yixun Lan wrote:
>> According to the datasheet, in Meson-GXBB/GXL series,
>> The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
>> while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].
>>
>> Test passed at gxl_skt dev board.
> I think this refer to a board naming used in amlogic vendor kernel ?
> Would you mind telling what it is ?
> 
>>
>> Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> Subject is missing "v2" tag and a reference to the previous message:
> 20171103181703.30434-1-yixun.lan at amlogic.com
> 
Ok..
I was considering this patch as a new one, so didn't add a v2 tag

>>
>> ---
>> I think this error was introduced by a copy & paste from meson8 code?
>> and we didn't notice them due to the SANA clock is also enabled by
>> DTS (so SAR_ADC works fine)?
>> ---
>>  drivers/clk/meson/gxbb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>> index b2d1e8ed7152..92168348ffa6 100644
>> --- a/drivers/clk/meson/gxbb.c
>> +++ b/drivers/clk/meson/gxbb.c
>> @@ -1139,7 +1139,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_MPEG0, 6);
>>  static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
>>  static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
>>  static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
>> -static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
>> +static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
>>  static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
>>  static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
>>  static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
>> @@ -1190,7 +1190,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge, HHI_GCLK_MPEG2,
>> 9);
>>  static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
>>  static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
>>  static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
>> -static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
>> +static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
> 
> The value currently used in the driver are with respect to the
> Datasheet of GXBB (v1.1.4) and GXL (S905X - V0.3-20170314), which are available
> to the public at http://http://linux-meson.com
> 
> the adc driver is claiming both clock, so this patch should not change anything
> to the adc operation.
> 
> * Is this patch fixing any issue ?
this will remove the un-used 'sana' clock from saradc,
to reflect how the hardware actually work..

there is no function changed

> * Is it an error in the published datasheets ?
then, I think the published datasheet need to be updated.

> 
>>  static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
>>  static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
>>  static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
> 
> .
> 
