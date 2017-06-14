From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jun 2017 12:06:03 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170614104806.GF4902@n2100.armlinux.org.uk>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609143050.GM13955@arm.com>
 <0fbf57f0-9ff7-4fd4-07c7-c5e86028a7d2@huawei.com>
 <20170614100658.GE16190@arm.com>
 <20170614104806.GF4902@n2100.armlinux.org.uk>
Message-ID: <20170614110603.GM16190@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 11:48:07AM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 14, 2017 at 11:06:58AM +0100, Will Deacon wrote:
> > Apologies, I misunderstood your algorithm (I thought step (a) was on one CPU
> > and step (b) was on another). Still, I don't understand the need for the
> > timeout. If you instead read back the flag immediately, wouldn't it still
> > work? e.g.
> > 
> > 
> > lock:
> >   Readl_relaxed flag
> >   if (locked)
> >     goto lock;
> > 
> >   Writel_relaxed unique ID to flag
> >   Readl flag
> >   if (locked by somebody else)
> >     goto lock;
> > 
> > <critical section>
> > 
> > unlock:
> >   Writel unlocked value to flag
> 
> I think the delay is to counter this:
> 
> 	Agent 1			Agent 2
> 	read flag
> 	not locked
> 				read flag
> 				not locked
> 	write unique ID
> 	read back
> 	not locked by someone else
> 				write unique ID
> 				read back
> 				not locked by someone else
> 
> With the delay present, this becomes:
> 
> 	Agent 1			Agent 2
> 	read flag
> 	not locked
> 				read flag
> 				not locked
> 	write unique ID
> 	delay
> 				write unique ID
> 				delay
> 	read back
> 	locked by agent 2
> 				read back
> 				not locked by someone else
> 
> For this to work, the delay has to be guaranteed to be greater than
> the maximum duration that any agent takes between the initial read
> and the write of its unique ID.  The delay doesn't even have to be
> identical between each agent, it just has to satisfy that condition.

I think that it also needs to account for write propagation delays.

> The key thing though is that the reads and writes must happen when
> the program intends them to, so I don't think the _relaxed variants
> should be used here.  If they're buffered, then the delay doesn't
> have the desired effect.

If buffering is a concern, then I think the non-relaxed write has the
barrier on the wrong side, so relaxed + mb() would be better.

Will
