From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 29 Jan 2013 07:56:46 +0100
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130128182818.GC9436@obsidianresearch.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130128182818.GC9436@obsidianresearch.com>
Message-ID: <20130129065646.GO29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 11:28:18AM -0700, Jason Gunthorpe wrote:
> On Sun, Jan 27, 2013 at 03:53:53PM +0100, Sebastian Hesselbarth wrote:
> 
> > I just want Simon to confirm that Kirkwood's gbe is really loosing the
> > contents of its MAC address registers during gated clocks, which is from
> > a HW point of view very unlikely.
> 
> FWIW, there are two block power management controls on the kirkwood
> chips, one is documented to a clock gate, and one is documented to a
> be a power down.

Hi Jason

Are you referring to 

Memory Power Management Control Register
Offset: 0x20118

Bit Field Type / Init Val Description
0 GE0_Mem_PD RW GbE0 Memory Power Down:
                 0x0 0 = Functional
                     1 = PowerDown
1 PEX0_Mem_PD RW PCI Express0 Memory Power Down;
                 0x0 0 = Functional
                     1 = PowerDown
2 USB0_Mem_PD RW USB0 Memory Power Down:
                 0x0 0 = Functional
                     1 = PowerDown

etc.

> I wouldn't expect the clock gate to have a problem
> with the MAC address, but the powerdown I would expect to wipe it..

As far as i know, we don't touch it. However, as a debug exercise, it
would be good to print its value at boot, at ethernet driver load
time, after unused clocks are disabled, when the ethernet clock is
enabled by the driver, etc.

	Andrew
