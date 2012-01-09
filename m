From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Jan 2012 14:44:43 +0000
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <4F0AF198.1030803@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org> <4F0ACD35.1000600@linaro.org>
 <20120109112920.GJ21765@n2100.arm.linux.org.uk> <4F0AF198.1030803@linaro.org>
Message-ID: <20120109144443.GQ21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 02:54:32PM +0100, Daniel Lezcano wrote:
> On 01/09/2012 12:29 PM, Russell King - ARM Linux wrote:
> > On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
> >> Actually, the header moves from :
> >>
> >> 	arch/arm/mach-at91/pm.h
> >> to:
> >> 	arch/arm/include/asm/at91_pm.h.
> >>
> >> This place and the renaming of the file complies with the comments of
> >> Russell,
> > 
> > No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
> > to be littered with hundreds of crappy platform specific header files.
> 
> Ok. Actually there are 9 pm.h files but I agree with a domino effect we
> can have more header files brought to this directory like "control.h",
> "powerdomain.h", etc ...
> 
> Does it make sense to merge all the pm.h file in a single pm.h which
> will be located in arch/arm/include/asm ?

No it doesn't.  If moving something out of arch/arm means that we have to
buggerize the header files, then moving it out of arch/arm is the wrong
thing to do.  What the need to bugger about with header files is telling
you is that the code you're moving (in its existing form) is intimitely
tied to the SoC.

There's two solutions to that: either leave it where it is, or first
sort out why it's intimitely tied, and what can be done to remove its
dependence on the SoC.

I've finally taken a deeper look at what's going on here... 

arch/arm/mach-at91/pm.h is full of crap:

#ifdef CONFIG_ARCH_AT91RM9200
static inline u32 sdram_selfrefresh_enable(void)
{
...
}
#elif defined(CONFIG_ARCH_AT91CAP9)
static inline u32 sdram_selfrefresh_enable(void)
{
...
}
#elif defined(CONFIG_ARCH_AT91SAM9G45)
static inline u32 sdram_selfrefresh_enable(void)
{
...
}
#else
static inline u32 sdram_selfrefresh_enable(void)
{
...
}
#endif

And there's no way this should ever move out of arch/arm/mach-at91,
ever.  It's a totally broken structure, and it needs fixing.  A first
step, from just looking at the file, to fix this within the bounds of
AT91 would be:

struct at91_pm_ops {
	u32 (*sdram_selfrefresh_enable)(void);
	void (*sdram_selfrefresh_disable)(u32);
	void (*wait_for_interrupt)(void);
};

in a header file, and then have the AT91RM9200, etc code providing
a set of functions and operation structure to be registered with the
core code.

That reduces this pm.h file right down to just this structure
definition.

However, looking at pm.c though, is any of this really necessary?

static int at91_pm_enter(suspend_state_t state)
{
        u32 saved_lpr;

        at91_gpio_suspend();
        at91_irq_suspend();

Argh, why are these specific suspend calls here - why aren't these
implemented using the syscore_ops stuff?  (Treat that as a separate
complaint.)

        switch (state) {
                case PM_SUSPEND_MEM:

Argh, why the extra indent (it's something which CodingStyle recommends
against.)

			...
                case PM_SUSPEND_STANDBY:
                        /*
                         * NOTE: the Wait-for-Interrupt instruction needs to be
                         * in icache so no SDRAM accesses are needed until the
                         * wakeup IRQ occurs and self-refresh is terminated.
                         * For ARM 926 based chips, this requirement is weaker
                         * as at91sam9 can access a RAM in self-refresh mode.
                         */
                        asm volatile (  "mov r0, #0\n\t"
                                        "b 1f\n\t"
                                        ".align 5\n\t"
                                        "1: mcr p15, 0, r0, c7, c10, 4\n\t"
                                        : /* no output */
                                        : /* no input */
                                        : "r0");
                        saved_lpr = sdram_selfrefresh_enable();
                        wait_for_interrupt_enable();
                        sdram_selfrefresh_disable(saved_lpr);
                        break;

This code has no guarantees what so ever that the compiler won't break
it - and doing my suggestion above will break it.  Your
wait_for_interrupt_enable() even calls out to other code in some cases.

So, what I suggest instead is to have the 'standby' state call a SoC
specific function, where you can have much better control over the
code generation:

void (*at91_standby)(void);
...

static int at91_pm_enter(suspend_state_t state)
{
        switch (state) {
...
	case PM_SUSPEND_STANDBY:
		if (at91_standby)
			at91_standby();
		break;

Then, have the SoC specific code implement a function in each SoC
specific file:

static void at91rm9200_standby(void)
{
	u32 lpr = at91_sys_read(AT91_SDRAMC_LPR);

	asm volatile(
		"b	1f\n\t"
	"	.align	5\n\t"
	"1:	mcr	p15, 0, %0, c7, c10, 4\n\t"
	"	str	%1, [%2]\n\t"
	"	str	%3, [%4]\n\t"
	"	mcr	p15, 0, %0, c7, c0, 4\n\t"
	"	str	%5, [%2]"
		:
		: "r" (0), "r" (0), "r" (virt-addr-of-LPR),
		  "r" (1), "r" (virt-addr-of-SRR),
		  "r" (lpr));
}

...

void at91rm9200_init_early(void)
{
	at91_standby = at91rm9200_standby;
}

This makes sure that the code is aligned, and you know how those register
writes are going to be done - and you know that they're going to be kept
as one chunk of assembly.  This can also replace the buggy code found in
cpuidle.c:

                asm("b 1f; .align 5; 1:");
                asm("mcr p15, 0, r0, c7, c10, 4");      /* drain write buffer */                saved_lpr = sdram_selfrefresh_enable();
                cpu_do_idle();
                sdram_selfrefresh_disable(saved_lpr);

with a call to at91_standby().

I think this has to be done _first_ before there's any thought about
moving cpuidle out of arch/arm/mach-at91.
