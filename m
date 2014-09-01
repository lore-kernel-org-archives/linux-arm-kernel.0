From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 16:31:28 +0200
Subject: [RFC PATCH 1/7] iommu: provide early initialisation hook for
 IOMMU drivers
In-Reply-To: <20140901075216.GA24430@ulmo>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-2-git-send-email-will.deacon@arm.com>
 <20140901075216.GA24430@ulmo>
Message-ID: <4386980.goxm0OjCmJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 September 2014 09:52:19 Thierry Reding wrote:
> I don't think this is the right direction. We've been preaching that
> using initcall ordering is a bad thing and people should be using
> deferred probe instead. Now we have a bunch of these OF tables that do
> the exact opposite. Note that these are nothing more than a variant of
> initcalls that get called at platform-specific points in time.
> 
> There are also ongoing discussions about how to change the device probe
> order to use dependencies (such as phandles from device tree) to prevent
> excessive deferred probing. With that in place this would be solved in a
> much more generic way.

We are not creating an ABI here, so it can always be changed later.
For now, I think iommus are clearly in the same category as irqchips,
timers, clock controllers and smp operations: we really want them
to be available before we set up any other devices.

I don't mind finding a more generic solution in the long run, but for
now, this gets the problem out of the way, and I can't think of any
realistic corner cases that would prevent it from working. Do you
think that an IOMMU driver may have a dependency on another device
driver that is probed later? Do you have an example of such hardware?

	Arnd
