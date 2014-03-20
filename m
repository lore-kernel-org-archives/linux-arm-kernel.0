From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Mar 2014 08:07:52 +0100
Subject: Forcing DEBUG_UART_{PHYS,
 VIRT} changes when switching between v7 platforms?
In-Reply-To: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
References: <CAGVrzcZT+3VuuM9wdLTAu7wtbYTFcwSnMaYE7PcR8Eo4PmTnhg@mail.gmail.com>
Message-ID: <8099777.qvOx0M5YBS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014 16:38:45 Florian Fainelli wrote:
> Hi,
> 
> When switching between different Multi v7 platform which all select
> DEBUG_UART_8250, whichever platform managed to set
> DEBUG_UART_{PHYS,VIRT} first will end-up forcing its value to the
> others.
> 
> What I am seeing at the moment is for instance enabling BCM_MOBILE
> will set DEBUG_UART_PHYS to 0x3e000000, disabling BCM_MOBILE and now
> enabling MVEBU won't force a new DEBUG_UART_PHYS address to be
> re-computed.
> 
> Should we add some sort of specific annotation to the Kconfig symbol
> to force a recalculation of the UART PHYS address?

Russell has plans to change the Konfig logic in the future, removing the
platform specific options. With the current code, you could probably
do something along the lines of

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f72147f..aa20929 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1013,7 +1013,7 @@ config DEBUG_UART_8250
 		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
 
 config DEBUG_UART_PHYS
-	hex "Physical base address of debug UART"
+	hex
 	default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
@@ -1074,7 +1074,7 @@ config DEBUG_UART_PHYS
 		DEBUG_UART_8250 || DEBUG_UART_PL01X
 
 config DEBUG_UART_VIRT
-	hex "Virtual base address of debug UART"
+	hex
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf0009000 if DEBUG_CNS3XXX

with some extra logic to still allow you to enter the values
manually if not set by default, but that probably wouldn't work
any more when the rework is done.

	Arnd
