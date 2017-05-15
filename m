From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 May 2017 10:55:14 +0100
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170515091336.10827-2-yanjiang.jin@windriver.com>
References: <20170515091336.10827-1-yanjiang.jin@windriver.com>
 <20170515091336.10827-2-yanjiang.jin@windriver.com>
Message-ID: <20170515095513.GS22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 05:13:36PM +0800, yanjiang.jin at windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> socfpga_cpu_die() just puts CPU in WFI, not actually off. So that Kexec's
> second kernel goes wrong since the kerenl text gets ovewritten.
> Now reset CPU1 in cpu_kill() to avoid this error.
> Also add flush_cache_all() to prevent data from being lost in cpu_die().

You should not need this, as the common code does the cache flushing
for you.

It's rather unsafe too - you are completely unsynchronised between the
CPU executing in cpu_die() and the CPU executing cpu_kill() - it's
quite possible for the code in cpu_kill() to take effect when you're
part-way through the flush_cache_all().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
