From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 5 Nov 2014 06:21:48 +0100
Subject: net: fec: fix regression on i.MX28 introduced by rx_copybreak
 support
In-Reply-To: <20141104.112858.356827532569349127.davem@davemloft.net>
References: <20141030.121710.1524000348187962764.davem@davemloft.net>
 <20141031063210.69004315@ipc1.ka-ro>
 <20141104112912.2be8bf1a@ipc1.ka-ro>
 <20141104.112858.356827532569349127.davem@davemloft.net>
Message-ID: <20141105062148.2a997b95@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

David Miller wrote:
> From: Lothar Wa?mann <LW@KARO-electronics.de>
> Date: Tue, 4 Nov 2014 11:29:12 +0100
> 
> > Hi David,
> > 
> > Lothar Wa?mann wrote:
> >> David Miller wrote:
> >> > From: Lothar Wa?mann <LW@KARO-electronics.de>
> >> > Date: Thu, 30 Oct 2014 07:51:04 +0100
> >> > 
> >> > >> Also, I don't thnk your DIV_ROUND_UP() eliminate for the loop
> >> > >> in swap_buffer() is valid.  The whole point is that the current
> >> > >> code handles buffers which have a length which is not a multiple
> >> > >> of 4 properly, after your change it will no longer do so.
> >> > >>
> >> > > Do you really think so?
> >> > 
> >> > Yes, because you're rounding down so you'll miss the final
> >> > partial word (if any).
> >> >
> >> Nope. DIV_ROUND_UP() would give '1' as upper bound for lengths from 1 to
> >> 4, '2' for lengths from 5 to 8 and so on.
> >> 
> >> The loop with increment 4 and i < len does exactly the same.
> >> Try it for yourself, if you don't believe it.
> >> 
> >> 
> > Do you still think, the loop without DIV_ROUND_UP() is incorrect,
> > or can this patch be applied?
> 
> I haven't had the time to fully re-look into the details, I'm busy
> with many other things at the moment.
> 
> But looking at DIV_ROUND_UP() macro it rounds up.  It gives an
> upper bound of 4 for any value 1 to 4.  Unlike what you claim.
> 
You're missing the 'DIV' part of DIV_ROUND_UP().

> Because it goes "(n + (d - 1)) / d"
> 
> Which for 'd' of 4 gives:
> 
> 1 --> 4
> 2 --> 4
> 3 --> 4
> 4 --> 4
>
'1', not '4'.
The loop has to be done once for each (probably partial) WORD of input
data, not for each BYTE.

Without dividing and incrementing by four the loop
counter will be 0 for the first word which is less than any length > 0.
Thus the loop will be run once for any number of bytes from 1 thru 4.
If incremented by 4 after the first loop, it will be run again for any
length > 5 and so forth.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
