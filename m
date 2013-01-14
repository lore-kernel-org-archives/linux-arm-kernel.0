From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 09:27:20 +0000
Subject: [PATCH 2/2] ARM: tegra: Use DT /cpu node to detect number of
 CPU core
In-Reply-To: <1358149970-28156-2-git-send-email-hdoyu@nvidia.com>
References: <1358149970-28156-1-git-send-email-hdoyu@nvidia.com>
 <1358149970-28156-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130114092720.GX23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 09:52:50AM +0200, Hiroshi Doyu wrote:
> +	if (!arm_dt_cpu_map_valid())
> +		set_cpu_possible(0, true);

You don't need to do any of this (and, therefore, I don't think you even
need the first patch.)

The generic boot code will set CPU0 as possible, present and online.  Think
about it: you're booting on that very CPU so it better be possible, present
and online.  If it isn't, what CPU is executing your code?

arm_dt_init_cpu_maps() will only ever set _additional_ CPUs in the possible
map.

Ergo, by the time the above code is run, CPU0 will already be marked as
possible.  Therefore, the above code and arm_dt_cpu_map_valid() is not
required.
