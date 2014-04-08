From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 12:22:30 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408200140.5dcc2ad7@skate>
References: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408200140.5dcc2ad7@skate>
Message-ID: <20140408182230.GD32490@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 08:01:40PM +0200, Thomas Petazzoni wrote:

> > Well, you do, 0x900000 is not aligned. It converts to size=0b10001111,
> > which is undefined behavior for mbus. 
> 
> Ah correct. Though I'm still puzzled as to why the undefined behavior
> works for me, and not for Willy, who I believe has the same NIC as me.

If we knew the algorithm in the HW it would probably make sense :)

> > - When reading interpret undefined values in a conservative way,
> >   the value is assumed to be the lowest power of two. This avoids
> >   the debugfs output showing a value that looks 'correct'
> 
> But I am not sure with this one. Since now you're anyway rounding down
> sizes, how is it possible to get a non-power-of-two size in the
> registers?

I agree, it should not happen if everything is correct, but the
apparently correct debugfs output obscured the root cause of the
problem..

> I would probably prefer to have mvebu_devs_debug_show() do something
> like:
> 
>                 seq_printf(seq, "[%02d] %016llx - %016llx : %04x:%04x%s",
>                            win, (unsigned long long)wbase,
>                            (unsigned long long)(wbase + wsize), wtarget, wattr,
> 			   (!is_power_of_2(wsize)) ? " non-pow2 undefined behavior!" : "");

That sounds good
 
> > +	WARN_ON(!is_power_of_2(size));
> > +	size = rounddown_pow_of_two(size);
> 
> Maybe something like:
> 
> 	if (!is_power_of_2(size)) {
> 		WARN(true, "Invalid MBus window size: 0x%x, rounding down to 0x%x\n",
> 		     size, rounddown_pow_of_two(size));
> 		size = rounddown_pow_of_two(size);
> 	}
> 
> And while we're adding checks, why not also verify that the base
> address is a multiple of the window size? I think it's the other
> requirement.

Yes, agree, sounds good

> That being said, this warning doesn't really solve the problem that the
> PCI core may allocate BARs whose size cannot be represented through
> MBus windows :-)

Right, but Will pointed out it took 3 months to get to the root cause,
so it might save that time in future :)

I'll revise/resend the patch.

Jason
