From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 22:45:55 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612111441.E6D603E0A56@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <4160363.LWJuHATm2F@wuerfel> <20130612111441.E6D603E0A56@localhost>
Message-ID: <201306122245.55960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Grant Likely wrote:
> I think we should have almost everything needed already to do this.
> of_bus allows arbitrary mapping code to be used at any stage in the
> translation. We might need to add some glue so that of_busses[] can
> be assembled by the linker to allow an mbus of_bus stanza to live
> outside of drivers/of/address.c
> 

Actually, the best thing about this solution is that we don't even
have to bother setting up the mappings when loading the mbus driver:
We don't need any ranges (other than internal-regs) in DT, and we
don't need complex logic to search through the child devices to
figure out what the mappings should be. The only thing one needs
to do here is check if a mapping already exists when we get into the
of_bus handler and create one for the device being translated if
there isn't one!

	Arnd
