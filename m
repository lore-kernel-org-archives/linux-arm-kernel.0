From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Thu, 3 Mar 2016 00:04:22 +0800
Subject: [PATCH v2 13/13] ARM: sunxi: Introduce MACH_SUN8I_A83T option
In-Reply-To: <20160301071253.GI8418@lukather>
References: <1456672738-4993-1-git-send-email-vishnupatekar0510@gmail.com>
 <1456672738-4993-14-git-send-email-vishnupatekar0510@gmail.com>
 <20160301071253.GI8418@lukather>
Message-ID: <CAEzqOZt2khVambkoCcBNwvQU2pQiWzbEs5cKZJBaAqD0p3T++g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On Tue, Mar 1, 2016 at 3:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, Feb 28, 2016 at 11:18:58PM +0800, Vishnu Patekar wrote:
>> A83T has CPUS clock similar to A80's. currently, a80 cpus clock only
>> compiled for A80. So, Introduce MACH_SUN8I_A83T to compile it for
>> A83T as well.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>> ---
>>  arch/arm/mach-sunxi/Kconfig | 5 +++++
>>  drivers/clk/sunxi/Makefile  | 3 +++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>> index c124d65..424b76d 100644
>> --- a/arch/arm/mach-sunxi/Kconfig
>> +++ b/arch/arm/mach-sunxi/Kconfig
>> @@ -41,6 +41,11 @@ config MACH_SUN8I
>>       select ARM_GIC
>>       select MFD_SUN6I_PRCM
>>
>> +config MACH_SUN8I_A83T
>> +     bool "Allwinner A83T (sun8i) SoCs support"
>> +     default ARCH_SUNXI
>> +     select ARM_GIC
>> +
>>  config MACH_SUN9I
>>       bool "Allwinner (sun9i) SoCs support"
>>       default ARCH_SUNXI
>> diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
>> index 3fd7901..2aabfc4 100644
>> --- a/drivers/clk/sunxi/Makefile
>> +++ b/drivers/clk/sunxi/Makefile
>> @@ -20,6 +20,9 @@ obj-y += clk-usb.o
>>  obj-$(CONFIG_MACH_SUN9I) += clk-sun8i-apb0.o
>>  obj-$(CONFIG_MACH_SUN9I) += clk-sun9i-cpus.o
>>
>> +obj-$(CONFIG_MACH_SUN8I_A83T) += clk-sun8i-apb0.o
>> +obj-$(CONFIG_MACH_SUN8I_A83T) += clk-sun9i-cpus.o
>> +
>
> This is not how it should be done. You should rather create a Kconfig
> option for these clocks, and use def_bool CONFIG_MACH_SUN8I || CONFIG_MACH_SUN9I
>
> Switching to Kconfig for the clocks has been on my todo-list for quite
> some time, I guess these two clocks would be a good start.
Okie, I'll create Kconfig in clk/sunxi as below:
config CLK_SUN8I_APB0
def_bool MACH_SUN9I || MACH_SUN8I_A83T

config CLK_SUN9I_CPUS
def_bool MACH_SUN9I || MACH_SUN8I_A83T

We still need to have MACH_SUN8I_A83T to differentiate between
MFD_SUN6I_PRCM which is used by other sun8i platforms.

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
