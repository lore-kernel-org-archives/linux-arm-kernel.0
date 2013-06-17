From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jun 2013 09:40:33 +0100
Subject: [RFC] arm: Remove sa1111 special case from
 arm_mm_memblock_reserve()
In-Reply-To: <1371429799-7128-1-git-send-email-grant.likely@linaro.org>
References: <1371429799-7128-1-git-send-email-grant.likely@linaro.org>
Message-ID: <20130617084033.GC2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 01:43:19AM +0100, Grant Likely wrote:
> The machine desc structure has a hook for doing machine-specific
> memblock code, but the SA1111 still has a platform-specific hook in the
> generic code. This patch merely moves the needed memblock_reserve()
> into a callback.

And... the reason I left this in generic code was to avoid the problem
which you've created by doing this change - there is at least one PXA
platform which also can have SA1111 enabled, and by omitting this
reservation, you will make that platform blow up at boot time because
we will try and free the same region of RAM twice into the buddy
allocator.

It was left there because one of these currently has to stay in generic
code, so they both need to in order to ensure that both are properly
paired.

What problem, other than a distaste for having such things in generic
code, are you having with this?
