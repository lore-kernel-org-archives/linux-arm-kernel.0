From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Oct 2016 16:58:52 +0100
Subject: Build failure with v4.9-rc1 and GCC trunk -- compiler weirdness
In-Reply-To: <20161019133500.GQ9193@arm.com>
References: <20161017183806.GG5601@arm.com>
 <CAKv+Gu869PXA_cXaL6+uokRCS4EZ8-q6x2xnj4e5DWO28B5jCw@mail.gmail.com>
 <20161019133500.GQ9193@arm.com>
Message-ID: <20161019155852.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 02:35:00PM +0100, Will Deacon wrote:
> Hi Ard,
> 
> On Mon, Oct 17, 2016 at 08:43:19PM +0100, Ard Biesheuvel wrote:
> > If order_base_2() is not defined for input 0, it should BUG() in that
> > case, and the associated __builtin_unreachable() should prevent the
> > special version from being emitted. If order_base_2() is defined for input
> > 0, it should not invoke ilog2() with that argument, and the problem should
> > go away as well.
> 
> I don't necessarily think it should BUG() if it's not defined for input
> 0;

In any case, Linus will have a rant about that: Linus has already been
concerned about the abuse of BUG().  BUG() should not be used as an
assert() replacement, but should be used where we have absolutely
no other option than to crash the kernel, because (eg) continuing
would result in the users' data being corrupted.

So no, BUG() is not the answer here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
