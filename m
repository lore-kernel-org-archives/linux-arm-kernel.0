From: jouko.haapaluoma@wapice.com (Jouko Haapaluoma)
Date: Mon, 27 Jan 2014 12:58:35 +0000
Subject: at_hdmac does not release lock before the callback - deadlock
Message-ID: <C9F8415089354E4FB76F4548B3515AF484286F61@edb1.wapice.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

It seems that the at_hdmac driver keeps the atchan->lock even when the device driver callback is called.
This will cause a deadlock in those cases when the device driver calls certain DMA Engine methods
from the callback function.

The DMA Engine documentation (https://www.kernel.org/doc/Documentation/dmaengine.txt) states:
" 
Although the async_tx API specifies that completion callback
routines cannot submit any new operations, this is not the
case for slave/cyclic DMA.

For slave DMA, the subsequent transaction may not be available
for submission prior to callback function being invoked, so
slave DMA callbacks are permitted to prepare and submit a new
transaction.

For cyclic DMA, a callback function may wish to terminate the
DMA via dmaengine_terminate_all().

Therefore, it is important that DMA engine drivers drop any
locks before calling the callback function which may cause a
deadlock.
"

According to the documentation it seems that the at_hdmac driver violates the DMA Engine API because
locking is not released before entering the callback function.

One possible deadlock situation:

atc_tasklet()
spin_lock_irqsave(&atchan->lock)
atc_handle_cyclic()
callback()
dmaengine_terminate_all()
atc_control()
spin_lock_irqsave(&atchan->lock) 


BR,
Jouko Haapaluoma
