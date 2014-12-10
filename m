From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Dec 2014 00:16:32 +0000
Subject: ARM page tables
In-Reply-To: <54877ECA.6050501@free.fr>
References: <54872F9C.2080005@free.fr>
 <20141209172729.GK11285@n2100.arm.linux.org.uk>
 <54877ECA.6050501@free.fr>
Message-ID: <20141210001632.GL11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 11:59:22PM +0100, Mason wrote:
> On 09/12/2014 18:27, Russell King - ARM Linux wrote:
> > On Tue, Dec 09, 2014 at 06:21:32PM +0100, Mason wrote:
> >>  {
> >>   .virtual = (0xf0000000 +(0)),
> >>   .pfn =((unsigned long)((0) >> 12)),
> >>   .length = 0x00800000,
> >>   .type = 0,
> >>  },
> What's the name of the symbolic constant for that address?

swapper_pg_dir

> >> 300 00011452 SECTION
> >> 301 00111452 SECTION
> >> 302 00211452 SECTION
> >> 303 00311452 SECTION
> >> 304 00411452 SECTION
> >> 305 00511452 SECTION
> >> 306 00611452 SECTION
> >> 307 00711452 SECTION
> >> 308 20011452 SECTION
> >> 309 20111452 SECTION
...
> I am investigating this issue:
> 
> As I described, we map PA 0-8MB. But some code actually accesses
> address 0xf0920000 (from kernel space) and I was expecting very
> nasty things, like the equivalent of SIGSEGV in the kernel.
> But nothing happens, no page fault, no BUG_ON, no panic, no
> implosion... (Writes seem ignored, and reads always return 0)

As we can see above, you asked for 0x00200000 bytes to be mapped from
0xf0800000.  So, 0xf0800000 to 0xf09fffff will be mapped.  The address
which you are accessing falls within this range.

So, there's a valid mapping.  Assuming nothing on the bus raises an
external abort, accesses to this address will succeed.

> I don't understand how it is possible to access unmapped virtual
> addresses without the MMU throwing a fit... That's why I'm looking
> at the page table.

You _have_ asked for that address to be mapped.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
