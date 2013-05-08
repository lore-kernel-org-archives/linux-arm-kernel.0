From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 May 2013 19:20:07 +0100
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <20130508103956.GA7677@gmail.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
 <20130508103956.GA7677@gmail.com>
Message-ID: <20130508182007.GO18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 12:39:56PM +0200, Ingo Molnar wrote:
> To generalize it, firstly here's a summary of the existing reboot option 
> mappings:
> 
>  x86-only:  w, c, s
>  non-x86:         s, h, g
>  generic:                  b, a, k, t, e, p, f
> 
> 
> it appears that 'w', 'c', 'h', and 'g' could be made generic straight 
> away.
> 
> Which leaves 's' as the only truly problematic option:
> 
>  - it means REBOOT_WARM on some non-x86 platform(s?)
>  - while it means the SMP-cpu on x86.
> 
> Stupid question: which non-x86 platform(s) use 's'?

Let's try to get the meaning back.  On ARM, these are taken from the first
letter of the 'reboot=' command line argument, which was initially either
"hard" or "soft".  This refers to whether we hit some bit of hardware
which physically asserts some reset line in the system, or merely vector
the CPU via the reset vector (for some systems, this is the only
possibility.)

Then PXA happened, and there was a need for some platforms there to do
a hardware restart via toggling a GPIO output, which would then ultimately
assert the system reset line.  So we then added the "gpio" mode as well.
reboot via toggling a GPIO output.  So we then ended up with "gpio" as
well.

So, on ARM, the modes are: hard, soft, gpio, which get translated to a
single letter by the simple parsing code:

static char reboot_mode = 'h';

int __init reboot_setup(char *str)
{
        reboot_mode = str[0];
        return 1;
}

__setup("reboot=", reboot_setup);

Now, arguably, "hard" and "soft" have an entirely different meaning to
"warm" and "cold" in the normal parlence.  A "warm" reboot involves the
system doing less tasks at restart than a "cold" reboot.  This is not
necessarily the case between 'hard' and 'soft'.

So, while I don't entirely agree with mapping "hard" to "cold" and
"soft" to "warm", I guess for the sake of generalisation it's okay.
However, thinking about the future, if ARM becomes more server-like,
we might also want "cold" and "warm" reboot identifiers too.

I think the solution to this would be to have the new generic code
parse the entire argument, not just the first letter - certainly for
the 's' case.  If it's the x86 version, it'll be "s<number>".  If
it's the ARM version, it should be "soft".
