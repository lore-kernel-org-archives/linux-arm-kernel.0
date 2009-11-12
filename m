From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Nov 2009 22:13:07 +0000
Subject: [PATCH] ARM: Prefix revision number in /proc/cpuinfo
In-Reply-To: <20091112220314.GS14091@buzzloop.caiaq.de>
References: <1258034287-4533-1-git-send-email-daniel@caiaq.de>
	<20091112215201.GA12308@n2100.arm.linux.org.uk>
	<20091112220314.GS14091@buzzloop.caiaq.de>
Message-ID: <20091112221307.GC12308@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 11:03:14PM +0100, Daniel Mack wrote:
> Hi Russell,
> 
> On Thu, Nov 12, 2009 at 09:52:01PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 12, 2009 at 02:58:07PM +0100, Daniel Mack wrote:
> > > The revision field in /proc/cpuinfo is reported as hex number, so it
> > > should have a '0x' prefix to make that clear. Otherwise, parsers
> > > will take it as decimal number unless it contains a letter.
> > 
> > So what you're doing is possibly breaking existing parsers (which
> > probably already assume it is hex) to fix buggy parsers?
> 
> I wouldn't call that fixing a buggy parser. On my board, the revision is
> 0x101 which was parsed as 101. You can't know it is in hex unless you
> look at the sources.

However, we export lots of stuff from the kernel in hex without an '0x'
prefix.

The biggest point here, though, is that the field is already present and
has been used, created about 10 years ago for NetWinder stuff.  So we've
about 10 years of history of it being there.  Adding the '0x' prefix may
break existing parsers, which is a good enough reason not to change it.

Moreover, if you try to parse the field using strtoul, you'll generally
end up with it being interpreted as an _octal_ number due to the leading
zeros - which should be enough of a hint that it isn't a decimal number.

If you really feel strongly about it, then the only portable way of fixing
it would be to create a new entry in the file with the '0x' prefix.
