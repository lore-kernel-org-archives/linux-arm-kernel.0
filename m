From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 25 Aug 2010 21:22:54 +0800
Subject: [PATCH 1/3] pxa: append tavorevb3 support
In-Reply-To: <201008251519.37402.marek.vasut@gmail.com>
References: <AANLkTi=9TQMgDyGqC23AONyPtW=xTq2kuU=2AR1BzgLu@mail.gmail.com>
	<201008251501.03060.marek.vasut@gmail.com>
	<AANLkTimKCA3QKHXrd9DA6O5Z47qoz+PV2eGb5Gs_WPso@mail.gmail.com>
	<201008251519.37402.marek.vasut@gmail.com>
Message-ID: <AANLkTikSnmQchuVJ=O9NE8ioXD29eNOG0y+ttHTHiLaS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 25, 2010 at 9:19 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne St 25. srpna 2010 15:17:19 Eric Miao napsal(a):
>> On Wed, Aug 25, 2010 at 9:01 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > Dne St 25. srpna 2010 12:43:39 Haojian Zhuang napsal(a):
>> >> From bb6db47adae8d0ce1a12c353c7d898bd3c197d86 Mon Sep 17 00:00:00 2001
>> >> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> >> Date: Thu, 13 May 2010 18:09:27 +0800
>> >> Subject: [PATCH 1/3] pxa: append tavorevb3 support
>> >>
>> >> Bringup tavorevb3 development platform. UART and PMIC are enabled.
>> >>
>> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> >> ---
>> >> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? ? | ? ?4 +
>> >> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 +
>> >> ?arch/arm/mach-pxa/include/mach/mfp-pxa930.h | ? ?7 ++
>> >> ?arch/arm/mach-pxa/pxa930.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
>> >> ?arch/arm/mach-pxa/tavorevb3.c ? ? ? ? ? ? ? | ?136
>> >> +++++++++++++++++++++++++++ 5 files changed, 149 insertions(+), 1
>> >> deletions(-)
>> >> ?create mode 100644 arch/arm/mach-pxa/tavorevb3.c
>> >>
>> >> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
>> >> index 2bfcd10..4b83b9b 100644
>> >> --- a/arch/arm/mach-pxa/Kconfig
>> >> +++ b/arch/arm/mach-pxa/Kconfig
>> >> @@ -41,6 +41,10 @@ config MACH_TAVOREVB
>> >> ? ? ? select PXA3xx
>> >> ? ? ? select CPU_PXA930
>> >>
>> >> +config MACH_TAVOREVB3
>> >> + ? ? bool "PXA95x Development Platform (aka TavorEVB III)"
>> >> + ? ? select CPU_PXA950
>> >> +
>> >> ?config MACH_SAAR
>> >> ? ? ? bool "PXA930 Handheld Platform (aka SAAR)"
>> >> ? ? ? select PXA3xx
>> >> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
>> >> index 85c7fb3..28eef69 100644
>> >> --- a/arch/arm/mach-pxa/Makefile
>> >> +++ b/arch/arm/mach-pxa/Makefile
>> >> @@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_ZYLONITE300) ? ? ?+= zylonite.o
>> >> zylonite_pxa300.o obj-$(CONFIG_MACH_ZYLONITE320) ? ? ?+= zylonite.o
>> >> zylonite_pxa320.o
>> >> ?obj-$(CONFIG_MACH_LITTLETON) += littleton.o
>> >> ?obj-$(CONFIG_MACH_TAVOREVB) ?+= tavorevb.o
>> >> +obj-$(CONFIG_MACH_TAVOREVB3) += tavorevb3.o
>> >> ?obj-$(CONFIG_MACH_SAAR) ? ? ? ? ? ? ?+= saar.o
>> >>
>> >> ?# 3rd Party Dev Platforms
>> >> diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
>> >> b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
>> >> index 0d119d3..04f7c97 100644
>> >> --- a/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
>> >> +++ b/arch/arm/mach-pxa/include/mach/mfp-pxa930.h
>> >> @@ -69,6 +69,7 @@
>> >> ?#define nBE0_GPIO_60 ? ? ? ? MFP_CFG(nBE0, AF0)
>> >> ?#define nBE1_GPIO_61 ? ? ? ? MFP_CFG(nBE1, AF0)
>> >> ?#define RDY_GPIO_62 ? ? ? ? ?MFP_CFG(RDY, AF0)
>> >> +#define PMIC_INT_GPIO83 ? ? ? ? ? ? ?MFP_CFG_LPM(PMIC_INT, AF0,
>> >> PULL_HIGH)
>> >>
>> >> ?/* Chip Select */
>> >> ?#define DF_nCS0_nCS2 ? ? ? ? MFP_CFG_LPM(DF_nCS0, AF3, PULL_HIGH)
>> >> @@ -92,6 +93,9 @@
>> >> ?#define GPIO63_CI2C_SCL ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO63, AF4,
>> >> PULL_HIGH) #define GPIO64_CI2C_SDA ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO64,
>> >> AF4, PULL_HIGH)
>> >>
>> >> +#define GPIO73_CI2C_SCL ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO73, AF1,
>> >> PULL_HIGH) +#define GPIO74_CI2C_SDA ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO74,
>> >> AF1, PULL_HIGH) +
>> >> ?#define GPIO77_CI2C_SCL ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO77, AF2,
>> >> PULL_HIGH) #define GPIO78_CI2C_SDA ? ? ? ? ? ? ?MFP_CFG_LPM(GPIO78,
>> >> AF2, PULL_HIGH)
>> >>
>> >> @@ -345,6 +349,9 @@
>> >> ?#define GPIO69_UART1_CTS ? ? MFP_CFG(GPIO69, AF2)
>> >> ?#define GPIO70_UART1_RTS ? ? MFP_CFG(GPIO70, AF2)
>> >>
>> >> +#define GPIO53_UART1_TXD ? ? MFP_CFG(GPIO53, AF2)
>> >> +#define GPIO54_UART1_RXD ? ? MFP_CFG(GPIO54, AF2)
>> >> +
>> >> ?/* UART2 - BTUART */
>> >> ?#define GPIO91_UART2_RXD ? ? MFP_CFG(GPIO91, AF1)
>> >> ?#define GPIO92_UART2_TXD ? ? MFP_CFG(GPIO92, AF1)
>> >> diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
>> >> index 0642920..7d29dd3 100644
>> >> --- a/arch/arm/mach-pxa/pxa930.c
>> >> +++ b/arch/arm/mach-pxa/pxa930.c
>> >> @@ -192,7 +192,7 @@ static struct mfp_addr_map pxa935_mfp_addr_map[]
>> >> __initdata = {
>> >>
>> >> ?static int __init pxa930_init(void)
>> >> ?{
>> >> - ? ? if (cpu_is_pxa930() || cpu_is_pxa935()) {
>> >> + ? ? if (cpu_is_pxa930() || cpu_is_pxa935() || cpu_is_pxa950()) {
>> >> ? ? ? ? ? ? ? mfp_init_base(io_p2v(MFPR_BASE));
>> >> ? ? ? ? ? ? ? mfp_init_addr(pxa930_mfp_addr_map);
>> >> ? ? ? }
>> >> diff --git a/arch/arm/mach-pxa/tavorevb3.c
>> >> b/arch/arm/mach-pxa/tavorevb3.c new file mode 100644
>> >> index 0000000..5eeba64
>> >> --- /dev/null
>> >> +++ b/arch/arm/mach-pxa/tavorevb3.c
>> >> @@ -0,0 +1,136 @@
>> >> +/*
>> >> + * ?linux/arch/arm/mach-pxa/tavorevb3.c
>> >> + *
>> >> + * ?Support for the Marvell EVB3 Development Platform.
>> >> + *
>> >> + * ?Copyright: ?(C) Copyright 2008-2010 Marvell International Ltd.
>> >
>> > So, who should I contact for support if this doesn't work/ need fixing ?
>>
>> Indeed. Haojian, would be good if you are willing to maintain this and
>> put your name as Maintainer below the MACHINE_START() or here
>> in the comment?
>
> Also into MAINTAINERS, but I haven't checked if there's some entry for it
> already or not.

I think Haojian is willing to co-maintain the mmp series with me :-)
