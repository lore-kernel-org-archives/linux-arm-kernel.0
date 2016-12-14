From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Dec 2016 10:47:07 -0800
Subject: [PATCH v3 1/2] ARM: ep93xx: Register ts73xx-fpga manager driver
 for TS-7300
In-Reply-To: <CAAtXAHcO4bN2YmrEabiivnBJLXdU56j4rv4A12FL_XKuwc5Dxw@mail.gmail.com>
References: <20161214023553.9377-1-f.fainelli@gmail.com>
 <20161214023553.9377-2-f.fainelli@gmail.com>
 <CAAtXAHcO4bN2YmrEabiivnBJLXdU56j4rv4A12FL_XKuwc5Dxw@mail.gmail.com>
Message-ID: <322992d6-a6f9-3893-7edc-52e4b7649b3e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2016 10:14 PM, Moritz Fischer wrote:
> Hi Florian,
> 
> On Tue, Dec 13, 2016 at 6:35 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> Register the TS-7300 FPGA manager device drivers which allows us to load
>> bitstreams into the on-board Altera Cyclone II FPGA.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/arm/mach-ep93xx/ts72xx.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
>> index 3b39ea353d30..acf72ea670ef 100644
>> --- a/arch/arm/mach-ep93xx/ts72xx.c
>> +++ b/arch/arm/mach-ep93xx/ts72xx.c
>> @@ -230,6 +230,28 @@ static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
>>         .phy_id         = 1,
>>  };
>>
>> +#if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
>> +
>> +/* Relative to EP93XX_CS1_PHYS_BASE */
>> +#define TS73XX_FPGA_LOADER_BASE                0x03c00000
>> +
>> +static struct resource ts73xx_fpga_resources[] = {
>> +       {
>> +               .start  = EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE,
>> +               .end    = EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE + 1,
>> +               .flags  = IORESOURCE_MEM,
>> +       },
>> +};
>> +
>> +static struct platform_device ts73xx_fpga_device = {
>> +       .name   = "ts73xx-fpga-mgr",
>> +       .id     = -1,
>> +       .resource = ts73xx_fpga_resources,
>> +       .num_resources = ARRAY_SIZE(ts73xx_fpga_resources),
>> +};
>> +
>> +#endif
>> +
>>  static void __init ts72xx_init_machine(void)
>>  {
>>         ep93xx_init_devices();
>> @@ -238,6 +260,10 @@ static void __init ts72xx_init_machine(void)
>>         platform_device_register(&ts72xx_wdt_device);
>>
>>         ep93xx_register_eth(&ts72xx_eth_data, 1);
>> +#if IS_ENABLED(CONFIG_FPGA_MGR_TS73XX)
>> +       if (board_is_ts7300())
>> +               platform_device_register(&ts73xx_fpga_device);
>> +#endif
>>  }
>>
>>  MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
>> --
>> 2.9.3
>>
> 
> I think this is backwards, shouldn't this be your [PATCH 2/2]?
> Otherwise you're using
> the driver before you added it.

I can definitively re-order the patches, although I don't think this
really makes a difference, a driver without device does nothing, and
vice versa.
-- 
Florian
