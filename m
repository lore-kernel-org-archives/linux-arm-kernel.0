From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 May 2012 16:41:45 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB2714F.5080703@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <4FB26904.1060308@codethink.co.uk> <20120515165813.66b4434e@skate>
 <4FB2714F.5080703@codethink.co.uk>
Message-ID: <20120515154145.GE13860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 04:07:59PM +0100, Ben Dooks wrote:
> I think it was because that PCI was initialised early and requires a
> large mapping space. It is very likely to be legacy kernel stuff that
> people have kept copying through.

No.  PCI needs nothing other than access to the configuration space, and
the PCI IO window.  There has _never_ been any hard requirement to map
PCI memory in map_io() because that is _always_ done by drivers calling
ioremap().

There is one exception to this: if you have a VGA card in a PCI slot,
it appears by default as an ISA peripheral with the VGA memory
appearing at around PCI_MEM_BASE + 640K or so.  Linux expects that
to already be mapped.

If you're not supporting VGA cards in text mode, that detail doesn't
concern you.
