From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 29 Apr 2011 07:02:35 -0600
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <20110429102623.GX3755@atomide.com>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
	<20110427144335.GK3755@atomide.com>
	<20110429102623.GX3755@atomide.com>
Message-ID: <BANLkTi=jcb8Piki6RrijGOQG=wJ=ULv5Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 4:26 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [110427 07:41]:
>> * Nicolas Pitre <nico@fluxnic.net> [110427 07:37]:
>> > On Wed, 27 Apr 2011, Tony Lindgren wrote:
>> > >
>> > > I guess the issue is that when setup_machine_fdt gets called we only
>> > > have minimal MMU mapping done.
>> >
>> > In head.S (the final kernel image one) there is a 1MB mapping
>> > established when r2 contains a valid ATAG/DTB pointer. ?See commit
>> > 4d901c42 (you even ACK'd it).
>>
>> Yeah thanks was just looking at that too :) Need to debug further..
>
> OK figured this one out. Looks like we have an issue where kernel BSS
> can easily overlap the appended DT data. Then kernel __mmap_switched
> will clear the BSS and DT data.
>
> This happens for example with omap2plus_defconfig where we have:
>
> $ stat -c "%s" arch/arm/boot/Image
> 6405100
>
> $ size kernel/built-in.o
> ? text ? ?data ? ? bss ? ? dec ? ? hex filename
> ?660576 ?110852 5475500 6246928 ?5f5210 kernel/built-in.o
>
> If the compressed image is smaller than BSS, then we end up
> having DT data in the BSS area. In this case the compressed
> image is about 2.3 MB for LZMA.
>
> The uncompress code does not know about the kernel BSS,
> and does not necessarily relocate anything depending on the
> compressed image load address.
>
> So in which code do we want to relocate the DT data?
>
> We could do it based on estimated BSS size in uncompress code,
> or based on the real BSS size in __mmap_switched before BSS
> gets reset.

How about telling the wrapper what the final size will be by scraping
the __bss_end value out of System.map?

g.
