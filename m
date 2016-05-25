From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 May 2016 18:27:07 +0100
Subject: [PATCH 1/1] arm64: fix flush_cache_range
In-Reply-To: <20160525152255.GH5996@e104818-lin.cambridge.arm.com>
References: <1464088597-8820-1-git-send-email-thunder.leizhen@huawei.com>
 <20160524113727.GD25374@leverpostej> <574446B9.8040105@huawei.com>
 <20160524151235.GA11605@leverpostej>
 <20160525152255.GH5996@e104818-lin.cambridge.arm.com>
Message-ID: <20160525172705.GD19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 04:22:55PM +0100, Catalin Marinas wrote:
> That's when we realised that the CoW problem no longer exists for
> non-aliasing VIPT caches. However, the I-cache counterpart 6060e8df5178
> has not been reverted.

I think I mostly agree, except for reverting 6060e8df5178, which I don't
think would be correct.  That reintroduces the possibility of flushing
the I-cache twice in that path, once for aliasing vipt dcaches, and again
for asid tagged vivt icaches.  I'd rather have the code structured so we
only do this once.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
