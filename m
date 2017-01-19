From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Jan 2017 11:42:47 -0800
Subject: [PATCH RFC 0/7] Clean up PHY MMD accessors
In-Reply-To: <20170113152059.GR14217@n2100.armlinux.org.uk>
References: <20170113152059.GR14217@n2100.armlinux.org.uk>
Message-ID: <9fb97d58-6ad3-f9d1-c255-9f91e5857f88@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2017 07:20 AM, Russell King - ARM Linux wrote:
> This series cleans up phylib's MMD accessors, so that we have a common
> way of accessing the Clause 45 register set.
> 
> The current situation is far from ideal - we have phy_(read|write)_mmd()
> which accesses Clause 45 registers over Clause 45 accesses, and we have
> phy_(read|write)_mmd_indirect(), which accesses Clause 45 registers via
> Clause 22 register 13/14.
> 
> Generic code uses the indirect methods to access standard Clause 45
> features, and when we come to add Clause 45 PHY support to phylib, we
> would need to make these conditional upon the PHY type, or duplicate
> these functions.
> 
> An alternative solution is to merge these accessors together, and select
> the appropriate access method depending upon the 802.3 clause that the
> PHY conforms with.  The result is that we have a single set of
> phy_(read|write)_mmd() accessors.
> 
> For cases which require special handling, we still allow PHY drivers to
> override all MMD accesses - except rather than just overriding the
> indirect accesses.  This keeps existing overrides working.
> 
> Combining the two also has another beneficial side effect - we get rid
> of similar functions that take arguments in different orders.  The
> old direct accessors took the phy structure, devad and register number,
> whereas the indirect accessors took the phy structure, register number
> and devad in that order.  Care must be taken when updating future
> drivers that the argument order is correct, and the function name is
> not merely replaced.

I really like that series, this is much much cleaner, do you mind
resubmitting this without a RFC tag so David can apply it?

Thanks!
-- 
Florian
