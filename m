From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 05 Sep 2016 20:50:53 +0200
Subject: [PATCH 2/3] ARM: pxa: lubbock: add pcmcia clock
In-Reply-To: <20160905160420.GQ1041@n2100.armlinux.org.uk> (Russell King's
 message of "Mon, 5 Sep 2016 17:04:20 +0100")
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 <1473015587-15589-2-git-send-email-robert.jarzmik@free.fr>
 <20160904200827.GL1041@n2100.armlinux.org.uk>
 <877faqjtuk.fsf@belgarion.home>
 <20160905160420.GQ1041@n2100.armlinux.org.uk>
Message-ID: <87zinmi3jm.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Mon, Sep 05, 2016 at 04:37:23PM +0200, Robert Jarzmik wrote:
> From what I remember, the SA1111 takes the 3.6864MHz clock input as an
> input to its own PLL to generate the clocks it needs internally.  All
> the PCMCIA timing is handled by the SA1110 or PXA.
>
> The reason that we need to tell the SA1111 PCMCIA device about the PXA
> clock is not because the SA1111 uses it, but because the driver needs it
> to work out the correct timing information to program the SA1110 or PXA
> access times.

I've been pondering that last sentence for a bit and what appeared to me is that
between the PXA and the SA1111, as there is no clock from one to the other,
ie. that the SA1111 clock for PCMCIA signals is independent from any PXA clock
(well, excepting it's a PLL from a 3.6864MHz, but let's forget that), the
contract binding the PXA and the SA1111 is a _timings_ one rather that a clock
one.

Or said differently, the 2 IPs must agree on timing values in order to
inter-operate, and so should the device drivers. Their internal clock frequencies
are marginal, as on an asynchronous interface, what is important is that PXA
accepts nPIOR within [a .. b] and SA1111 accepts nPIOR within [c .. d], and the
intersection is used to setup them both.

I have not really looked into the PCMCIA structure, but I suppose it's clock
based today.

> This means that the current driver structure does _not_ fit the DT model
> at all - I hope that no one has plans to construct a DT model based on
> the current code structure, because that would be totally wrong.
Oh there are not that many candidates these days for PCMCIA nor PXA. I don't see
any other volunteer than me on the PXA front, and even if I find the time in 1
year or 2, I will remember this conversation and will discuss thoroughly before
trying to code.

> Thanks, the commit message is mostly fine, I think it ought to also
> point out that it's used by the driver to derive the timing information,
> and doesn't physically exist to the SA1111.

Something like ?
"The added clock doesn't actually exist, ie. there is no physical clock line
from the PXA to the SA1111 on lubbock used by the PCMCIA block on the
SA1111. The clocking information is only used to setup the memory bus timings."

Cheers.

-- 
Robert
