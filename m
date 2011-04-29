From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 Apr 2011 06:09:40 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <BANLkTi=jcb8Piki6RrijGOQG=wJ=ULv5Gw@mail.gmail.com>
References: <20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
	<BANLkTi=jcb8Piki6RrijGOQG=wJ=ULv5Gw@mail.gmail.com>
Message-ID: <20110429130939.GB3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [110429 05:59]:
> On Fri, Apr 29, 2011 at 4:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [110427 07:41]:
> >
> > If the compressed image is smaller than BSS, then we end up
> > having DT data in the BSS area. In this case the compressed
> > image is about 2.3 MB for LZMA.
> >
> > The uncompress code does not know about the kernel BSS,
> > and does not necessarily relocate anything depending on the
> > compressed image load address.
> >
> > So in which code do we want to relocate the DT data?
> >
> > We could do it based on estimated BSS size in uncompress code,
> > or based on the real BSS size in __mmap_switched before BSS
> > gets reset.
> 
> How about telling the wrapper what the final size will be by scraping
> the __bss_end value out of System.map?

That sounds doable to me. It should probably be done in the uncompress
code so the kernel code can stay generic for the DT data handling.

BTW, with the relocation of DT data we may end up overwriting
an initrd, but I guess bootloaders typically place the initrd to
the end of the memory.

Regards,

Tony
