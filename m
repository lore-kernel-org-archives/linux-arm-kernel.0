From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 May 2011 15:11:23 +0200
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform bus
	scan
In-Reply-To: <1306359073-16274-3-git-send-email-robherring2@gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<1306359073-16274-3-git-send-email-robherring2@gmail.com>
Message-ID: <201105261511.23659.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 May 2011, Rob Herring wrote:
> 
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add support to the platform bus scanning to call custom device creation
> functions. This enables creation of non-platform devices like amba_bus.
> 
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: linux at arm.linux.org.uk
> Cc: arnd at arndb.de
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

This creates a confusing mix of match table entries: Normally,
all entries in the match table are meant to identify child buses,
but if I read your patch correctly, you now also need to match
on the amba devices themselves, including the creation of
platform devices for each child device node under an amba
device.

I don't think that was the intention. Maybe we need to pass
two match tables into of_platform_bus_probe() instead:
one to identify the buses, and another one that is used
to create the actual devices.

	Arnd
