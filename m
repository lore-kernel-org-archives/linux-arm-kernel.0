From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 23:13:32 +0000
Subject: [PATCH v2 03/28] ARM: imx: convert to common runtime ioremap hook
In-Reply-To: <4F4EACDD.4090502@gmail.com>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201202292134.03220.arnd@arndb.de> <4F4EACDD.4090502@gmail.com>
Message-ID: <201202292313.32422.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Rob Herring wrote:
> Sure, but it's not my call what the i.MX guys do. I'm just generalizing
> what i.MX already has for other platforms to use. Since we have no way
> to create static mappings from devicetrees I don't think we want to
> expand static mappings. Also, your past guidance has been to get rid of
> static mappings.

The problems with static mappings have been largely resolved with the
new way we automatically handle ioremap redirecting to the static
mapping area, so now it's no longer necessary to hardcode the virtual
address in a header file and the static mapping basically becomes
a performance optimization by using section mapping where possible.

> Even if we got rid of it here and on msm, there are still other
> platforms that need custom ioremap where static mappings won't help.
> ebsa110 and ixp4xx also need ioremap but I didn't convert them to
> runtime from compile time since they still need io.h for other reasons
> at this point.

Right. When I replied on this patch first, I hoped that this one might
be the only one left.

One thing that could be done though is to remove the __arch_ioremap
macros after all platforms overriding this at compile time have been
changed to do so at boot time.

If we wanted to get fancy, we could also have a Kconfig symbol that
turns on the run-time selected ioremap only for platforms that require
it, and otherwise directly calls __arm_ioremap.

	Arnd
