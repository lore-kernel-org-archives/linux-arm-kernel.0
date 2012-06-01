From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 2 Jun 2012 01:06:41 +0530
Subject: [PATCH v5 1/7] ARM: davinci, cp_intc: Add irq domain support
In-Reply-To: <1338373143-7467-2-git-send-email-hs@denx.de>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-2-git-send-email-hs@denx.de>
Message-ID: <4FC919C9.6070107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 5/30/2012 3:48 PM, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> 
> ---

On AM18x EVM, with this patch applied and CONFIG_KEYBOARD_GPIO_POLLED=y,
I get warnings of type:

irq 0, desc: c0372950, depth: 1, count: 0, unhandled: 0

->handle_irq():  c00552f8, handle_bad_irq+0x0/0x23c

->irq_data.chip(): c03794e8, 0xc03794e8

->action():   (null)

   IRQ_NOPROBE set

 IRQ_NOREQUEST set


They do not come when CONFIG_KEYBOARD_GPIO_POLLED=n. I am yet to debug
this, but wanted to point out now in case there is anything obvious.

# cat /proc/interrupts
           CPU0

  0:         32      none

 11:          0   cp_intc  edma

 12:          0   cp_intc  edma_error

 15:    1048613   cp_intc  i2c_davinci

 21:      50992   cp_intc  clockevent

 22:         17   cp_intc  free-run counter

 33:          0   cp_intc  eth0

 34:      13747   cp_intc  eth0

 35:       5032   cp_intc  eth0

 36:          0   cp_intc  eth0

 52:     162759   cp_intc  da8xx_lcdc

 61:        270   cp_intc  serial

 93:          0   cp_intc  edma

 94:          0   cp_intc  edma_error

Err:         32


The interrupt number 0 shows up which seems to be causing these warnings.

I also had to select IRQ_DOMAIN for CP_INTC in
arch/arm/mach-davinci/Kconfig to make the kernel builds after applying
this patch.

Thanks,
Sekhar
