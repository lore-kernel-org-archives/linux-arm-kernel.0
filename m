From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Jan 2014 16:59:25 +0100
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <1389174517.12612.87.camel@kazak.uk.xensource.com>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <1389174517.12612.87.camel@kazak.uk.xensource.com>
Message-ID: <20140108155925.GA32641@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 09:48:37AM +0000, Ian Campbell wrote:
> On Mon, 2014-01-06 at 23:49 +0100, Andrew Lunn wrote:
> > Re-implement the Marvell Kirkwood ts41x-setup.c in DT.
> > 
> > As with the QNAP 119, there are two variants, depending on which SoC
> > has been used. They differ on Ethernet PHY addresses and number of
> > PCIe busses.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> On the assumption that this is basically the same as the think you asked
> me to test last week:
> Tested-by: Ian Campbell <ijc@hellion.org.uk> (specifically kirkwood-ts419-6281.dtb)
 
It is the same. Thanks for testing.

> What is the plan for the board files for the ts* platforms? Are they
> going to go away? This seems to have happened for the Sheevaplug case,
> which is causing some transition pain for distros (e.g.
> http://bugs.debian.org/731345).

We plan to make them go away. We are not quite there yet, there are
still a couple of boards which don't have DT files. But we are working
on those.
 
> The big issue for the ts devices is that each board file seems to be
> splitting into two DTB files so in order to handle upgrades we need to
> be able to detect which of the two variants we need, both when running
> the previous board-file kernel and when running the DT version. Any
> advice? You previously pointed me to a string in the dmesg but this
> might not be reliable if the early boot messages have gone from the
> circular buffer and in any case I'm not sure how wise it is to rely on
> parsing those.
> 
> It looks like the board files determine things based on
> kirkwood_pcie_id() -- is the result of that available in userspace
> anywhere? I suppose counting the number of PCI buses would work, not a
> brilliant solution but given the need to work with board file kernels
> too maybe that's the best option.

This is an issue, which has been discussed a bit recently while fixing
an i2c issues on Marvell XP SoCs. As far as i know, there is no
reliable export of the version field. It might be available from
lspci, but so far i've not seen it. I will look into this in the next
few days.

> The other issue I spotted is
> that /dev/input/by-path/platform-gpio-keys-event has
> become /dev/input/by-path/platform-gpio_keys.3-event. Is it considered
> valid for a by-path name to change? In particular the 3 here is
> apparently the node depth in the DTB, which doesn't make much logical
> sense as a "path" in this context I don't think (I expect it to be some
> sort of path through the hardware buses, perhaps my expectation is
> wrong?).

To be honest, i've no idea about this. I hope somebody else will
answer. If not, we might need to ask on the input mailing list.

	Andrew
