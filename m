From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 29 Oct 2015 22:02:49 -0700
Subject: [PATCH v4 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1446171159.25711.36.camel@mhfsdcap03>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
 <1444729160-26433-3-git-send-email-bayi.cheng@mediatek.com>
 <20151016073959.GB28158@localhost>
 <1445178035.4832.23.camel@mhfsdcap03>
 <20151029015237.GE13239@google.com>
 <1446089334.25711.10.camel@mhfsdcap03>
 <1446126991.25711.23.camel@mhfsdcap03>
 <20151029160331.GA12954@localhost>
 <1446171159.25711.36.camel@mhfsdcap03>
Message-ID: <20151030050249.GB31863@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

On Fri, Oct 30, 2015 at 10:12:39AM +0800, bayi.cheng wrote:
> Hi Brian,  The current station is as follows.
> 
> 1: put 0x9F to MTK_NOR_PRGDATA5_REG, and five 0x0 to
> MTK_NOR_PRGDATA4_REG ~ MTK_NOR_PRGDATA0_REG, then set (1 + 5) * 8 
> to MTK_NOR_CNT_REG, for this way, we can read five IDs.
> 
> 2: put 0x9F to MTK_NOR_PRGDATA5_REG, and five 0x0 to
> MTK_NOR_PRGDATA4_REG ~ MTK_NOR_PRGDATA0_REG, then set (1 + 5 + 1) * 8
> to MTK_NOR_CNT_REG, for this way, we can read six IDs.
> In this case, nor flash IDs can be read from MTK_NOR_SHREG5_REG to
> MTK_NOR_SHREG0_REG . Thanks!

Thanks for the update. Glad to hear you can read more bytes there; the
extra number of Shift Registers *looked* to me like you should be able
to read even more than 5...

So in my other email, I showed you how I generalized the TX/RX function,
so it can handle most of both the write_reg() and read_reg() functions.
I'm not 100% sure now that it has all of the RX path correct; it worked
for the cases I could test, but it's confusing when reading the manual
to figure out which SHREG register I should start from. But anyway, I
think it should only take some small adjustments to my patch to make it
handle things properly.

I'd really appreciate it if you could incorporate my feedback and
review/improve the ..._do_tx_rx() function I wrote, to make sure it
handles reading any arbitrary number of bytes (at least up to 6). So,
you might, for example, run some tests where you have spi-nor.c call

	nor->read_reg(nor, SPINOR_OP_RDID, id, idlen)

with varying values for 'idlen', and make sure they all work properly.

Let me know if you have any questions about comments either here, or on
v5.

Regards,
Brian
