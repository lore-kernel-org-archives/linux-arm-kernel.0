From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 28 Oct 2018 22:08:00 +0000
Subject: [PATCH 2/3] i2c: uniphier-f: fix occasional timeout error
In-Reply-To: <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
References: <1539658909-26691-1-git-send-email-yamada.masahiro@socionext.com>
 <1539658909-26691-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181028220759.GC1882@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:01:48PM +0900, Masahiro Yamada wrote:
> Currently, a timeout error could happen at a repeated START condition.
> 
> For a (non-repeated) START condition, the controller starts sending
> data when the UNIPHIER_FI2C_CR_STA bit is set. However, for a repeated
> START condition, the hardware starts running when the slave address is
> written to the TX FIFO - the write to the UNIPHIER_FI2C_CR register is
> actually unneeded.
> 
> Because the hardware is already running before the IRQ is enabled for
> a repeated START, the driver may miss the IRQ event. In most cases,
> this problem does not show up since modern CPUs are much faster than
> the I2C transfer. However, it is still possible that a context switch
> happens after the controller starts, but before the IRQ register is
> set up.
> 
> To fix this,
> 
>  - Do not write UNIPHIER_FI2C_CR for repeated START conditions.
> 
>  - Enable IRQ *before* writing the slave address to the TX FIFO.
> 
>  - Disable IRQ for the current CPU while queuing up the TX FIFO;
>    If the CPU is interrupted by some task, the interrupt handler
>    might be invoked due to the empty TX FIFO before completing the
>    setup.
> 
> Fixes: 6a62974b667f ("i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181028/a3d51d26/attachment.sig>
