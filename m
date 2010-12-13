From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Dec 2010 15:26:29 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <4D045692.4050607@codeaurora.org>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
	<4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
	<4CFDD297.4020600@codeaurora.org>
	<15d23d63900e4545a40555961c49c421.squirrel@codeaurora.org>
	<20101209103835.GA31465@n2100.arm.linux.org.uk>
	<4D017B45.4000805@codeaurora.org>
	<AANLkTi=PnnT8rVKMxK0tVTdKnKdcKf71fsX2o594Qx3e@mail.gmail.com>
	<4D045692.4050607@codeaurora.org>
Message-ID: <AANLkTimwqC6DqN8ft10EyRbPh9XvibN1fA-Cug4OdS5m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2010 04:58, Saravana Kannan <skannan@codeaurora.org> wrote:
> As you and James suggested, having the NS bit set by the secure world is
> definitely a solution that would work. But IMHO, the explicit cache
> flush/invalidate approach keeps the design simple and easy to maintain.

That is indeed an approach to the problem. But it depends on whether
we consider the DMA API appropriate for this. We can view the secure
world as a non-coherent agent accessing the memory and could try to
justify the use of the DMA API in Linux.

At some point we'll probably have platforms supporting cacheable DMA
(e.g. via the ARM coherency port) and the DMA API would no longer give
you what you need. But it is also possible that platforms with ACP
would only have 1 or 2 devices on that port (some HD LCD controller
for example) and the rest of devices non-coherent. In this case, we
need to have different DMA operations depending on the bus/device (via
get_dma_ops) and thus we can allow your scenario via dedicated DMA
ops.

-- 
Catalin
