From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 16:32:21 +0000
Subject: [RFC] arm: Defer lookup of machine_type and vet of atags to
	setup.c
In-Reply-To: <AANLkTinwGd9pa7YQ=5hXfarw=MB=YdpBuN7xJAd+Ps4f@mail.gmail.com>
References: <20110111015409.18291.87166.stgit@localhost6.localdomain6>
	<20110111104051.GA11039@n2100.arm.linux.org.uk>
	<20110111153630.GB2707@angua.secretlab.ca>
	<20110111154833.GF11039@n2100.arm.linux.org.uk>
	<AANLkTi=29LB66j123ufMHQk=46hGYdmR4nZZQFnN=Tku@mail.gmail.com>
	<20110112155215.GB11039@n2100.arm.linux.org.uk>
	<AANLkTinwGd9pa7YQ=5hXfarw=MB=YdpBuN7xJAd+Ps4f@mail.gmail.com>
Message-ID: <20110112163221.GD11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 09:24:34AM -0700, Grant Likely wrote:
> Actually it looks like the real problem is that the mmu has been
> turned on, but the virtual mappings for devices have not yet been
> established, and so the debug macros aren't using a valid address.

They should be, as they're valid for use from assembly prior to MMU
turn-on, assembly after MMU turn-on and C code.

If CONFIG_DEBUG_LL is enabled, create_page_tables() should be setting
up the necessary initial mappings for printascii() to work.

Maybe the efforts to unify that stuff ended up breaking the printascii
debugging mechanism, and we now require a new debugging mechanism to
debug the printascii debugging mechanism... :-P

I've used it on Versatile Express during the last week and it did work
right from before setup_arch() was called.

> It looks like I'd need to get past paging_init() in order to get
> ll_debug working between turning on the mmu and paging_init(), but
> paging_init() needs the mdesc pointer, and the whole point of the
> error message is that the mdesc pointer is unknown!  I don't see any
> code that sets up a debug mapping of the uart before paging_init time.

See the #ifdef CONFIG_DEBUG_LL section in create_page_tables in head.S
