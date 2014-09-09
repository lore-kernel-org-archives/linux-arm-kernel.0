From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 11:27:12 +0200
Subject: [GIT PULL] at91: drivers for 3.18 #2
In-Reply-To: <20140909091520.GJ3804@lukather>
References: <1409934969-11584-1-git-send-email-nicolas.ferre@atmel.com>
 <26517543.McM8Q5P0vn@wuerfel> <20140909091520.GJ3804@lukather>
Message-ID: <3053665.vhA4jELi7x@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 11:15:20 Maxime Ripard wrote:
> 
> > One of the problems with the current interface is that it requires
> > statically declaring platform_device structures, which is something
> > that has been on Greg's list of device model antipatterns for a long
> > time.
> 
> I didn't find any difference with how you declare platform_devices
> compared to the old-usual way in board files, or was it something on
> the list too ? 

Yes. We never really bothered with cleaning up the existing static
platform_device instances, because the plan is to move away from
board files to DT anyway, but in short, if you ever need to add
a platform device to a legacy board file, do it like

	pdev = platform_device_alloc(...);
	platform_device_register(dev);

or

	platform_device_register_simple(...);

or

	static const struct platform_device_info info __initconst = { ... };
	platform_device_register_full(&info);

but not

	static struct platform_device pdev = { ... };
	platform_device_register(&pdev);

Unfortunately, the early platform_device only allows the last type.

	Arnd
