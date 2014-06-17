From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jun 2014 11:21:23 +0100
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617101606.GE23430@n2100.arm.linux.org.uk>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617101606.GE23430@n2100.arm.linux.org.uk>
Message-ID: <20140617102123.GA13808@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 11:16:06AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 17, 2014 at 10:57:29AM +0100, Will Deacon wrote:
> > On Tue, Jun 17, 2014 at 09:31:18AM +0100, Shawn Guo wrote:
> > > Hi Will, Catalin,
> > > 
> > > The CP15 diagnostic register holds some bits for ARM errata workaround.
> > > Since core gets power gated across suspend/resume cycle, these bits will
> > > get lost along the way.  Is it okay for errata workaround to continue
> > > working after suspend, or do we have to save/restore diagnostic register
> > > to keep workaround effective?
> > 
> > I'm not sure that saving/restoring the diagnostic register on A9 actually
> > works at all (I seem to remember some bits always read as zero?).
> 
> If that's true, then we have a problem.  We always read-modify-write
> this register when enabling work-arounds.  If it always reads as
> zero, then enabling a subsequent work-around will disable the
> previous work-around.

I think that actually works ok, because writing zeroes doesn't actually
do anything as far as I understand. The problem with suspend/resume is
that the suspend/resume cycle could well clear the internal state and
writing zeroes won't re-enable the workaround bits.

I'll double-check this with the hardware guys, since this register really
is undocumented.

Will
