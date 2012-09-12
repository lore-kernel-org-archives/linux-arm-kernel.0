From: balbi@ti.com (Felipe Balbi)
Date: Wed, 12 Sep 2012 09:23:01 +0300
Subject: [PATCH v4 00/21] OMAP UART Patches
In-Reply-To: <alpine.DEB.2.00.1209112141220.9444@utopia.booyaka.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.00.1209062137000.11516@utopia.booyaka.com>
 <alpine.DEB.2.00.1209112141220.9444@utopia.booyaka.com>
Message-ID: <20120912062259.GC18563@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 11, 2012 at 10:02:48PM +0000, Paul Walmsley wrote:
> 
> Hi Felipe
> 
> Just tested these OMAP serial changes at commit 
> e36851d0fa94b0f7802b3cc80406dbd3ef4f2f16 ("serial: omap: fix compile 
> breakage").  There's good news and bad news...
> 
> The good news is that after applying this series, the 'OMAP4 UART garbage 
> on long transmit buffers when PM is enabled' bug:
> 
> http://www.pwsan.com/omap/testlogs/test_v3.6-rc5/20120908202511/pm/4430es2panda/4430es2panda_log.txt
> 
> ... goes away.  (Unclear if it's because the underlying bug was fixed, or 
> if unrelated changes are masking it.)  Not sure what caused the problem to 
> go away exactly, but it's one of the changes between d37c6ceb and bf63a08.  
> So that's good!

I'd point the finger at sticking to put_autosuspend() as that would give
HW enough time to actually unload all bytes from its FIFO through the
UART lines. can you check if forcing the autosuspend_delay to -1
triggers the issue again ? If it does, it's some help from autosuspend,
which would mean we still have the problem and needs to be properly
fixed.

> The bad news is that N800 no longer boots -- or the UART dies during 
> serial init:
> 
> http://www.pwsan.com/omap/testlogs/test_tty_next_e36851d0/20120910020323/boot/2420n800/2420n800_log.txt
> 
> The problem doesn't seem to affect the 2430SDP.
> 
> Could you put together a patch to fix N800?

I'll see what I can do. BTW, is that log with DEBUG_LL enabled ?

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/1161d8c5/attachment.sig>
