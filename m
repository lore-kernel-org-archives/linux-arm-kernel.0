From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jun 2014 15:34:15 +0100
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617130333.GE8860@dragon>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617101606.GE23430@n2100.arm.linux.org.uk>
 <20140617102123.GA13808@arm.com>
 <20140617102344.GG23430@n2100.arm.linux.org.uk>
 <20140617102519.GC13808@arm.com> <20140617130333.GE8860@dragon>
Message-ID: <20140617143415.GH13808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 02:03:35PM +0100, Shawn Guo wrote:
> On Tue, Jun 17, 2014 at 11:25:20AM +0100, Will Deacon wrote:
> > On Tue, Jun 17, 2014 at 11:23:44AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Jun 17, 2014 at 11:21:23AM +0100, Will Deacon wrote:
> > > > I think that actually works ok, because writing zeroes doesn't actually
> > > > do anything as far as I understand. The problem with suspend/resume is
> > > > that the suspend/resume cycle could well clear the internal state and
> > > > writing zeroes won't re-enable the workaround bits.
> > > > 
> > > > I'll double-check this with the hardware guys, since this register really
> > > > is undocumented.
> > > 
> > > Are you saying that it is write one to set, and writing zero is ignored?
> > > If that's true, we should simplify the work-around code to get rid of the
> > > read-modify-write.
> > 
> > That's my understanding for the diagnostic register, but I've asked for
> > clarification internally.
> 
> Hmm, I'm not sure that's the case.  On imx6q, I can read out diagnostic
> register as 0x00200850 which matches the errata we enable.

The hardware guys got back to me, and I was mistaken (in fact, confused by
another register). So the diagnostic register on A9 *does* read back with
the value written to it. You still need to save/restore it across suspend,
but read-modify-write is the right thing to do everywhere else.

Will
