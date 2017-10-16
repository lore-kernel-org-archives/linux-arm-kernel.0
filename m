From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 16 Oct 2017 22:59:16 +0200
Subject: [PATCH 00/10] arm/arm64: KVM: limit icache invalidation to
 prefetch aborts
In-Reply-To: <20171009152032.27804-1-marc.zyngier@arm.com>
References: <20171009152032.27804-1-marc.zyngier@arm.com>
Message-ID: <20171016205916.GP1845@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 04:20:22PM +0100, Marc Zyngier wrote:
> It was recently reported that on a VM restore, we seem to spend a
> disproportionate amount of time invalidation the icache. This is
> partially due to some HW behaviour, but also because we're being a bit
> dumb and are invalidating the icache for every page we map at S2, even
> if that on a data access.
> 
> The slightly better way of doing this is to mark the pages XN at S2,
> and wait for the the guest to execute something in that page, at which
> point we perform the invalidation. As it is likely that there is a lot
> less instruction than data, we win (or so we hope).
> 
> We also take this opportunity to drop the extra dcache clean to the
> PoU which is pretty useless, as we already clean all the way to the
> PoC...
> 
> Running a bare metal test that touches 1GB of memory (using a 4kB
> stride) leads to the following results on Seattle:
> 
> 4.13:
> do_fault_read.bin:       0.565885992 seconds time elapsed
> do_fault_write.bin:       0.738296337 seconds time elapsed
> do_fault_read_write.bin:       1.241812231 seconds time elapsed
> 
> 4.14-rc3+patches:
> do_fault_read.bin:       0.244961803 seconds time elapsed
> do_fault_write.bin:       0.422740092 seconds time elapsed
> do_fault_read_write.bin:       0.643402470 seconds time elapsed
> 
> We're almost halving the time of something that more or less looks
> like a restore operation. Some larger systems will show much bigger
> benefits as they become less impacted by the icache invalidation
> (which is broadcast in the inner shareable domain).
> 
> I've also given it a test run on both Cubietruck and Jetson-TK1.
> 
> Tests are archived here:
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/kvm-ws-tests.git/
> 
> I'd value some additional test results on HW I don't have access to.
> 

What would also be interesting is some insight into how big the hit then
is on first execution, but that should in no way gate merging these
patches.

Thanks,
-Christoffer
