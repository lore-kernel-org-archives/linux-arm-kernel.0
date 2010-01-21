From: jpihet@mvista.com (Jean Pihet)
Date: Thu, 21 Jan 2010 13:32:58 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20100121122743.GH4908@wear.picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001211321.44682.jpihet@mvista.com>
	<20100121122743.GH4908@wear.picochip.com>
Message-ID: <201001211332.58549.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2010 13:27:43 Jamie Iles wrote:
> On Thu, Jan 21, 2010 at 01:21:44PM +0100, Jean Pihet wrote:
> > On Thursday 21 January 2010 11:38:03 Russell King - ARM Linux wrote:
> > > On Thu, Jan 21, 2010 at 10:28:26AM -0000, Will Deacon wrote:
> > > > Hi Jamie,
> > > >
> > > > * Jamie Iles wrote:
> > > > > Given the difficulty in determining the CPU type 100%, this should
> > > > > be changed to:
> > > > >
> > > > > 	unsigned long cpuid = read_cpuid_id();
> > > > > 	unsigned long implementor = (cpuid & 0xFF000000) >> 24;
> > > > > 	unsigned long part_number = (cpuid & 0xFFF0);
> > > > >
> > > > > 	/* We only support ARM CPUs implemented by ARM at the moment. */
> > > > > 	if (implementor == 0x41) {
> > > > > 		switch (part_number) {
> > > > > 		case 0xB360:
> > > > > 		case 0xB560:
> > > > > 			etc
> > > >
> > > > Whilst I understand that the whole cpuid thing is a complete mess [I
> > > > saw the lkml posts yesterday], I'm not sure this is necessary for v7
> > > > cores. For v7, the PMU is part of the architecture and so *must* be
> > > > implemented in the way described in the ARM ARM [Chapter 9],
> > > > regardless of the implementer.
> > >
> > > This function is called whenever the PMU support is built in - and
> > > this is the first place a decision is made about how to handle stuff.
> > >
> > > Merely checking the part number without checking the implementer is
> > > nonsense - the part number is defined by the implmenter, not ARM, so
> > > the part number can only be interpreted with knowledge of the
> > > implementer.
> > >
> > > So, when v7 gets added, checking the main ID register is the wrong
> > > thing to do.
> > >
> > > Given that cpu_architecture() appears to have been redefined to return
> > > the MMU architecture, we have no real way to properly determine if we
> > > have a v7 PMU present - in fact, the whole "are we v6 or v7 or
> > > something later" question seems to be extremely muddy and
> > > indeterminant.
> > >
> > > So I don't think even checking cpu_architecture() == CPU_ARCH_ARMv7
> > > is the right thing either.
> >
> > Agree. Here is the latest version of the detection code, after merging
> > Jamie's latest version:
> >
> >         unsigned long cpuid = read_cpuid_id() & CPUID_MASK;
> >
> >         switch (cpuid) {
> >         case 0xB360:    /* ARM1136 */
> >         case 0xB560:    /* ARM1156 */
> >         case 0xB760:    /* ARM1176 */
> > 	    ...
> >                 break;
> >         case 0xB020:    /* ARM11mpcore */
> > 	    ...
> >                 break;
> >         case 0xC080:    /* Cortex-A8 */
> > 	    ...
> >                 break;
> >         case 0xC090:    /* Cortex-A9 */
> > 	    ...
> >                 break;
> >         default:
> >                 pr_info("no hardware support available\n");
> >                 perf_max_events = -1;
> >        }
> >        ...
> >
> > Is that OK if we just add 'if (implementor == 0x41) {' before the switch
> > statement, as proposed above?
>
> That sounds good to me. Are these patches ready for merging?
Yes the code is ready, testing it right now. I will rebase it on your latest 
version as soon as they are available.

Are you ok to post the patches to the ML and tp patchwork?

> Jamie
Jean
