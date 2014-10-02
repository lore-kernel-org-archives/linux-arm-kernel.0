From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 02 Oct 2014 16:44:32 +0300
Subject: [Patch v3] spi: qup: Fix incorrect block transfers
In-Reply-To: <1412112088-25928-1-git-send-email-agross@codeaurora.org>
References: <1412112088-25928-1-git-send-email-agross@codeaurora.org>
Message-ID: <1412257472.1027.37.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andy,

I am trying to understand why we need extra functions for block 
read and write.

Essentially fifo and block read/write function are looking
the same for me. Except that block functions have one extra write
in QUP_OPERATIONAL register.

On Tue, 2014-09-30 at 16:21 -0500, Andy Gross wrote:
> This patch fixes a number of errors with the QUP block transfer mode.  Errors
> manifested themselves as input underruns, output overruns, and timed out
> transactions.
> 
> The block mode does not require the priming that occurs in FIFO mode.  At the
> moment that the QUP is placed into the RUN state, the QUP will immediately raise
> an interrupt if the request is a write.  Therefore, there is no need to prime
> the pump.

But does this hurt in some way? I mean fist FIFO fill happens when
controller is in PAUSED state. Once enabled it can start transfer 
immediately. 

> 
> In addition, the block transfers require that whole blocks of data are
> read/written at a time.  

Thats fine, but I can not see why this will not happen with existing
fill functions. Fifo's are drained until there is data and filled
until there is a space. And because we are not using pack/unpack mode, 
every SPI word occupy one cell in fifo (32 bits), this means that 
existing read/write functions are working in "block" mode.

> The last block of data that completes a transaction may
> contain less than a full blocks worth of data.
> 
> Each block of data results in an input/output service interrupt accompanied with
> a input/output block flag set.  Additional block reads/writes require clearing
> of the service flag.  It is ok to check for additional blocks of data in the
> ISR, but you have to ack every block you transfer.  Imbalanced acks result in
> early return from complete transactions with pending interrupts that still have
> to be ack'd.  The next transaction can be affected by these interrupts.
> Transactions are deemed complete when the MAX_INPUT or MAX_OUTPUT flag are set.

And this is the thing that can cause errors that you see, I suppose.
We are getting extra interrupts, which are not cleared, even if we have
drained fifo completely. 

Regards,
Ivan

P.S. They are still several coding style issues :-). The same as those that 
I have already pointed to you.
