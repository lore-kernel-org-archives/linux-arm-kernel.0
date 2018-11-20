From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 20 Nov 2018 17:39:10 +0530
Subject: [PATCH 12/16] clocksource: Add clock driver for RDA8810PL SoC
In-Reply-To: <e732ad15-b778-1c84-ad47-5770ee66688b@arm.com>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
 <20181119170939.19153-13-manivannan.sadhasivam@linaro.org>
 <e9b208ff-327e-860a-6ef0-15bf797dc6b2@arm.com>
 <20181120050650.GC5885@Mani-XPS-13-9360>
 <86pnv0rwna.wl-marc.zyngier@arm.com>
 <CACRpkdan96Vj58s=g9jiAoyLBpZqPCKcjqD82mgDj5WqRP7vDQ@mail.gmail.com>
 <e732ad15-b778-1c84-ad47-5770ee66688b@arm.com>
Message-ID: <20181120120910.GA13485@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 11:05:41AM +0000, Marc Zyngier wrote:
> On 20/11/2018 08:56, Linus Walleij wrote:
> > On Tue, Nov 20, 2018 at 9:17 AM Marc Zyngier <marc.zyngier@arm.com> wrote:
> > 
> >> How does this change anything with the fact that the above code is
> >> broken? 56 or 64 bit, you cannot read this counter with a single
> >> access, or two. The canonical way of reading such a counter is
> >> something like this:
> >>
> >>         do {
> >>                 lo = readl_relaxed(LO);
> >>                 hi = readl_relaxed(HI);
> >>         } while (hi != read_relaxed(HI));
> > 
> > To be fair, I have seen hardware that employ a logic latch
> > such that when a read access is done to the LO register,
> > the value of the whole counter is latched, also for the HI
> > register, so when you read the HI register in the second
> > step, it is never subject to wrapping. (Conversely reading
> > the HI before the LO will always give you insane values
> > :D)
> 
> I've seen such HW indeed, and I've also seen it being broken... ;-)
> 
> It this timer is built around such a (non-broken) logic, I'd really like
> to see it spelled out. It will otherwise be a real pain to debug...
>

There is no information about HW latch in datasheet and vendor code. But the
vendor driver doesn't use any logic to prevent wrapping. However, this doesn't
mean that we can assume that the hardware is capable of preventing overrun.
So I guess it is best to go with Marc's suggestion here.

Thanks,
Mani

> > However the above code should be fine unless you know
> > for sure the hardware was constructed with a clever latch.
> 
> Let's find out!
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
