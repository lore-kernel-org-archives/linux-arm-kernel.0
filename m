From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 25 Jan 2013 11:34:07 -0700
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
Message-ID: <20130125183407.GC7393@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 04:03:29PM +0100, Sebastian Hesselbarth wrote:
> On Fri, Jan 25, 2013 at 1:52 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Once I have the mv643xx_eth binding working reliably, preferably with
> > mvmdio, I'll take a look at removing the last board-*.c files.  If the
> > stars align, we'll get it all done for v3.9.
> >
> > The only big thing left will be pcie.

> there is also addr_map that we haven't thought about yet. Is it supposed
> to be configurable through DT or do we leave it as "linux wants it that way"?

FWIW, this was a pain + surprise for us when we started out. The
address map Linux wants is not the same as the device power on
default, and the Linux mapping is hardwired into the kernel :(

I would be happy to see the address map setup be more flexible and
done via DT. It would be a bit of a pain to change, but via DT each
decoded window could be described as a bus with a ranges and an OF
address map driver could directly setup the windows to match those DT
nodes. Something like this, repeated for each window:

        // MBUS Decoder window for NAND
        nand at f4000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "simple-bus", "marvell,orion-mbus";
		mbus-target = 0xXXXXX;
                ranges = <0 0xf4000000 0x10000>;

                nand at 0 {
                        cle = <0>;
                        ale = <1>;
                        bank-width = <1>;
                        chip-delay = <50>;
                        compatible = "marvell,orion-nand";
                        reg = <0x0 0x400>;
                };
        };

	// MBUS decoder window for internal registers
        internal at f1000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "simple-bus", "marvell,orion-mbus";
		mbus-target = 0xXXXXX;
                ranges = <0 0xf1000000 0x100000>;

                intc: interrupt-controller at 20204 {
                        #interrupt-cells = <1>;
                        compatible = "marvell,orion-intc", "marvell,intc";
                        interrupt-controller;
                        reg = <0x20204 0x04>,
                              <0x20214 0x04>;
                };

 		[... etc ...]
        };

Regards,
Jason
