From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 19:05:48 +0000
Subject: ioremap vs remap_pfn_range, VMSPLIT, etc
In-Reply-To: <54B013F0.10408@free.fr>
References: <54AFD09E.1010806@free.fr>
 <20150109131322.GO12302@n2100.arm.linux.org.uk>
 <54B013F0.10408@free.fr>
Message-ID: <20150109190548.GB12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 06:46:24PM +0100, Mason wrote:
> On 09/01/2015 14:13, Russell King - ARM Linux wrote:
> 
> > On Fri, Jan 09, 2015 at 01:59:10PM +0100, Mason wrote:
> >> I was expecting it to fail.
> >>
> >> - the kernel is configured with VMSPLIT_3G (3G/1G user/kernel)
> > 
> > This has no bearing on the above.
> 
> I don't understand why.
> 
> mmap allocates virtual addresses in the user-space process, yes?
> So if I had VMSPLIT_2G, user-space processes would be limited
> to 2G virtual addresses, and could not create a single 2G map
> on top of its stack and text space. Or am I missing something?

I explained in the paragraph you quoted from me below:

> >> - the kernel manages 256 MB RAM
> >> - there is roughly 750 MB of VMALLOC space, no highmem
> > 
> > vmalloc has no bearing on the above, mmap() doesn't allocate anything
> > into vmalloc space.
> 
> This means remap_pfn_range doesn't "put" anything in the kernel's
> virtual address space.

Correct.

To answer a query you had elsewhere, if you have the 2G/2G VM split,
then no, you can't map 2G, because you will already have userspace
mappings (eg, for the stack, and program text) which will consume
some of the 2G.

So, asking mmap() to make 2G will fail, because it won't fit in the
space available to the user program.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
