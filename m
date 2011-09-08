From: msalter@redhat.com (Mark Salter)
Date: Thu, 08 Sep 2011 18:41:14 -0400
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <20110831193525.GA27476@e102144-lin.cambridge.arm.com>
References: <20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
	<1314798215.2344.76.camel@deneb.redhat.com>
	<20110831152137.GG8777@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108311332410.20358@xanadu.home>
	<20110831175147.GI8777@e102144-lin.cambridge.arm.com>
	<4E5E7B35.9080008@gmail.com>
	<20110831193525.GA27476@e102144-lin.cambridge.arm.com>
Message-ID: <1315521779.2313.29.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-31 at 20:35 +0100, Will Deacon wrote:
> On Wed, Aug 31, 2011 at 07:19:33PM +0100, Rob Herring wrote:
> > On 08/31/2011 12:51 PM, Will Deacon wrote:
> > > Another thing that Marc and I tried on OMAP4 was not bringing up the secondary
> > > CPU during boot (by commenting out most of smp_init). In this case, I/O
> > > performance was good until we tried to online the secondary CPU. The online
> > > failed but after that the I/O performance was certainly degraded.
> > > 
> > 
> > Was the SCU enabled at that point? One diff between nosmp boot and
> > offlining the 2nd core would be that the SCU remains enabled in the
> > latter case. I think the SCU does not get enabled for nosmp.
> 
> Our rudimentary test (printing out the SCU control register during boot)
> showed that it *was* enabled for nosmp. I think this is due to the secure
> world having to do that on OMAP so it's probably not true for other
> platforms.

I've done a little test and found that turning on the MMU of the second
core causes the problem to show up. I patched head.S so I stopped the
second core in an infinite loop just before turning on the MMU. The
system continues booting on core#0 and I see ~20MB/s with hdparm -t to
an attached usb disk. Same setup but with second core being stopped with
infinite loop just after MMU is enabled shows ~5MB/s. So whatever is
going wrong, its not because of anything the second core is doing beyond
turning on its MMU and doing an empty loop.

--Mark
