From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Jul 2014 23:44:13 +0100
Subject: [PATCH] ARM: config: update multi_v7_defconfig
In-Reply-To: <CABxcv==+cwoXA=WM3E7Zb62T0Epgqg_oH3UNU0vEe2DDPiCYPA@mail.gmail.com>
References: <1405411346-12471-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
 <CABxcv==+cwoXA=WM3E7Zb62T0Epgqg_oH3UNU0vEe2DDPiCYPA@mail.gmail.com>
Message-ID: <20140717224413.GA21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 12:31:48AM +0200, Javier Martinez Canillas wrote:
> In the case of the MAX77686, the mfd, regulator and clock drivers use
> subsys_initcall() instead of module_init() but I wonder which of these
> really need to be initialized at subsys init call time and which one
> can just be built as a module.

I think you're making a frequently made mistake concerning module
initialisation.

Having code initialised by subsys_initcall() (or indeed any other level)
does not preclude it being a module:

#ifndef MODULE
...
#define subsys_initcall(fn)             __define_initcall(fn, 4)
...
#else /* MODULE */
...
#define subsys_initcall(fn)             module_init(fn)
...
#endif

So, subsys_initcall() automagically becomes module_init() when built
as a module.  There's no need to change anything here.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
