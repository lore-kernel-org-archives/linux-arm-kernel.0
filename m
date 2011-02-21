From: ccross@google.com (Colin Cross)
Date: Sun, 20 Feb 2011 20:09:46 -0800
Subject: [PATCH 2/4] ARM: tegra: Prevent requeuing in-progress DMA requests
In-Reply-To: <1298173137-9242-3-git-send-email-swarren@nvidia.com>
References: <1298173137-9242-1-git-send-email-swarren@nvidia.com>
	<1298173137-9242-3-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTinngEn5QV9CSYQq0mXVEHPRhAaXRumqgdPxGgmn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 19, 2011 at 7:38 PM, Stephen Warren <swarren@nvidia.com> wrote:
> If a request already in the queue is passed to tegra_dma_enqueue_req,
> tegra_dma_req.node->{next,prev} will end up pointing to itself instead
> of at tegra_dma_channel.list, which is the way a the end-of-list
> should be set up. When the DMA request completes and is list_del'd,
> the list head will still point at it, yet the node's next/prev will
> contain the list poison values. When the next DMA request completes,
> a kernel panic will occur when those poison values are dereferenced.
>
> This makes the DMA driver more robust in the face of buggy clients.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> ?arch/arm/mach-tegra/dma.c | ? ?8 ++++++++
> ?1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
> index 250bc7b..f3b869b 100644
> --- a/arch/arm/mach-tegra/dma.c
> +++ b/arch/arm/mach-tegra/dma.c
> @@ -311,6 +311,7 @@ int tegra_dma_enqueue_req(struct tegra_dma_channel *ch,
> ? ? ? ?struct tegra_dma_req *req)
> ?{
> ? ? ? ?unsigned long irq_flags;
> + ? ? ? struct tegra_dma_req *_req;
> ? ? ? ?int start_dma = 0;
>
> ? ? ? ?if (req->size > NV_DMA_MAX_TRASFER_SIZE ||
> @@ -321,6 +322,13 @@ int tegra_dma_enqueue_req(struct tegra_dma_channel *ch,
>
> ? ? ? ?spin_lock_irqsave(&ch->lock, irq_flags);
>
> + ? ? ? list_for_each_entry(_req, &ch->list, node) {
> + ? ? ? ? ? ? ? if (req == _req) {
> + ? ? ? ? ? ? ? ? ? ? ? spin_unlock_irqrestore(&ch->lock, irq_flags);
> + ? ? ? ? ? ? ? ? ? ? ? return -EEXIST;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> ? ? ? ?req->bytes_transferred = 0;
> ? ? ? ?req->status = 0;
> ? ? ? ?req->buffer_status = 0;
> --
> 1.7.1
>
>

Pushed to tegra for-next
