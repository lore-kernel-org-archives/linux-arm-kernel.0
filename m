From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Mar 2017 18:07:45 +0000
Subject: L2 cache management question
In-Reply-To: <bdcc07da22ae43589768d6d4aebbf788@XCH-RTP-013.cisco.com>
References: <bdcc07da22ae43589768d6d4aebbf788@XCH-RTP-013.cisco.com>
Message-ID: <20170308180745.GY21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 11:44:12AM +0000, Bijal Shah (bishah) wrote:
> Looking at l2x0_cache.c file in the arch/arm/mm directory, I see a
> common pattern for an address range flush where if the address range
> is larger than the cache size, a flush_all is called almost without
> question. Is there any specific reason for this? Asking for the
> project I'm working on, as the address ranges may contain very few
> if any dirty lines, and a flush_all is expensive and locks out other
> CPUs while it is going on.

Flushing by cache line for large address ranges is also very expensive.
As with everything like this, the threshold is a balance between the
relative expenses of the alternatives.

We're not going to change the threshold without a fully justified reason
to change it - which implies that performance measurements are needed to
back up any case.

As it'll be workload specific, so picking one particular workload that
justifies a spefific case won't be all that persuasive - we optimise
for the general case and _maybe_ if there's good reason provide a
tuning knob to allow the threshold to be adjusted.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
