From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 14:40:58 +0000
Subject: AT91 reboot code
Message-ID: <20111101144058.GP19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arch/arm/mach-at91/include/mach/system.h, I find:

void (*at91_arch_reset)(void);

static inline void arch_reset(char mode, const char *cmd)
{
        /* call the CPU-specific reset function */
        if (at91_arch_reset)
                (at91_arch_reset)();
}

Is there any reason this can't just be:

void (*arch_reset)(char mode, const char *cmd);

and then change these:

arch/arm/mach-at91/at91rm9200.c:    at91_arch_reset = at91rm9200_reset;
arch/arm/mach-at91/at91sam9263.c:   at91_arch_reset = at91sam9_alt_reset;
arch/arm/mach-at91/at91sam9260.c:   at91_arch_reset = at91sam9_alt_reset;
arch/arm/mach-at91/at91sam9g45.c:   at91_arch_reset = at91sam9g45_reset;
arch/arm/mach-at91/at91cap9.c:      at91_arch_reset = at91cap9_reset;
arch/arm/mach-at91/at91sam9261.c:   at91_arch_reset = at91sam9_alt_reset;
arch/arm/mach-at91/at91sam9rl.c:    at91_arch_reset = at91sam9_alt_reset;

and the assigned function prototypes appropriately?  This level of
additional indirection is a right pain for trying to clean up stuff in
this area and it needs to die.
