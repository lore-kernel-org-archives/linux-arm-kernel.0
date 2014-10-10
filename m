From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 10 Oct 2014 09:54:16 +0200 (CEST)
Subject: [Cocci] [RFC] drop owner assignment from platform_drivers
In-Reply-To: <20141010072439.GA1741@katana>
References: <20141010072439.GA1741@katana>
Message-ID: <alpine.DEB.2.10.1410100951250.2402@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @match1@
> declarer name module_platform_driver;
> declarer name module_platform_driver_probe;
> identifier __driver;
> @@
> (
> 	module_platform_driver(__driver);
> |
> 	module_platform_driver_probe(__driver, ...);
> )
>
> @fix1 depends on match1@
> identifier match1.__driver;
> @@
> 	static struct platform_driver __driver = {
> 		.driver = {
> -			.owner = THIS_MODULE,
> 		}
> 	};
>
> @match2@
> identifier __driver;
> @@
> (
> 	platform_driver_register(&__driver)
> |
> 	platform_driver_probe(&__driver, ...)
> |
> 	platform_create_bundle(&__driver, ...)
> )
>
> @fix2 depends on match2@
> identifier match2.__driver;
> @@
> 	static struct platform_driver __driver = {
> 		.driver = {
> -			.owner = THIS_MODULE,
> 		}
> 	};

The semantic patch looks fine.  I'm a little surprised that it doesn't
complain about the lack of a comma after

.driver = { .owner = THIS_MODULE, }

but it seems that it does not.

If you think that it would be useful to have this in the Linux kernel, so
people don't add the owner initializer back in the future, you can try

coccinelle/tools/sgen/sgen

(run make in the coccinelle/tools/sgen directory).  That will guide you
through the process of making a Linux-ready semantic patch.  Feedback
would be appreciated.

julia
