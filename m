From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 11:40:51 +0200
Subject: [PATCH v4 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130409004253.GA2258@localhost>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130408171940.GA8815@obsidianresearch.com>
 <20130409004253.GA2258@localhost>
Message-ID: <201304091140.51839.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Ezequiel Garcia wrote:
> > This can probably just be of_platform_populate or similar to do all
> > children? For instance, I often use many DT nodes to represent a FPGA,
> > since the my FPGA's tend to have many functionally orthogonal units
> > inside.
> > 
> 
> In the past I've found it's not possible to use of_platform_populate,
> altough I can be wrong.
> 
> The problem seems to be that through of_platform_populate() it's
> possible that the child device (cfi-flash, for instance) gets probed
> before the devbus controller. In other words, the actual parent-child
> relationship gets lost and it's necesarry to use some child probe deferal
> mechanism.
> 
> This has been recently discussed [1] when implementing GPMC where for simplicity
> the of_platform_device_create() solution was chosen.
> Anyway, I'll try of_platform_populate early tomorrow.

I think the problem mentioned in that thread was that the device would
automatically get probed by the top-level of_platform_populate() when
you mark the devbus as compatible="simple-bus", which is not what Jason
was referring to. Instead you should call of_platform_populate in the
probe() function of the devbus device to probe its children after
the bus is set up.

	Arnd
