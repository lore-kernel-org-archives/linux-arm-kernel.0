From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2016 11:20:04 +0100
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <20160615224228.GK1041@n2100.armlinux.org.uk>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
 <20160615211359.GJ1041@n2100.armlinux.org.uk>
 <CAGXu5jKRBA9b6gos+FG7iV2ppxtAERstNPschxA0z=aDL_y1YA@mail.gmail.com>
 <20160615224228.GK1041@n2100.armlinux.org.uk>
Message-ID: <20160707102003.GO1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:42:28PM +0100, Russell King - ARM Linux wrote:
> The boot environment must be setup such that there is room for the
> uncompressed image (aligned currently to 256 bytes) followed by the
> size of the compressed image, with any appended DTBs included.
> Anything which is located below that is likely to get trampled by
> the decompressor.

There's a question that's been lingering, which hasn't been brought up
by anyone yet: should we even support zImage files with an appended
DTB for kexec?

When kexec is operating in DTB mode, it will provide the DTB to the
kernel from the host environment, possibly with some modifications (eg,
to change the command line arguments.)  Since an appended DTB would
override the kexec-provided DTB, this would wipe out those changes,
some of which are necessary for things like crashdump to work.

So, I'm thinking that kexec should not support a zImage with appended
DTB - in fact, I think it should truncate the zImage to be loaded, and
ensure that the word following the zImage does not contain a DTB magic
number, in case the zImage has been built with CONFIG_ARM_APPENDED_DTB
enabled.

Thoughts?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
