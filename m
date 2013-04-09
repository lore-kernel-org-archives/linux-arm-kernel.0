From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 9 Apr 2013 05:31:22 +0000
Subject: [PATCH] ARM: davinci: da850 evm: update clock rate for UART 1/2
 DT nodes
In-Reply-To: <51433233.9070303@ti.com>
References: <1361262734-8540-1-git-send-email-prakash.pm@ti.com>
 <512F33F3.9070203@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA49090@DBDE01.ent.ti.com>
 <51433233.9070303@ti.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4C535@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 20:07:39, Nori, Sekhar wrote:
> 
> 
> On 3/15/2013 6:56 PM, Manjunathappa, Prakash wrote:
> > Hi Sekhar,
> > 
> > On Thu, Feb 28, 2013 at 16:09:47, Nori, Sekhar wrote:
> >> Prakash,
> >>
> >> On 2/19/2013 2:02 PM, Manjunathappa, Prakash wrote:
> >>> DT kernel with latest of denx SPL U-boot boots with garbled UART
> >>> logs. This is because in U-boot UART2 gets sourced by PLL0_SYSCLK2
> >>> configured for 150MHz. But later in kernel UART2 gets mapped to
> >>> PLL1_SYSCLK2 and is configured for 132MHz not for 150MHz.
> >>>
> >>> PLL1 is configured for 264MHz to support mDDR on the EVM. That is
> >>> memory controller driving mDDR can be configured for 150MHz and
> >>> mDDR it self can operate at 132MHz.
> >>>
> >>> So override UART1 and UART2 DT node clock-frequency property with
> >>> rate available on da850 EVM.
> >>>
> >>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> >>
> >> How about dropping the clock-frequency attribute altogether? of_serial.c
> >> seems to be falling back on clk apis if frequency is not passed and that
> >> should make the kernel work with all versions of U-Boot.
> >>
> > 
> > Yes it can be dropped by having duplicate clock node for UART having only
> 
> You meant an additional clk_lookup entry? That's different from a new
> 'struct clk' node.
> 

Yes I meant adding to clk_lookup, not new 'struct clk'.

> > dev_id. This is required because DT kernel does the clk_get with only dev_id
> > and non-DT kernel only with con_id. In DT kernel clk_get is done from generic
> > code of_platform_serial_setup:of_serial.c and in non-DT kernel is done from
> > platform code, davinci_serial_setup_clk:arch/arm/mach-davinci/serial.c
> > 
> > Please let me know your opinion on this.
> 
> When only one clock is present, con_id of NULL is more appropriate. How
> about fixing arch/arm/mach-davinci/serial.c and existing clk_lookup
> entries to use this?
> 

Ok I will share patch which fixes this.

Thanks,
Prakash
