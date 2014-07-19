From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Jul 2014 00:00:12 +0100
Subject: bios32.c: Fix me in pci_fixup_it8152
In-Reply-To: <CAPDOMVibN_jYoxHyaE1sRXj6garOmKvFoMXGV62B4FONTgJGMQ@mail.gmail.com>
References: <CAPDOMVibN_jYoxHyaE1sRXj6garOmKvFoMXGV62B4FONTgJGMQ@mail.gmail.com>
Message-ID: <20140719230012.GC21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 06:47:37PM -0400, Nick Krause wrote:
> Hey Russell and others,
> Before I clean this fix me up I wanted to known how to define the values
> as stated in the fix me in this function or if this is invalid as of the
> latest kernel trees.

If you would like to fix it properly, then that's fine.  The comment
there says:

        /* FIXME: add defines for class 0x68000 and 0x80103 */
        if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
            dev->class == 0x68000 ||
            dev->class == 0x80103) {

The thing that's slightly confusing here is that dev->class contains
the class in bits 24..8, but also the programming interface in bits
7..0.

So, the comment is slightly wrong in that it's actually meaning
class 0x0680 with a programming interface of 0x00, and a class of
0x0801 with a programming interface of 0x03.

Your challenge is to _not_ add defines for these, but to use the
existing defines for these classes, and modify the code to use those
defines /without/ changing the effect of the checks.  Ignore that
there's no definitions of the programming interfaces - they can
stay as raw numbers.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
