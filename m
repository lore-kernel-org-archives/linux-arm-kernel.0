From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Feb 2014 17:42:05 +0100
Subject: [PATCH] phy-core: Don't allow building phy-core as a module
In-Reply-To: <1392134631-32030-1-git-send-email-hdegoede@redhat.com>
References: <1392134631-32030-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140211164205.GC24633@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 05:03:51PM +0100, Hans de Goede wrote:
> include/phy/phy.h has stub code in there for when building without the
> phy-core enabled. This is useful for generic drivers such as ahci-platform,
> ehci-platoform and ohci-platform which have support for driving an optional
> phy passed to them through the devicetree.
> 
> Since on some boards this phy functionality is not needed, being able to
> disable the phy subsystem without needing a lot of #ifdef magic in the
> driver using it is quite useful.
> 
> However this breaks when the module using the phy subsystem is build-in and
> the phy-core is not, which leads to the build failing with missing symbol
> errors in the linking stage of the zImage.
> 
> Which leads to gems such as this being added to the Kconfig for achi_platform:
> 
> 	depends on GENERIC_PHY || !GENERIC_PHY
> 
> Rather then duplicating this code in a lot of places using the phy-core,
> I believe it is better to simply not allow the phy-core to be built as a
> module. The phy core is quite small and has no external dependencies, so
> always building it in when enabling it should not be an issue.

Hi Hans

I ran into the same problem with sata_mv. I ended up adding a select
GENERIC_PHY to force it to be built in.

So i agree with you to make it only built in.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
