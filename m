From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 12 Feb 2016 19:37:38 +0100
Subject: [PATCH V7 4/6] i2c: qup: Add bam dma capabilities
In-Reply-To: <1453197766-18976-5-git-send-email-sricharan@codeaurora.org>
References: <1453197766-18976-1-git-send-email-sricharan@codeaurora.org>
 <1453197766-18976-5-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160212183737.GA1520@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 03:32:44PM +0530, Sricharan R wrote:
> QUP cores can be attached to a BAM module, which acts as
> a dma engine for the QUP core. When DMA with BAM is enabled,
> the BAM consumer pipe transmitted data is written to the
> output FIFO and the BAM producer pipe received data is read
> from the input FIFO.
> 
> With BAM capabilities, qup-i2c core can transfer more than
> 256 bytes, without a 'stop' which is not possible otherwise.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> Tested-by: Archit Taneja <architt@codeaurora.org>
> Tested-by: Telkar Nagender <ntelkar@codeaurora.org>

My code checkers found some issues:

    SPARSE
drivers/i2c/busses/i2c-qup.c:555:6: warning: symbol 'qup_sg_set_buf' was not declared. Should it be static?
drivers/i2c/busses/i2c-qup.c:1243:50: warning: dubious: !x & !y
    SMATCH
drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s = sg_next()
drivers/i2c/busses/i2c-qup.c:165 qup_sg_set_buf warn: unused return: s = sg_next()
drivers/i2c/busses/i2c-qup.c:1243 qup_i2c_xfer_v2() warn: add some parenthesis here?
    CPPCHECK
drivers/i2c/busses/i2c-qup.c:1243: style: Boolean result is used in bitwise operation. Clarify expression with parentheses.
    SPATCH
drivers/i2c/busses/i2c-qup.c:1380:2-13: WARNING: Assignment of bool to 0/1
drivers/i2c/busses/i2c-qup.c:1481:1-13: WARNING: Assignment of bool to 0/1
  CC      drivers/i2c/busses/i2c-qup.o
drivers/i2c/busses/i2c-qup.c:555:6: warning: no previous prototype for 'qup_sg_set_buf' [-Wmissing-prototypes]
 void qup_sg_set_buf(struct scatterlist *sg, void *buf, struct qup_i2c_tag *tg,

Can you fix them and resend??

Thanks,

   Wolfram
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160212/6b685d54/attachment-0001.sig>
