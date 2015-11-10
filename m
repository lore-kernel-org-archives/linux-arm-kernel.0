From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 9 Nov 2015 18:46:11 -0800
Subject: [PATCH v6 0/3] Mediatek SPI-NOR flash driver
In-Reply-To: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
References: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151110024611.GL12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

On Fri, Nov 06, 2015 at 11:48:06PM +0800, Bayi Cheng wrote:
> This series is based on v4.3-rc1 and l2-mtd.git [0] and erase_sector
> implementation patch [1]
> 
> [0]: git://git.infradead.org/l2-mtd.git
> [1]: http://lists.infradead.org/pipermail/linux-mtd/2015-October//062959.html
> 
> Change in v6:
> 1: delete mt8173_nor_do_rx
> 2: delete mt8173_nor_do_rx
> 3: add mt8173_nor_do_tx_rx for general usage
> 4: support nor flash with 6 IDs
> 5: delete mt8173_nor_erase_sector and use "nor->erase_opcode"
> 6: add mt8173_nor_set_addr to programming the address register
> 7: initialize the ppdata in mtk_nor_init

This series is looking a lot better to me. Thanks for incorporating (and
I hope fully reviewing and testing!) my suggested changes. I have a just
a few small comments that I might post to the driver patch, and if
that's all that's outstanding, I can fix them up myself before applying.

I believe you didn't completely answer all my questions from v5 though.
I'll repeat a bit here. Particularly, refer to [1].
I'll summarize; I understand that your common transmit/receive operation
works something like this:

Quoting from [1]:
> (1) total number of bits to send/receive goes in the COUNT register (so
>     far, as many as 7*8=56?)
> (2) opcode is written to PRGDATA5
> (3) other "transmit" data (like addresses), if any, are placed on PRGDATA4..0
> (4) command is sent (execute_cmd())
> (5) data is read back in SHREG{X..0}, if needed

My questions were:

(a) Why does mt8173_nor_set_read_mode() use PRGDATA3? That's not
    mentioned in the SoC manual, and it doesn't really match any of the
    steps above. Perhaps it's just a quirk of the controller's
    programming model?

(b) How do you determine X from step (5)?

Right now, your code seems to answer that X is "rxlen - 1". Correct?

If that's correct and if I put all of my understanding together
correctly, this means that you can actually shift out (in PRGDATA) up to
6 bytes (that is, 1 opcode and 5 tx bytes) and shift in (in SHREG) up to
7 bytes, except that the first byte is received during the opcode cycle,
and so it is discarded, and we effectively receive only 6 bytes.

Is that all correct? If so, then I think you still need to adjust the
boundary conditions in your do_tx_rx() function. (I'll comment on the
driver to point out the specifics.)

Regards,
Brian

[1] http://lists.infradead.org/pipermail/linux-mtd/2015-October/062951.html
