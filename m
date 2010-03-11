From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 11 Mar 2010 16:48:45 -0600
Subject: Question about memory resources
Message-ID: <0D753D10438DA54287A00B0270842697636843779C@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I have written a backlight driver for the ep93xx.  The backlight
on this system is controlled by a pwm output with a single control
register.  This register is located in the memory resource used
by the ep93xx framebuffer.

The framebuffer uses the following resource:

static struct resource ep93xx_fb_resource[] = {
	{
		.start	= EP93XX_RASTER_PHYS_BASE,
		.end		= EP93XX_RASTER_PHYS_BASE + 0x800 - 1,
		.flags	= IORESOURCE_MEM,
	},
};

The backlight would use this resource:

static struct resource ep93xx_bl_resource[] = {
	{
		.start	= EP93XX_RASTER_PHYS_BASE + 0x20,
		.end		= EP93XX_RASTER_PHYS_BASE + 0x23,
		.flags	= IORESOURCE_MEM,
	},
};

Unfortunately this doesn't work because the request_mem_region
call fails when the second device is probed since the first
device already did a request_mem_region and it was marked as
IORESOURCE_BUSY.

Is there any way to handle this other than using the static i/o
mapping for the backlight register?

Regards,
Hartley
