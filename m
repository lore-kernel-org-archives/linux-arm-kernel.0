From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 21 Jun 2012 21:18:44 +0900
Subject: [PATCH 02/02] clk: clk-of: Use alloc_bootmem() instead of
 kzalloc()
In-Reply-To: <87395p15or.fsf_-_@octavius.laptop.org>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org>
 <87395p15or.fsf_-_@octavius.laptop.org>
Message-ID: <20120621121843.GA20236@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 03:32:04AM -0400, Chris Ball wrote:
> When of_clk_add_provider() is used at boot time (during .init_early on
> ARM, in the motivating case for this patch), kzalloc() cannot be used
> because slab isn't up yet.
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>

I wouldn't use alloc_bootmem() unconditionally for this, as you have no
idea where other platforms may wire the call site up. slab is also
available a lot earlier now than it used to be, so many places that
required bootmem pages previously can get away with slab allocations now.

You could rework this as:

	if (slab_is_available())
		cp = kzalloc(...)
	else
		cp = alloc_bootmem(...)

and then it doesn't matter when and where it gets called.
