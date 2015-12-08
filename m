From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Tue, 8 Dec 2015 08:53:53 -0800
Subject: [PATCH] soc: TI knav_qmss: fix dma_addr_t printing
In-Reply-To: <2560281.KhcNzi0XgD@wuerfel>
References: <2560281.KhcNzi0XgD@wuerfel>
Message-ID: <56670B21.5060209@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/8/2015 7:30 AM, Arnd Bergmann wrote:
> The knav_qmss driver is currently broken when CONFIG_LPAE is
> set, which is a bit surprising because I'd expect that any serious
> users of this platforms would have more than 2GB of RAM and require
> LPAE.
>
Well it has been working with LPAE enable always. The production
systems do but IIRC, some of the Eval board were still build with
just 2 GB memory.

> The compiler clearly warns about an incorrect use of dma_addr_t
> in the debug kernel messages:
>
> ti/knav_qmss_queue.c: In function 'knav_queue_setup_region':
> ti/knav_qmss_queue.c:1025:117: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> ti/knav_qmss_queue.c:1025:117: warning: format '%x' expects argument of type 'unsigned int', but argument 10 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
> ti/knav_qmss_queue.c: In function 'knav_queue_setup_link_ram':
> ti/knav_qmss_queue.c:1175:118: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
>
%x should have been %llx or %pad as your patch does now.

> This patch changes all the debugging output to use the correct
> %pad format string that works with both 32-bit and 64-bit dma_addr_t.
> As the variable naming is somewhat confusing here, I also change
> all *_phys names to *_dma when they refer to bus addresses that
> are used for DMA rather than a physical memory address as seen from
> the CPU. This is particularly important on keystone, because the
> two things are not the same there.
>
Right. Rename sounds good.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Thanks for the patch Arnd !!

Wingman/Murali,
Can you guys please test this patch and update the thread ?
I will queue this up for next merge window.
