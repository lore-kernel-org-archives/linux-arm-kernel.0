From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 16:32:55 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130913033008.GC3051@gmail.com>
References: <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk> <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk> <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk> <523186DF.4070203@freescale.com>
 <20130912102027.GF29403@sirena.org.uk> <20130913033008.GC3051@gmail.com>
Message-ID: <1378999975.4210.101.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 23:30 -0400, Huang Shijie wrote:
> 
> we can setup 16 valid instruction sequences at most,
> for example:
>      LUT0 - LUT3: for read status of NOR
>      LUT4 - LUT7: for write enable of NOR
>      ...........
> 
> The LUT index is 0 for read-status;
> the LUT index is 1 for write-enable.

So... you load LUT index 0 (buffer #0) with something which essentially
makes it send the byte 0x05, then read one byte back.

And you load LUT index 1 (buffer #1) with something which makes it send
the byte 0x06, and not read anything back.

And then if the transaction that you're asked to make by the client
*happens* to match those pre-loaded buffers, you trigger those
transactions. And if it doesn't, you fall over.

Have you ever considered just loading the buffer with the transaction
you're *asked* to make, and then triggering it? Without preconfiging
*anything* in the buffers at init time?

Use LUT index 0 for the first transaction you're asked to make,
*regardless* of what it is. Copy the bytes in from the request.

Use LUT index 1 for the *next* transaction, unless it's identical to the
first in which case you can re-use index 0.

etc.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/88a8a2ce/attachment-0001.bin>
