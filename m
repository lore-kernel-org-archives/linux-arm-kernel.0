From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 13 Nov 2013 21:25:41 +0800
Subject: [PATCH v11 1/2] clk: hisilicon: add common clock support
In-Reply-To: <20131113123927.GG21713@e106331-lin.cambridge.arm.com>
References: <1384306274-27315-1-git-send-email-haojian.zhuang@gmail.com>
 <1384306274-27315-2-git-send-email-haojian.zhuang@gmail.com>
 <20131113123927.GG21713@e106331-lin.cambridge.arm.com>
Message-ID: <CAN1soZy7-40ZdJ4fKqPHHsc+Rg-dR3B5KDi_dJyO+OJFo5J02Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 8:39 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Nov 13, 2013 at 01:31:13AM +0000, Haojian Zhuang wrote:
>> Enable common clock driver of Hi3620 SoC. clkgate-seperated driver is
>> used to support the clock gate that enable/disable/status registers
>> are seperated.
>
> Typo: s/seperated/separated/
>
> That seems to apply throughout the code and comments too.
>
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>  .../devicetree/bindings/clock/hi3620-clock.txt     |  19 ++
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/hisilicon/Makefile                     |   5 +
>>  drivers/clk/hisilicon/clk-hi3620.c                 | 242 +++++++++++++++++++++
>>  drivers/clk/hisilicon/clk.c                        | 171 +++++++++++++++
>>  drivers/clk/hisilicon/clk.h                        | 103 +++++++++
>>  drivers/clk/hisilicon/clkgate-seperated.c          | 130 +++++++++++
>>  include/dt-bindings/clock/hi3620-clock.h           | 152 +++++++++++++
>>  8 files changed, 823 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hi3620-clock.txt
>>  create mode 100644 drivers/clk/hisilicon/Makefile
>>  create mode 100644 drivers/clk/hisilicon/clk-hi3620.c
>>  create mode 100644 drivers/clk/hisilicon/clk.c
>>  create mode 100644 drivers/clk/hisilicon/clk.h
>>  create mode 100644 drivers/clk/hisilicon/clkgate-seperated.c
>>  create mode 100644 include/dt-bindings/clock/hi3620-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hi3620-clock.txt b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
>> new file mode 100644
>> index 0000000..80e134d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
>> @@ -0,0 +1,19 @@
>> +* Hisilicon Hi3620 Clock Controller
>> +
>> +The Hi3620 clock controller generates and supplies clock to various
>> +controllers within the Hi3620 SoC.
>> +
>> +Required Properties:
>> +
>> +- comptible: should be one of the following.
>
> s/comptible/compatible/
>
>> +  - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
>> +
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +
>> +- #clock-cells: should be 1.
>> +
>> +Each clock is assigned an identifier and client nodes use this identifier
>> +to specify the clock which they consume.
>> +
>> +All these identifier could be found in <dt-bindings/clock/hi3620-clock.h>.
>
> With the typo fixed, the binding looks fine to me.
>
> [...]
>
>> +struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
>> +                                     const char *parent_name,
>> +                                     unsigned long flags,
>> +                                     void __iomem *reg, u8 bit_idx,
>> +                                     u8 clk_gate_flags, spinlock_t *lock)
>> +{
>> +       struct clkgate_seperated *sclk;
>> +       struct clk *clk;
>> +       struct clk_init_data init;
>> +
>> +       sclk = kzalloc(sizeof(struct clkgate_seperated), GFP_KERNEL);
>
> This could be neater:
>
> sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
>
> Thanks,
> Mark.

OK. I'll fix it.

Mike,
I hope this patch could be merged into arm-soc tree. Could you help to
review this patch?

Regards
Haojian
