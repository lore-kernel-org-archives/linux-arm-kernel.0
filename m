From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 8 Jun 2013 18:07:36 -0300
Subject: [PATCH] ARM: dma: imx: Fix deadlock bug
In-Reply-To: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
References: <1370724988-16426-1-git-send-email-shc_work@mail.ru>
Message-ID: <CAOMZO5CWT+kyf_H-Ms4yZ0isdvEadpcw22FagAUBurc5XzWQRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On Sat, Jun 8, 2013 at 5:56 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> =================================
> [ INFO: inconsistent lock state ]
> 3.10.0-rc4-next-20130607-00006-gf5bbfe3-dirty #59 Not tainted
> ---------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> swapper/1 [HC0[0]:SC1[1]:HE1:SE0] takes:
>  (&(&imxdma->lock)->rlock){?.-...}, at: [<c0230200>] imxdma_tasklet+0x1c/0x138
> {IN-HARDIRQ-W} state was registered at:

I think the proper fix is to replace spin_lock/spin_unlock with
spin_lock_bh/spin_unlock_bh inside imxdma_tasklet.
