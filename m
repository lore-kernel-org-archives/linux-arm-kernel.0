From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 13 Mar 2015 10:28:38 -0700
Subject: [PATCH 03/10] pm: domains: avoid potential oops in
 pm_genpd_remove_device()
In-Reply-To: <E1YWSN0-0006G1-I1@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Fri, 13 Mar 2015 16:23:30 +0000")
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <E1YWSN0-0006G1-I1@rmk-PC.arm.linux.org.uk>
Message-ID: <7ha8zgrem1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> pm_genpd_remove_device() tries hard to validate the generic PM domain
> passed to it, but the validation is not complete.
>
> dev->pm_domain contains a struct dev_pm_domain, which is the "base
> class" of generic PM domains.  Other users of dev_pm_domains include
> stuff like vga_switheroo.  Hence, a device could have a generic PM
> domain or a vga_switcheroo PM domain in dev->pm_domain.
>
> We need ot be certain that the PM domain is actually valid before we
> try to remove it.  

nit: We need to be certain that the PM domain is a valid genpd before we
try to remove the device.

> We can do this easily as we have a way to get the
> current validated generic PM domain for a struct device.  This must
> match the generic PM domain being requested for removal.
>
> Convert the code to use this alternative validation method instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Otherwise,

Acked-by: Kevin Hilman <khilman@linaro.org>
