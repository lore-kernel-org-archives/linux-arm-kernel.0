From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jun 2017 12:01:41 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170614104230.GC6085@leverpostej>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
 <20170608163519.GA19643@leverpostej>
 <8666a0fa-126d-e4a3-ac4b-7962f5d79942@huawei.com>
 <20170609143050.GM13955@arm.com>
 <0fbf57f0-9ff7-4fd4-07c7-c5e86028a7d2@huawei.com>
 <20170614100658.GE16190@arm.com>
 <20170614104230.GC6085@leverpostej>
Message-ID: <20170614110141.GL16190@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 11:42:30AM +0100, Mark Rutland wrote:
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
> > 
> > 
> > Given that we're dealing with iomem, I think it will work, but I could be
> > missing something obvious.
> 
> Don't we have the race below where both threads can enter the critical
> section?
> 
> 	// flag f initial zero (unlocked)
> 
> 	// t1, flag 1			// t2, flag 2
> 	readl(f); // reads 0		l = readl(f); // reads 0
> 
> 	<thinks lock is free>		<thinks lock is free>
> 
> 	writel(1, f);
> 	readl(f); // reads 1
> 	<thinks lock owned>
> 					writel(2, f);
> 					readl(f) // reads 2
> 					<thinks lock owned>
> 
> 	<crticial section>		<critical section>

Urgh, yeah, of course and *that's* what the udelay is trying to avoid,
by "ensuring" that the <thinks lock is free> time and subsequent write
propagation is all over before we re-read the flag.

John -- how much space do you have on this device? Do you have, e.g. a byte
for each CPU?

Will
