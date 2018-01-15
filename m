From: bp@alien8.de (Borislav Petkov)
Date: Tue, 16 Jan 2018 00:52:48 +0100
Subject: EDAC driver for ARMv8 L1/L2 cache
In-Reply-To: <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <20180112173802.kb32zrxc5uhsjlxk@lakrids.cambridge.arm.com>
 <VI1PR04MB20780EF853A0822A6EFCFE449A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180112180048.srniseo2ft7ytqve@lakrids.cambridge.arm.com>
 <VI1PR04MB2078FCB86150A2AABFE7AB439A170@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180113113156.nnmkuh25rilzwf4p@pd.tnic>
 <20180115142154.rj6cgnhlll7ivyew@lakrids.cambridge.arm.com>
 <20180115143249.tod4rqzn3udk6wmu@pd.tnic>
 <VI1PR04MB20786DE6AE24D4BB555E87C69AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <20180115232321.ojo3lfvces2q2qhm@pd.tnic>
 <VI1PR04MB207883AE86B7685B9D9DE3029AEB0@VI1PR04MB2078.eurprd04.prod.outlook.com>
Message-ID: <20180115235248.snzpl5cajfkudluw@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 11:28:14PM +0000, York Sun wrote:
> It is generic ARM64 thing. I believe only SError interrupt is available.

So if it is, then I'd suggest you hammer out a proper design with the
ARM folks.

> But SError can be caused by many reasons. For L1/L2 only uncorrectable
> errors trigger SError. My first step is to deal with correctable errors
> and to raise a flag somehow (Haven't think that through yet) when
> excessive errors are reported. Next step I will deal with the
> uncorrectable errors with interrupt.

You need to think of the use cases first and where it makes *sense* to
do recovery actions and what those actions will be. In general make the
system more resilient. Simply reporting some error numbers just for the
sake of it, doesn't mean a whole lot.

And once you have those, figure out what kind of error info you need
from the hardware in order to do those recovery actions.

>From your other mail:
> I have different plan on the driver. Since I don't get interrupt on
> correctable errors, my thinking is to use dynamic polling interval. With
> more correctable errors, the polling interval is decreased to a
> threshold, then further action needs to be taken (at least I would raise
> an error message). The idea is uncorrectable error proceeds from
> increasing correctable errors.

Is that always the case? I wouldn't be so sure.

> I would use per CPU data structure so we know which core has
> increasing errors. For embedded system, we may shutdown the core(s)
> with error to protect the system from critical failure. Similarly but
> differently, L2 cache is shared on the same cluster.

All this implies is that the cores are the most prone to generate
errors. I wouldn't be so sure. This is almost never the case on x86, for
example. The main "fun" there is DRAM. The cores almost never.

So think about first which hw component really needs RAS protection and
why exactly.

> We may have to shutdown the whole cluster if we have excessive
> correctable errors.

Why?

Correctable errors are normally corrected by hardware and they don't
have any effect on system state. Why shut down?

You probably want to slow down operation or do some other actions to
improve the situation first. Immediately shutting down is not really
RAS.

> For server, it may simply shutdown.

This is not really gracefully handling of errors.

You need to gradually diminish system performance to alleviate error
levels and if that doesn't work, then warn and shutdown.

> Of course the decision is not made by the driver, but by RAS or other
> monitoring policy.

Just read up on RAS strategies and policies to get a better idea what
others are doing before implementing something which might not bring a
whole lot.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
