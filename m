From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 May 2014 15:07:03 -0400
Subject: [PATCHv2] ARM: mvebu: use hardware I/O coherency also for PCI
 devices
In-Reply-To: <1399997070-11434-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399997070-11434-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140516190703.GM27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 06:04:30PM +0200, Thomas Petazzoni wrote:
> Since the beginning of the introduction of hardware I/O coherency
> support for Armada 370 and Armada XP, the special DMA operations
> should have applied to all DMA capable devices. Unfortunately, while
> the original code properly took into account platform devices, it
> didn't take into account PCI devices, which can also be DMA masters.
> 
> This commit fixes that by registering a bus notifier on pci_bus_type,
> to register our custom DMA operations, like is already done for
> platform devices. While doing this, we also rename
> mvebu_hwcc_platform_notifier() to mvebu_hwcc_notifier() and
> mvebu_hwcc_platform_nb to mvebu_hwcc_nb because they are no longer
> specific to platform devices.
> 
> Fixes: e60304f8cb7b ("arm: mvebu: Add hardware I/O Coherency support")
> Cc: <stable@vger.kernel.org> # v3.8+
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> Changes since v1:
>  * Fix stupid tab vs. space problem
> 
> Applies to mvebu/soc.
> 
> Whether this commit qualifies as stable material can be
> discussed. Technically, it was a mistake from the original I/O
> coherency implementation. But in practice, besides not using the I/O
> coherency, I don't think it's causing any specific problem other than
> DMA transactions on PCI devices triggering unneeded cache maintenance
> operations. So I'll leave it to the mvebu maintainers to decide
> whether this qualifies as stable material or not. I've included the
> relevant Fixes: and Cc: fields, but don't hesitate to rip them out if
> you don't think this should go to stable.
> ---
>  arch/arm/mach-mvebu/coherency.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Applied to mvebu/soc w/o the stable tags.

thx,

Jason.
