From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 May 2015 17:22:47 +0100
Subject: [PATCH REPOST] serial/amba-pl011: Unconditionally poll for FIFO
 space before each TX char
In-Reply-To: <1432222669-20117-1-git-send-email-Dave.Martin@arm.com>
References: <1432222669-20117-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150522162247.GC3072@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, May 21, 2015 at 04:37:49PM +0100, Dave Martin wrote:
> Commit 734745caeb9f155ab58918834a8c70e83fa6afd3 serial/amba-pl011:
> (Activate TX IRQ passively) introduces a race which causes the driver
> sometimes to attempt to write a character to the TX FIFO when the FIFO
> is already full.
> 
> The PL011 does not guarantee its behaviour when the FIFO is overfilled.
> In practice, this can cause duplicate and/or dropped characters to be
> output on the wire.  The problem is common enough to be readily
> observable on the ARM Juno platform when the PL011 UART is used as
> the console and DMA is not in use.
> 
> This patch fixes this problem by always polling for space before each
> character is written to the FIFO.
> 
> This will be amended to a less brute-force approach in a later commit,
> but this patch should help ensure correct behaviour for now.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---

Do you know if this patch has been applied anywhere? Without it, poor
old systemd has an identity crisis when run under 4.1-rc4, alternating
between Scottish:

  [  OK  ] Stopped Regularr background proogram processing daemon.

and Old English:

  [  OK  ] Started Tell Pllymouth To Writee Out Runtime Data.
  Starting Copy rules geneerated while thee root was ro...

Will
