From: jpihet@mvista.com (Jean Pihet)
Date: Thu, 21 Jan 2010 13:42:48 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <001a01ca9a96$0f7024a0$2e506de0$@deacon@arm.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<201001211321.44682.jpihet@mvista.com>
	<001a01ca9a96$0f7024a0$2e506de0$@deacon@arm.com>
Message-ID: <201001211342.48751.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thursday 21 January 2010 13:34:22 Will Deacon wrote:
> Hi Jean,
>
> * Jean Pihet wrote:
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
> For the v7 PMU, we can do a bit better than that because the PMU
> is defined by the architecture. If you read the DIDR[19:16] and it
> returns either 3 or 4, you have a v7 PMU present so you can make use of
> the architecturally defined events regardless of the implementer.
>
> So, in response to your question, I reckon you should wrap the switch
> statement with the implementer check, but add a DIDR check in the else
> block so that cores with a v7 PMU will at least get support for the
> standard events.
That makes sense. Are such chipsets already out or planned in the near future?
I propose to have the current code working and merged in before supporting the 
generic v7 cores. Doing so requires to add new set of events mappings.

What do you think?
>
> Cheers,
>
> Will

Cheers,
Jean
