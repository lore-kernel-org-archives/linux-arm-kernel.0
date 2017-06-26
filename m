From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jun 2017 11:13:04 +0100
Subject: [RFC PATCH 0/2] ARM: Fix unparseable signal frame with
 CONFIG_IWMMXT
In-Reply-To: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
References: <1498059983-13438-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170626101304.GG4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 04:46:01PM +0100, Dave Martin wrote:
> In kernels with CONFIG_IWMMXT=y running on non-iWMMXt hardware, the
> signal frame can be left partially uninitialised in such a way
> that userspace cannot parse uc_regspace[] safely.  In particular,
> this means that the VFP registers cannot be located reliably in the
> signal frame when a multi_v7_defconfig kernel is run on the
> majority of platforms.
> 
> I don't know whether any userspace has implemented any sort of
> workaround for this, but the ABI by itself is insufficient anyway.
> 
> This series attempts to omit the spurious iWMMXt record when
> appropriate.
> 
> Not extensively tested, and the ABI impact is unknown for now.

Hmm, I would actually suggest that we poke in a correct size for the
missing iWMMXt record, and an invalid magic number as the "simple"
solution for this - that doesn't make any layout changes to the
data structures, and is probably the safest solution for backporting.

Going forward, I think something along the lines of your proposal is
okay.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
