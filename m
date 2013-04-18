From: olof@lixom.net (Olof Johansson)
Date: Thu, 18 Apr 2013 09:38:23 -0700
Subject: [PATCH] ARM: highbank: fix cache flush ordering for cpu hotplug
In-Reply-To: <1366213612-13526-1-git-send-email-robherring2@gmail.com>
References: <1366213612-13526-1-git-send-email-robherring2@gmail.com>
Message-ID: <20130418163823.GG7083@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 10:46:52AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> The L1 data cache flush needs to be after highbank_set_cpu_jump call which
> pollutes the cache with the l2x0_lock. This causes other cores to deadlock
> waiting for the l2x0_lock. Moving the flush of the entire data cache after
> highbank_set_cpu_jump fixes the problem. Use flush_cache_louis instead of
> flush_cache_all are that is sufficient to flush only the L1 data cache.
> flush_cache_louis did not exist when highbank_cpu_die was originally
> written.
> 
> With PL310 errata 769419 enabled, a wmb is inserted into idle which takes
> the l2x0_lock. This makes the problem much more easily hit and causes
> reset to hang.
> 
> Reported-by: Paolo Pisati <p.pisati@gmail.com>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Olof, Arnd,
> 
> If you have any more 3.9 fixes, please send this in. Otherwise, it can
> wait for 3.10 and mark for stable.

Applied to fixes.


-Olof
