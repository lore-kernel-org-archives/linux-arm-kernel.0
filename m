From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Mar 2014 13:44:30 +0000
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <CANBf9ePuqFXXy+tsHdeuogPuVgN1OD2jswhvZ1qJYHC=Lu+N-g@mail.gmail.com>
References: <201403200501.16881.marex@denx.de>
 <CAOMZO5Bx60C8VhZ-6LqsLxx29cuxRkAc6XPozZv9X+grKLJy6w@mail.gmail.com>
 <20140320230559.GF7528@n2100.arm.linux.org.uk>
 <532B86A7.5010200@boundarydevices.com>
 <20140321011843.GG7528@n2100.arm.linux.org.uk>
 <CAOMZO5A+e+mHw1EG9t983ZG_KVL_O1r5UVwUU3JBsU5yPxOBsA@mail.gmail.com>
 <CAOMZO5CxjCHLrY0KTe4j=NiSU3CQVNZWhEAs33Le8ji3NAFETQ@mail.gmail.com>
 <CANBf9eNZB+BVBDkgWNxxGs-ndQ-mYCc6+bfVdS-8T-QLpSZ3GA@mail.gmail.com>
 <20140321173252.GL7528@n2100.arm.linux.org.uk>
 <CANBf9ePuqFXXy+tsHdeuogPuVgN1OD2jswhvZ1qJYHC=Lu+N-g@mail.gmail.com>
Message-ID: <20140323134429.GO7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 23, 2014 at 12:38:31PM +0100, Bernd Faust wrote:
> On 21 March 2014 18:32, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Fri, Mar 21, 2014 at 05:33:02PM +0100, Bernd Faust wrote:
> >> I also tried the patch, but unfortunately it doesn't work for me either.
> >> I get the same error as Robert Daniels. My target is a i.MX6 (Cortex A9,
> >> single core) running Linux Kernel version 3.10.9-rt5+
> >
> > Hmm, rt kernels.  Does this happen without the rt patches applied?
> >
> 
> On a kernel without RT patches the problem does not occur, so in my
> case the problem seems to be introduced/triggered by the RT patches.

Yes, this suggests it's some kind of race introduced by the RT patches.
I've never looked at the RT patches, so I can't help there.

What I can say is that there are a number of other problems with this
driver which are all races of one form or another, but they should not
affect normal operation.

For example:
- the FEC_QUIRK_ERR006358 workaround (for iMX6 only) can read the previous
  descriptor before the write to new descriptor's TX status bit has become
  visible to the hardware.
- FEC_QUIRK_ERR006358 workaround not quite having the desired effect
  (a scheduled delayed work can't be re-scheduled until after it has
  already fired.)
- the number of places that call fec_stop() without first stopping the
  transmit queue or dealing with the above work-around before
  reconfiguring the hardware and re-initialising the rings.
- the rx path having a similar problem to the above (writing descriptor
  entries after the descriptor has been handed over to uDMA.)

I haven't addressed any of these yet, but they're on my list.  I'm pretty
sure there's other problems in there too...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
