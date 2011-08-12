From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Aug 2011 16:35:42 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110812084106.GC19467@legolas.emea.dhcp.ti.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
Message-ID: <201108121635.42953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 August 2011, Felipe Balbi wrote:
> On Fri, Aug 12, 2011 at 01:02:18PM +1000, David Gibson wrote:
> 
> the whole point of using *byname() is for the driver to not care about
> the order of the resources. So if driver has to provided an ordered list
> of names, what's the benefit ? Sounds really stupid to provide an
> ordered list of names to an ordered list of resources, just to use
> *byname() instead of just assuming the list of resources is already
> ordered.

It only make sense for drivers that support both device tree probing
and legacy probing of static platform devices.

Note how almost all drivers use only platform_get_resource and not
platform_get_resource_byname:

arnd at ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource | wc -l
565
arnd at ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | wc -l
41
arnd at ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wL platform_get_resource | wc -l # both
28
arnd at ocdc-kvm:~/linux-arm$ git grep -wl platform_get_resource_byname | xargs grep -wl platform_get_resource  | wc -l # only _byname
13

I think it's much easier to change the existing users of _byname over
to fixed indexes than to come up with a new scheme that is better.

	Arnd
