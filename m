From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Aug 2013 21:01:51 +0200
Subject: [RFC v1 3/5] ARM: mvebu: add Armada 150 uart to lowlevel debug
In-Reply-To: <1376682098-10580-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376682098-10580-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308172101.51537.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 August 2013, Sebastian Hesselbarth wrote:
> 
> -#ifdef CONFIG_DEBUG_MVEBU_UART_ALTERNATE
> -#define ARMADA_370_XP_REGS_PHYS_BASE   0xf1000000
> -#else
> -#define ARMADA_370_XP_REGS_PHYS_BASE   0xd0000000
> +#if defined(CONFIG_MACH_ARMADA_1500)
> +#define MVEBU_REGS_PHYS_BASE   0xf7f80000
> +#define MVEBU_REGS_VIRT_BASE   0xf7f80000
> +#define MVEBU_UART0_OFFSET     0x00049000
> +#elif defined(CONFIG_DEBUG_MVEBU_UART)
> +#define MVEBU_REGS_PHYS_BASE   0xd0000000
> +#define MVEBU_REGS_VIRT_BASE   0xfec00000
> +#define MVEBU_UART0_OFFSET     0x00012000
> +#else /* CONFIG_DEBUG_MVEBU_UART_ALTERNATE */

It seems wrong to base this on CONFIG_MACH_ARMADA_1500. I think you need to
add a new config option just like we have for all other platforms. The above
makes it impossible to build a multiplatform kernel and select 
CONFIG_DEBUG_MVEBU_UART for debugging while keeping CONFIG_MACH_ARMADA_1500
enabled.

	Arnd
