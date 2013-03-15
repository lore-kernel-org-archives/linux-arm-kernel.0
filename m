From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Fri, 15 Mar 2013 13:26:25 +0000
Subject: [PATCH] ARM: davinci: da850 evm: update clock rate for UART 1/2
 DT nodes
In-Reply-To: <512F33F3.9070203@ti.com>
References: <1361262734-8540-1-git-send-email-prakash.pm@ti.com>
 <512F33F3.9070203@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA49090@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Thu, Feb 28, 2013 at 16:09:47, Nori, Sekhar wrote:
> Prakash,
> 
> On 2/19/2013 2:02 PM, Manjunathappa, Prakash wrote:
> > DT kernel with latest of denx SPL U-boot boots with garbled UART
> > logs. This is because in U-boot UART2 gets sourced by PLL0_SYSCLK2
> > configured for 150MHz. But later in kernel UART2 gets mapped to
> > PLL1_SYSCLK2 and is configured for 132MHz not for 150MHz.
> > 
> > PLL1 is configured for 264MHz to support mDDR on the EVM. That is
> > memory controller driving mDDR can be configured for 150MHz and
> > mDDR it self can operate at 132MHz.
> > 
> > So override UART1 and UART2 DT node clock-frequency property with
> > rate available on da850 EVM.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> 
> How about dropping the clock-frequency attribute altogether? of_serial.c
> seems to be falling back on clk apis if frequency is not passed and that
> should make the kernel work with all versions of U-Boot.
> 

Yes it can be dropped by having duplicate clock node for UART having only
dev_id. This is required because DT kernel does the clk_get with only dev_id
and non-DT kernel only with con_id. In DT kernel clk_get is done from generic
code of_platform_serial_setup:of_serial.c and in non-DT kernel is done from
platform code, davinci_serial_setup_clk:arch/arm/mach-davinci/serial.c

Please let me know your opinion on this.

Thanks,
Prakash

> Thanks,
> Sekhar
> 
> > ---
> >  arch/arm/boot/dts/da850-evm.dts |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> > index f712fb6..c359872 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -22,9 +22,11 @@
> >  			status = "okay";
> >  		};
> >  		serial1: serial at 1d0c000 {
> > +			clock-frequency = <132000000>;
> >  			status = "okay";
> >  		};
> >  		serial2: serial at 1d0d000 {
> > +			clock-frequency = <132000000>;
> >  			status = "okay";
> >  		};
> >  		rtc0: rtc at 1c23000 {
> > 
> 
