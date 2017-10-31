From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 31 Oct 2017 11:28:12 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171002020618.23924-4-nicolas.pitre@linaro.org>
References: <20171002020618.23924-1-nicolas.pitre@linaro.org>
 <20171002020618.23924-4-nicolas.pitre@linaro.org>
Message-ID: <PS1PR06MB1162212F37C8BA7EE367FE828A5E0@PS1PR06MB1162.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 01, 2017 1, Nicolas Pitre wrote:
> With printch() the console messages are sent out one character at a time
> which is agonizingly slow especially with semihosting as the whole trap
> intercept, remote byte access, and system resume danse is performed for
> every single character across a relatively slow remote debug connection.
> Let's use printascii() to send a whole string at once. This is also going
> to be more efficient, albeit to a quite lesser extent, with serial ports
> as well.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/kernel/early_printk.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Now that this patch has hit -next, I'm noticing an issue with it.

There are no carriage returns, just line feeds, which makes for a very 
ugly display.


For example:

Booting Linux...
[    0.000000] Booting Linux on physical CPU 0x0
                                                [    0.000000] Linux version 4.14.0-rc5-00014-g5689707d65e6 (chris at ubuntu) (gcc version 5.4.1 20161213 (Linaro GCC 5.4-2017.01)) #735 Mon Oct 30 12:59:37 EST 2017
                                                                                          [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=58c53c7d
                                                [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
               [    0.000000] OF: fdt: Machine model: RSKRZA1
                                                             [    0.000000] debug: ignoring loglevel setting.
                                                                                                             [    0.000000] bootconsole [earlycon0] enabled
                                   [    0.000000] Memory policy: Data cache writeback
                                                                                     [    0.000000] On node 0 totalpages: 8192
      [    0.000000] free_area_init_node: node 0, pgdat c003dfb4, node_mem_map c1fb8000
                                                                                       [    0.000000]   Normal zone: 64 pages used for memmap
                     [    0.000000]   Normal zone: 0 pages reserved
                                                                   [    0.000000]   Normal zone: 8192 pages, LIFO batch:0
 [    0.000000] CPU: All CPU(s) started in SVC mode.




Of course as soon as the normal console driver is loaded later it boot, 
everything looks fine again. But I use early_printk a lot, so I wonder 
if I could get my carriage returns back.

Chris
