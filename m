From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:19:01 +0100
Subject: [PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in
 TXFIFO
In-Reply-To: <20181010170936.316862-12-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-12-lkundrak@v3.sk>
Message-ID: <20181104121901.GW23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:36, Lubomir Rintel wrote:
> There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
> super-secret and the method described in Armada 16x manual won't work:
> 
>   "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset or
>   disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> field
>   in the SSP Control Register 0)."
> 
>   # devmem 0xd4037008           # read SSSR
>   0x0000F204
>   # devmem 0xd4037000 32 0x80   # SSE off in SSCR0
>   # devmem 0xd4037000 32 0x87   # SSE on
>   # devmem 0xd4037008
>   0x0000F204
>          ^ TXFIFO level is still 2. Sigh.
> 
> The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
> basically throwaway bytes used in response to the messages from the EC.
> The OLPC kernel copes with this by power-cycling the hardware. Perhaps
> the firmware should do this instead.
> 
> Other than that, there's not much we can do other than complain loudly
> until the garbage gets drained and discard the actual data... For the
> OLPC EC this will work just fine and pushing more data to TXFIFO would
> break further transactions.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/0aad5bed/attachment.sig>
