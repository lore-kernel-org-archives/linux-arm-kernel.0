From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 25 Aug 2016 19:10:00 +0100
Subject: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
In-Reply-To: <20160825171539.GA13571@zach-desktop>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade>
 <20160825171539.GA13571@zach-desktop>
Message-ID: <20160825180959.GA14705@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 12:15:44PM -0500, Zach Brown wrote:
> On Thu, Aug 25, 2016 at 11:56:55AM +0100, Mark Rutland wrote:
> > On Wed, Aug 24, 2016 at 06:23:03PM -0500, Zach Brown wrote:
> > > +- fake-cd: On Zynq Devices the SDHCI Controller will not work without the cd
> > > +  bit. When this option is set the driver will put the controller in test mode
> > > +  and fake the cd bit so it will function.
> > 
> > As Lars noted, the DT should describe the HW, and the policy of how to deal
> > with that should be left to the kernel. So from a DT perspective the above is
> > not correct.
> > 
> > If I understand the linked documentation, this is slightly different to typical
> > uses of broken-cd in that in the absence of a card detect signal the HW will
> > not be able to access the SD card at all, even if requested to. Is that correct?
> > 
> > If so, perhaps a better option is to have the combination of broken-cd and the
> > compatible string for this IP block imply that the test mode workaround is
> > required. Obviously that requires a fixup to the usual broken-cd binding to
> > remove the implication that polling alone must be used.
> > 
> > Thanks,
> > Mark.
> 
> In cases where the card is non-removable then polling doesn't make sense.

We have the non-removable property to describe that, so we can also look at that.

> So it doesn't make sense to tie the test mode workaround into the broken-cd
> property, even though I agree the nature of the defect fits under the notion
> of the CD being broken.

Maybe not solely on broken-cd, but I think that we dont necessarily need a new
DT property. As above, broken-cd, non-removable, and the compatible string may
together give the kernel enough information to choose the right thing to do.

Thanks,
Mark.
