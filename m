From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 21 Sep 2009 23:25:47 +0100
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <20090921212637.GG30821@n2100.arm.linux.org.uk>
References: <20090920093139.GA1704@n2100.arm.linux.org.uk>
	<20090920190227.GB5413@n2100.arm.linux.org.uk>
	<4AB6B0AB.8040307@arm.com> <20090921083109.GC20006@shareable.org>
	<1253522944.1541.3.camel@pc1117.cambridge.arm.com>
	<20090921085425.GC27357@n2100.arm.linux.org.uk>
	<1253526263.1541.32.camel@pc1117.cambridge.arm.com>
	<20090921100751.GF27357@n2100.arm.linux.org.uk>
	<20090921201043.GA14700@shareable.org>
	<20090921212637.GG30821@n2100.arm.linux.org.uk>
Message-ID: <20090921222547.GG14700@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> > Hopefully it's clear that munmap of the region, followed by mmap
> > PROT_READ|PROTE_EXEC to restore the mapping with different permissions
> > (when it has a backing file) - hopefully it's clear that _that_ will
> > do the needed I-cache flush.
> 
> Not necessarily, especially if the file is mapped using MAP_PRIVATE.

If the answer is not necessarily for MAP_SHARED, then we're in trouble
when someone does

    internal_untar("some_files.tar.gz");

        -> Uses open/ftruncate/mmap(PROT_WRITE)/close to write the files.

    dlopen("some_files/code.so")
    code(...)

Which strikes as the sort of thing people might do these days.

For MAP_PRIVATE...  I'm not sure if that will trip people up or not.

-- Jamie
