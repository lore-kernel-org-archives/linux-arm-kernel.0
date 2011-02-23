From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Feb 2011 11:26:33 -0800
Subject: [PATCH v2] ARM: Tegra: Make tegra_dma_init a postcore_initcall
In-Reply-To: <1298482889-21841-1-git-send-email-swarren@nvidia.com>
References: <1298482889-21841-1-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTikan_3pEcVO082+-fh7BdZK2PzFB5M=bAAE_iQ8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 9:41 AM, Stephen Warren <swarren@nvidia.com> wrote:
> The following commit makes the Tegra APB DMA engine fail to initialize
> correctly: 0cf6230af909a86f81907455eca2a5c9b8f68fe6
> ARM: tegra: Move tegra_common_init to tegra_init_early
>
> The reason is that tegra_init_early_ calls tegra_dma_init which calls
> request_threaded_irq, which fails since the IRQ hasn't yet been marked
> valid; that only happens in tegra_init_irq, which gets called after
> tegra_init_early.
>
> This used to work OK, since tegra_init_early was tegra_common_init, which
> got called after tegra_init_irq, basically from the beginning of
> tegra_harmony_init.
>
> Solve this by converting tegra_dma_init to a postcore_initcall. This makes
> it execute late enough that IRQs are marked valid, and avoids having to
> add it back to every machine's init function.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>
