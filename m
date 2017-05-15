From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 May 2017 11:00:34 +0100
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170512143600.GB18818@leverpostej>
References: <20170510051304.131042-1-yanjiang.jin@windriver.com>
 <20170510051304.131042-2-yanjiang.jin@windriver.com>
 <20170512143600.GB18818@leverpostej>
Message-ID: <20170515100033.GT22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 03:36:01PM +0100, Mark Rutland wrote:
> However, AFAICT, this patch forcibly resets is without any teardown
> having happened. That will surely result in data being lost from the
> caches, for example.

You're wrong on that point.  Having each bloody platform implement
the same friggin teardown is utter madness, and leads to all sorts
of synchronisation issues.

The generic code already deals with the cache issues, and has
synchronisation to ensure that the dying CPU completes the cache
handling before the requesting CPU continues with the killing.
The only thing that platform code need concern itself with is doing
is the "make the CPU die" thing.

It's not perfect, but it's good enough for the majority of cases.

In any case, encouraging people to add flush_cache_all() into their
cpu_die() function is NOT the way forward if there is a problem -
that introduces a new race between flush_cache_all() walking all the
cache lines and cpu_kill() actually turning the power off to the CPU,
which could very well happen either before or during the
flush_cache_all() execution.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
