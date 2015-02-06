From: wangbintian@gmail.com (Brent Wang)
Date: Fri, 6 Feb 2015 15:32:13 +0800
Subject: [PATCH 2/3] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150205192533.GE20735@leverpostej>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-3-git-send-email-bintian.wang@huawei.com>
 <20150205192533.GE20735@leverpostej>
Message-ID: <CAAS=xmjURtR6Nhubg7JptXgtUGtZs8090FHJutnCaau4GzqZzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2015-02-06 3:25 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Feb 05, 2015 at 09:24:36AM +0000, Bintian Wang wrote:
>> Add clock drivers for hi6220 SoC, this driver controls the SoC
>> registers to supply different clocks to different IPs in the SoC.
>>
>> We add one divider clock for hi6220 because the divider in hi6220
>> also has a mask bit but it doesnot obey the rule defined by flag
>> "CLK_DIVIDER_HIWORD_MASK", we can not get index of the mask bit by
>> left shift fixed bits (e.g. 16 bits), so we add this divider clock
>> to handle it.
>>
>> This patch also enables this clock driver for ARCH_HISI and document
>> devicetree bindings.
>>
>> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
>> Reviewed-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>  .../devicetree/bindings/clock/hi6220-clock.txt     |   30 +++
>>  arch/arm64/Kconfig                                 |    1 +
>>  drivers/clk/Kconfig                                |    2 +
>>  drivers/clk/Makefile                               |    4 +-
>>  drivers/clk/hisilicon/Kconfig                      |    5 +
>>  drivers/clk/hisilicon/Makefile                     |    1 +
>>  drivers/clk/hisilicon/clk-hi6220.c                 |  284 ++++++++++++++++++++
>>  drivers/clk/hisilicon/clk.c                        |   29 ++
>>  drivers/clk/hisilicon/clk.h                        |   17 ++
>>  drivers/clk/hisilicon/clkdivider-hi6220.c          |  273 +++++++++++++++++++
>>  include/dt-bindings/clock/hi6220-clock.h           |  172 ++++++++++++
>>  11 files changed, 815 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hi6220-clock.txt
>>  create mode 100644 drivers/clk/hisilicon/Kconfig
>>  create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
>>  create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
>>  create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hi6220-clock.txt b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
>> new file mode 100644
>> index 0000000..a3ddda1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hi6220-clock.txt
>> @@ -0,0 +1,30 @@
>> +* Hisilicon Hi6220 Clock Controller
>> +
>> +The hi6220 clock controller generates and supplies clock to various
>> +controllers within the hi6220 SoC.
>> +
>> +Required Properties:
>> +
>> +- compatible: should be one of the following:
>> +  - "hisilicon,hi6220-clock-ao" - controller for those clocks under SoC
>> +     power always on(AO) domain, it is the sub node of SoC power AO
>> +     controller in dts file.
>> +  - "hisilicon,hi6220-clock-sys" - controller for those clocks under SoC
>> +     system control domain, it is the sub node of SoC system controller
>> +     in dts file.
>> +  - "hisilicon,hi6220-clock-media" - controller for those clocks under
>> +     SoC media control domain, it is the sub node of SoC media controller
>> +     in dts file.
>> +  - "hisilicon,hi6220-clock-power" - controller for those clocks under
>> +     SoC power control domain, it is the sub node of SoC power controller
>> +     in dts file.
>
> These all refer to things which aren't documented (yet).
>
> Please sort out your patches so that any documentation you depend on
> comes earlier.
>
> Please also separate documentation from code. Note that dt includes are
> _bindings_ and should be added with the relevant documentation.
Thanks for help to review, I also think separate documentation from
code is better
way, it will be fixed in next version.

Thanks,

Bintian
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
