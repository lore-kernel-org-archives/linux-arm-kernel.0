From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jan 2013 21:28:47 +0000
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-6-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20130109212847.GT3931@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 09:43:05PM +0100, Thierry Reding wrote:
> The I/O map cache is used to map large regions of physical memory in
> smaller chunks to avoid running out of vmalloc()/ioremap() space.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

We already have a means where we record the mappings which ioremap()
creates.  If you look at /proc/vmallocinfo, you'll notice lines such
as:

0xf7b72000-0xf7b74000    8192 e1000_probe+0x291/0xa68 [e1000e] phys=fc025000 ioremap

which gives you the virtual address range, physical address and type
of the mapping.  Why do we need a duplicated data structure?

Moreover, you seem to suggest that you want to break up a large
ioremap() mapping into several smaller mappings.  Why?  The idea
behind ioremap() is that this relationship holds true:

	ptr = ioremap(cookie + n, size);

For any 'n' in the range 0 .. size, the location shall be accessible
via ptr + n when using the IO space accessors.  If you're going to
break up a mapping into several smaller ones, this no longer holds
true.

If the problem is that you're ioremapping huge address ranges because
you're passing larger-than-required resources to devices, then that's
part of the problem too.
