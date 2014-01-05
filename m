From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Jan 2014 00:51:55 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <201401052017.10982.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <201401052017.10982.arnd@arndb.de>
Message-ID: <20140105235155.GB4093@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 08:17:10PM +0100, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Andrew Lunn wrote:
> > That would be rather odd. These nodes are in the top level SoC dtsi
> > file. When they are not used, they have status = "disabled" and are in
> > the dtb blob with this state.
> > 
> > The only reason i can think of them not being present at all is if
> > somebody adds an optimizer to dtc which removed disabled nodes. What
> > does the device tree spec say about that? Are we relying on undefined
> > dtc behavior?
> 
> There is no requirement to use the include files. If someone decides
> to ship a default dtb file in their boot loader, it wouldn't be
> a bug to leave the nodes out entirely.

Hum, yes, interesting.

This raises the question, should mainline try to support any random
dtb blob, or only those that have ever shipped with mainline?

There are some older mainline DT blobs which won't have PCIe in them,
since PCIe support was not there day 1. So returning -ENODEV, and the
i2c controller assuming an A0 would make sense.

But what should we do if somebody was to boot linux with a FreeBSD DT
blob? It is a valid blob, it describes the hardware, but the FreeBSD
nodes have different compatibility strings, don't have clocks, etc.
Now that is at the extreme of the range, but where do we put the
marker for compatibility in this range from current mainline blobs to
FreeBSD blobs?

Andrew
