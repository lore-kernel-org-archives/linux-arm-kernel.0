From: holt@sgi.com (Robin Holt)
Date: Thu, 9 May 2013 06:20:48 -0500
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <518A9A83.5010306@zytor.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
 <20130508103956.GA7677@gmail.com>
 <20130508182007.GO18614@n2100.arm.linux.org.uk>
 <518A9A83.5010306@zytor.com>
Message-ID: <20130509112048.GT3672@sgi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 11:33:39AM -0700, H. Peter Anvin wrote:
> On 05/08/2013 11:20 AM, Russell King - ARM Linux wrote:
> > 
> > Let's try to get the meaning back.  On ARM, these are taken from the first
> > letter of the 'reboot=' command line argument, which was initially either
> > "hard" or "soft".  This refers to whether we hit some bit of hardware
> > which physically asserts some reset line in the system, or merely vector
> > the CPU via the reset vector (for some systems, this is the only
> > possibility.)
> > 
> > Then PXA happened, and there was a need for some platforms there to do
> > a hardware restart via toggling a GPIO output, which would then ultimately
> > assert the system reset line.  So we then added the "gpio" mode as well.
> > reboot via toggling a GPIO output.  So we then ended up with "gpio" as
> > well.
> > 
> > So, on ARM, the modes are: hard, soft, gpio, which get translated to a
> > single letter by the simple parsing code:
> > 
> > static char reboot_mode = 'h';
> > 
> > int __init reboot_setup(char *str)
> > {
> >         reboot_mode = str[0];
> >         return 1;
> > }
> > 
> > __setup("reboot=", reboot_setup);
> > 
> > Now, arguably, "hard" and "soft" have an entirely different meaning to
> > "warm" and "cold" in the normal parlence.  A "warm" reboot involves the
> > system doing less tasks at restart than a "cold" reboot.  This is not
> > necessarily the case between 'hard' and 'soft'.
> > 
> > So, while I don't entirely agree with mapping "hard" to "cold" and
> > "soft" to "warm", I guess for the sake of generalisation it's okay.
> > However, thinking about the future, if ARM becomes more server-like,
> > we might also want "cold" and "warm" reboot identifiers too.
> > 
> > I think the solution to this would be to have the new generic code
> > parse the entire argument, not just the first letter - certainly for
> > the 's' case.  If it's the x86 version, it'll be "s<number>".  If
> > it's the ARM version, it should be "soft".
> > 
> 
> The s<number> thing is pretty awful, admittedly (it was supposed to be
> smp<number>, but the parser, rather than *allowing* only the first
> letter, seems to *require* that it is only the first letter.)
> 
> The problem I see is that we don't know what we'll break if we change
> it, but Ingo seems to think it doesn't matter so much.
> 
> For the boolean letter argument, we could simply have the parser set a
> bitmask of the letters seen; the x86 "s" argument is clearly an outlier.
> 
> We could handle it in a generic exception by looking for s<digit> or
> smp<digit>, which will not match ARM's "soft" argument.  I suspect we
> can worry about other argument-carrying options in a generic fashion
> when the need arises; I would personally prefer the "subtag:argument"
> format used by libata &c for that, and the presence of a ':' would be
> indicative.

Is there really a reason for having this conglomeration of disparate
options all merged together?  Why can't we go with having a separate
param(reboot_cpu, int, 0644); so it can be controlled via sysfs as
well?  If we are breaking the reboot=s## syntax, why not become a
little more standardized with the reboot_cpu?

Robin
