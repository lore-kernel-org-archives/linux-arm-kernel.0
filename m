From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Mar 2012 20:05:30 +0530
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <1331649534.1727.27.camel@vkoul-udesk3>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <1331128466.24656.421.camel@vkoul-udesk3>
 <20120312161143.GA10830@n2100.arm.linux.org.uk>
 <1331569438.1727.3.camel@vkoul-udesk3>
 <1331628036.1727.22.camel@vkoul-udesk3>
 <20120313123121.GA20133@n2100.arm.linux.org.uk>
 <1331649534.1727.27.camel@vkoul-udesk3>
Message-ID: <1332167730.7180.53.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-03-13 at 20:08 +0530, Vinod Koul wrote:
> On Tue, 2012-03-13 at 12:31 +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 13, 2012 at 02:10:36PM +0530, Vinod Koul wrote:
> > > Please see if the below patch is the right fix for build failures in
> > > addition to one suggested by Jassi.
> > 
> > I'm not sure that Jassi's solution is correct - and I'm wondering whether
> > any of the DMA engine drivers do the right thing when transfers are
> > terminated.  Is it right for the DMA status function to return IN_PROGRESS
> > for a previously submitted cookie which has been terminated?
> > 
> > I can see two answers to that, both equally valid:
> > 
> > 1. It allows you to find out exactly where the DMA engine got to before
> >    the transfer was terminated, and therefore recover from the termination
> >    if you wish to.
> > 
> > 2. Returning in-progress when a cookie will never be completed is
> >    misleading, and could be misinterpreted by users of the tx_status
> >    function, especially if they are waiting for a particular transaction
> >    to complete.
> > 
> > Maybe we need to introduce a DMA_TERMINATED status?
> I would agree with you that DMA_TERMINATED seems to be correct option.
> IN_PROGRESS would certainly confuse... 
> I will drop Jassi's fix from this branch. Care to send the patch? 

Even after adding such a state in dmaengine for DMA_TERMINATED, it
doesn't make much sense. In TERMINATE_ALL we do not update the
chan->complete value. So after client has terminated the channel it can
easily test to see if cookie is completed (before terminate will return
SUCCESS) or aborted (will return DMA_IN_PROGRESS)
So at present I am leaning on 1 :)

If I don't hear any opposition I will merge this (with Jassi's fix) and
then send pull to Linus

-- 
~Vinod
