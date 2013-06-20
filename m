From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 20 Jun 2013 09:12:16 +0200
Subject: [RFC PATCH 13/50] ARM: at91: move at91rm9200 SoC to new at91
 clk implem
In-Reply-To: <20130620065258.9136.63631@quantum>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370617863-18410-1-git-send-email-b.brezillon@overkiz.com>
 <20130620065258.9136.63631@quantum>
Message-ID: <51C2AB50.6060104@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 20/06/2013 08:52, Mike Turquette wrote:
> Quoting Boris BREZILLON (2013-06-07 08:11:03)
>> +static struct clk_lookup pioA_clk_lookup[] = {
>> +       CLKDEV_INIT(NULL, "pioA_clk", NULL),
>> +       CLKDEV_INIT(NULL, "pioA", NULL),
>> +};
> It would be great to get rid of this clkdev data from the kernel as
> well. Have you looked into encoding the aliases into your DT bindings?
I already switched all dt boards to dt clk definition (see patch 36 to 50).
These definition are kept for all non-dt boards (see in 
arch/arm/mach-at91/board-xxx.c).
This will be cleaned as soon as all non-dt boards are moved to dt.
>
> Or have you looked into using of_clk_get?
If I remember correctly, the clk_get function first tries to get the clk 
from dt binding.
Then if it fails it uses the clk_lookup info. Am I right ?
If so, I don't need to use of_clk_get in drivers calling clk_get with a 
non NULL device
parameter.

The only place where I use of_clk_get is in init timer driver 
(at91sam926x_time.c).
I first try to retrieve the clk from dt, then if it fails (or if dt is 
not supported),
I use clk_get with a NULL device param, which will lead to clk_lookup 
search.


Tell me if I misunderstood the API.
>
> Regards,
> Mike

Best Regards,
Boris
