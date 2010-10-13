From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 13 Oct 2010 18:51:52 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1287002975.28336.44.camel@c-dwalke-linux.qualcomm.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010132145.30550.arnd@arndb.de>
	<1286999522.28336.15.camel@c-dwalke-linux.qualcomm.com>
	<201010132210.17061.arnd@arndb.de>
	<1287001466.28336.31.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131638360.2764@xanadu.home>
	<1287002975.28336.44.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1010131831470.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Oct 2010, Daniel Walker wrote:

> On Wed, 2010-10-13 at 16:44 -0400, Nicolas Pitre wrote:
> > On Wed, 13 Oct 2010, Daniel Walker wrote:
> > 
> > > On Wed, 2010-10-13 at 22:10 +0200, Arnd Bergmann wrote:
> > > > On Wednesday 13 October 2010 21:52:02 Daniel Walker wrote:
> > > > > > Seriously, I don't think you need it, but if you really do, we can probably
> > > > > > find a way to work around this by changing the base hvc driver.
> > > > > 
> > > > > I think we would have to add something that allows different major/minor
> > > > > numbers, because something that includes the name "Hypervisor" shouldn't
> > > > > be used for something general.. /dev/hvcX is also registered for "IBM
> > > > > iSeries/pSeries virtual console" (according to www.lanana.org) which is
> > > > > confusing ..
> > > > 
> > > > That only means we need to update the lanana entry now that the hvc driver
> > > > is used on nine different platforms (not including yours) instead of ust
> > > > pSeries. Feel free to come up with a backronym for HVC if you're
> > > > uncomfortable with the old "hypervisor console" name.
> > > 
> > > If you read back in this thread you'll see how there was a discussion
> > > already on how you shouldn't re-use major/minor numbers for other
> > > purposes .. It looks like "hvc" was essentially overridden , which now
> > > seems like a no-no given that discussion.. This appears to be a
> > > sensitive topic.
> > 
> > And I violently disagree with this interpretation.
> > 
> > The tty layer was probably the first subsystem to have been implemented 
> > in Linux.  There are a big deal of legacy with its device naming.  When 
> > adding new subsystems we don't need to perpetuate this. Maybe that made 
> > sense 20 years ago, but let's leave ttyS0 alone and use good sense for 
> > new stuff.
> 
> Your still confusing me here Nico .. It seems like your suggesting
> adding new overrides is not OK , yet your also saying it is ok ?

What I'm saying is:

1) The hvc layer is there so it is best if the DCC support uses it.
   Until today I didn't know it existed either, but it offers a higher 
   level of abstraction that the DCC support can use.

2) That level of abstraction already has its device namespace and it
   is perfectly fine to reuse it across different low-level drivers,
   just like SCSI and ATA/SATA disk drives are sharing the same 
   namespace these days.  There used to be a separate namespace for ATA 
   drives but this is now history.

3) All serial drivers could have migrated to a uniform device node 
   namespace when RMK revamped support for serial devices, with dynamic 
   allocation just like everything else.  Unlike for IDE disks, this 
   didn't happen unfortunately because some people couldn't get over a 
   possible device name change (I wonder how they survived the 
   transition to libata).

So if the hvc code has now turned into an abstraction layer that 
supports multiple different devices while still sharing the same device 
namespace I think this is perfect.

So I'm suggesting that the DCC driver be moved to the hvc subsystem.  
And I don't mind if the hvc is reusing the same namespace for different 
devices.  That is what should have happened on a larger scale for all 
serial devices long ago.

If you _insist_ on having a different device name for the DCC port then 
it's probably saner to add that ability to the hvc code than keeping a 
separate serial driver.  But I personally really don't care at that 
point.


Nicolas
