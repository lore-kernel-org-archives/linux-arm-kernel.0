From: kgene.kim@gmail.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 11:46:13 +0530
Subject: [PATCH 00/12] ARM: S3C24XX: convert s3c2410, s3c2440 s3c2442 to
 common clock framework
In-Reply-To: <52F7DD6E.8070303@gmail.com>
References: <201312131356.40755.heiko@sntech.de> <52F7DD6E.8070303@gmail.com>
Message-ID: <CAL5jtJm=Ehwk2ZyCJaW0NfMn8XM893r1hdCVWs2skMv4+M7yXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-02-10 1:26 GMT+05:30 Tomasz Figa <tomasz.figa@gmail.com>:
> Hi Heiko,
>
>
> On 13.12.2013 13:56, Heiko St?bner wrote:
>>
>> This series converts the earliest s3c socs to use a clock driver based on
>> the
>> common clock framework instead of the old Samsung clock implementation.
>>
>> The only obstacle I found was the configuration of the clkout outputs in
>> the different machines. As I lack hardware test and knowledge on what is
>> expected there, somebody with interest in these machines will have to
>> step up to implement the clkout configuration
>> This can for example be done in the machine_init function after
>> the platform-devices (and thus the dclk-device) are populated.
>>
>> This leaves the s3c2412 soc to be converted, as it has yet another
>> different
>> clock tree.
>>
>> Tested on an Openmoko Neo Freerunner (S3C2442), but of course more tests
>> would be really helpful.
>>
>> Heiko Stuebner (12):
>>    ARM: S3C24XX: cpufreq-utils: don't write raw values to MPLLCON when
>> using ccf
>>    dt-bindings: document s3c24xx controller for external clock output
>>    clk: samsung: add clock driver for external clock outputs
>>    ARM: S3C24XX: enable usage of common dclk if common clock framework is
>> enabled
>>    ARM: S3C24XX: only store clock registers when old clock code is active
>>    clk: samsung: add plls used by the early s3c24xx cpus
>>    dt-bindings: add documentation for s3c2410 clock controller
>>    clk: samsung: add clock controller driver for s3c2410, s3c2440 and
>> s3c2442
>>    ARM: S3C24XX: add platform code for conversion to the common clock
>> framework
>>    ARM: S3C24XX: convert s3c2440 and s3c2442 to common clock framework
>>    ARM: S3C24XX: convert s3c2410 to common clock framework
>>    ARM: S3C24XX: remove legacy clock code
>>
>>   .../bindings/clock/samsung,s3c2410-clock.txt       |   50 ++
>>   .../bindings/clock/samsung,s3c2410-dclk.txt        |   53 ++
>>   arch/arm/mach-s3c24xx/Kconfig                      |   50 +-
>>   arch/arm/mach-s3c24xx/Makefile                     |    6 +-
>>   arch/arm/mach-s3c24xx/clock-dclk.c                 |  195 --------
>>   arch/arm/mach-s3c24xx/clock-s3c2410.c              |  285 -----------
>>   arch/arm/mach-s3c24xx/clock-s3c2440.c              |  217 --------
>>   arch/arm/mach-s3c24xx/clock-s3c244x.c              |  141 ------
>>   arch/arm/mach-s3c24xx/common.c                     |   45 +-
>>   arch/arm/mach-s3c24xx/common.h                     |   11 +-
>>   arch/arm/mach-s3c24xx/cpufreq-utils.c              |   13 +
>>   arch/arm/mach-s3c24xx/include/mach/regs-clock.h    |   18 -
>>   arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |    3 -
>>   arch/arm/mach-s3c24xx/mach-amlm5900.c              |    9 +-
>>   arch/arm/mach-s3c24xx/mach-anubis.c                |   15 +-
>>   arch/arm/mach-s3c24xx/mach-at2440evb.c             |   10 +-
>>   arch/arm/mach-s3c24xx/mach-bast.c                  |   15 +-
>>   arch/arm/mach-s3c24xx/mach-gta02.c                 |    8 +-
>>   arch/arm/mach-s3c24xx/mach-h1940.c                 |   10 +-
>>   arch/arm/mach-s3c24xx/mach-mini2440.c              |   10 +-
>>   arch/arm/mach-s3c24xx/mach-n30.c                   |   12 +-
>>   arch/arm/mach-s3c24xx/mach-nexcoder.c              |   10 +-
>>   arch/arm/mach-s3c24xx/mach-osiris.c                |   15 +-
>>   arch/arm/mach-s3c24xx/mach-otom.c                  |   10 +-
>>   arch/arm/mach-s3c24xx/mach-qt2410.c                |    9 +-
>>   arch/arm/mach-s3c24xx/mach-rx1950.c                |   15 +-
>>   arch/arm/mach-s3c24xx/mach-rx3715.c                |   10 +-
>>   arch/arm/mach-s3c24xx/mach-smdk2410.c              |    9 +-
>>   arch/arm/mach-s3c24xx/mach-smdk2440.c              |   10 +-
>>   arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    9 +-
>>   arch/arm/mach-s3c24xx/mach-vr1000.c                |   15 +-
>>   arch/arm/mach-s3c24xx/pm.c                         |   13 +-
>>   arch/arm/mach-s3c24xx/s3c2410.c                    |   56 ---
>>   arch/arm/mach-s3c24xx/s3c2442.c                    |  111 -----
>>   arch/arm/mach-s3c24xx/s3c244x.c                    |   59 +--
>>   drivers/clk/samsung/Makefile                       |    2 +
>>   drivers/clk/samsung/clk-pll.c                      |  182 +++++++
>>   drivers/clk/samsung/clk-pll.h                      |    3 +
>>   drivers/clk/samsung/clk-s3c2410-dclk.c             |  517
>> ++++++++++++++++++++
>>   drivers/clk/samsung/clk-s3c2410.c                  |  428
>> ++++++++++++++++
>>   include/dt-bindings/clock/samsung,s3c2410-clock.h  |   64 +++
>>   include/dt-bindings/clock/samsung,s3c2410-dclk.h   |   28 ++
>>   42 files changed, 1575 insertions(+), 1176 deletions(-)
>>   create mode 100644
>> Documentation/devicetree/bindings/clock/samsung,s3c2410-clock.txt
>>   create mode 100644
>> Documentation/devicetree/bindings/clock/samsung,s3c2410-dclk.txt
>>   delete mode 100644 arch/arm/mach-s3c24xx/clock-dclk.c
>>   delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2410.c
>>   delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2440.c
>>   delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c244x.c
>>   create mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
>>   create mode 100644 drivers/clk/samsung/clk-s3c2410.c
>>   create mode 100644 include/dt-bindings/clock/samsung,s3c2410-clock.h
>>   create mode 100644 include/dt-bindings/clock/samsung,s3c2410-dclk.h
>>
>
> For patches 4, 5, 9, 10, 11, 12:
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> For patches 6, 7:
>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
>

Really nice series.
Heiko, thanks for your effort and Tomasz, thanks for your review and ack.

OK, I'll apply this whole series and this will be sent to arm-soc in this week.

Thanks,
Kukjin
