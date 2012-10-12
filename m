From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 13:24:02 +0100
Subject: alignment faults in 3.6
In-Reply-To: <1350036263.21172.11438.camel@edumazet-glaptop>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com> <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <1350036263.21172.11438.camel@edumazet-glaptop>
Message-ID: <20121012122402.GI21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 12:04:23PM +0200, Eric Dumazet wrote:
> On Fri, 2012-10-12 at 10:03 +0100, Russell King - ARM Linux wrote:
> 
> > No.  It is my understanding that various IP option processing can also
> > cause the alignment fault handler to be invoked, even when the packet is
> > properly aligned, and then there's jffs2/mtd which also relies upon
> > alignment faults being fixed up.
> 
> Oh well.
> 
> We normally make sure we dont have alignment faults on arches that dont
> have CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS (or a non null NET_IP_ALIGN)
> 
> So if you find an offender, please report a bug, because I can guarantee
> you we will _fix_ it.

I think one change I will make to the ARM alignment fixup is to get it
to record the last PC where a misaligned kernel fault occurred, and
report it via our statistics procfs file.  That should allow us to
track down where some of these occur.

They aren't anywhere near regular though - looking at the statistics, my
firewall seems to do an average of around 2-3 a day, and a web server
around 7-8 a day.
