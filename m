From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 11:26:23 +0100
Subject: [PATCH v3 1/7] ARM: Align machine_desc.phys_io to a 1MB section
In-Reply-To: <1277114749.20758.24.camel@e102109-lin.cambridge.arm.com>
References: <20100621093530.GE7702@n2100.arm.linux.org.uk>
	<1277114749.20758.24.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100621102623.GI7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 11:05:49AM +0100, Catalin Marinas wrote:
> On Mon, 2010-06-21 at 10:35 +0100, Russell King - ARM Linux wrote:
> > On Mon, Jun 21, 2010 at 10:13:31AM +0100, Catalin Marinas wrote:
> > > Platforms like RealView don't pass a section-aligned pointer via the
> > > machine_desc structure. This patch aligns the pointer in the
> > > __create_page_tables function. Reported by Tony Thompson.
> > 
> > I still say this is the wrong way.  As I've said before, please fix it
> > at the machine_desc initialization point.  
> 
> This requirement doesn't seem to be well documented and platforms don't
> follow it (e.g. RealView and VExpress). Since it's the head.S code
> responsible for this temporary mapping, the platform code wouldn't need
> to know whether sections or pages or something else are used to map it.
> But io_pg_offst already makes the assumption about sections.

We're never going to map it using sections - using pages implies a
way to allocate 2nd level page tables, and we don't have any memory
allocators which can work this early.

> > If you want, pass it as the
> > section frame number itself (address >> 20) rather than the address to
> > allow for more addressing space.
> 
> I would rather go for a PFN to allow more addressing space (but doesn't
> solve the section alignment).

PFNs don't solve the problem you've brought up - might as well stick
with what we have in that case.
