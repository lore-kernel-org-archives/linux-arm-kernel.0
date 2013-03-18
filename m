From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 18 Mar 2013 15:05:58 -0600
Subject: [PATCH 1/1] ARM: kirkwood: Fix chip-delay for GoFlex Net
In-Reply-To: <20130318192653.GZ21478@lunn.ch>
References: <51476198.2080100@gmail.com>
 <20130318192653.GZ21478@lunn.ch>
Message-ID: <20130318210558.GB31817@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 08:26:53PM +0100, Andrew Lunn wrote:
> On Mon, Mar 18, 2013 at 07:48:56PM +0100, Eric Hutter wrote:
> > Hi,
> > 
> > This fixes "Too few good blocks within range" issues on GoFlex Net
> > by setting chip-delay to 40.
> 
> Hi Eric
> 
> Its a problem seen by a couple of other boards as well, e.g. dns320
> and dns325.

The MTD core default of 20us is too small for modern NAND flash.. This
number is based on the chip's datahseet, it should be the longest
non-programming command BUSY interval. Eric, if you haven't already,
it is worth a quick check of the datasheet to verify. Eg the Micron
flash on my Kirkwood system should be 70us.

u-boot can sometimes get away with a smaller value because it only
uses a limited set of commands.

It is on my TODO list to implement ONFI READY/BUSY# pin support in the
orion-nand driver via a GPIO - could other systems make use of this as
well?

Regards,
Jason
