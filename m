From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Sep 2013 13:00:11 -0300
Subject: [PATCH 0/5] Add Core Divider clock support for Armada 370/XP
In-Reply-To: <20130926174755.15a65f92@skate>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost>
 <5243E46B.2000406@free-electrons.com>
 <20130926152651.GC4583@localhost> <20130926174755.15a65f92@skate>
Message-ID: <20130926160010.GD4583@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 05:47:55PM +0200, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Thu, 26 Sep 2013 12:26:52 -0300, Ezequiel Garcia wrote:
> 
> > 3. We hack the NAND driver to consume the NAND ECC, but use the rate
> > as the half of it, and forget about the halved-rate NAND clock.
> > This seems certainly hacky.
> 
> Is this really hacky? Since we can't change the rate of one without
> changing the other, or gating the one without the other, we can also
> see those two clocks as being an internal business of the NAND hardware
> block. So instead of seeing things as:
> 
>                         -------------
>  NAND ECC clk    ---->  |           | 
>      ||                 |  NAND HW  |
>      ||                 |   block   |
>      \/                 |           |
>  NAND clk        ---->  |           |
>                         -------------
> 
> You can see things as follows:
> 
>                         -------------
>                         |           | 
>                         |  NAND HW  |
>  NAND clk        ---->  |   block   |
>                         |           |
>                         |           |
>                         -------------
> 
> and the ECC clock is actually some internal business of the NAND hw
> block, and therefore handled internally by the NAND driver, as your
> option (3) suggests.
> 
> Since the amount of details that we have about the exact hardware
> architecture are pretty scarce, I believe this is probably the easiest
> solution.
> 

Hm... could be. Considering the lack of hardware details (as you
point out) maybe this is indeed the best option.

And it has the cool advantage of simplfying the clock tree, which
is unnecessarily complex with the NAND ECC clock -> NAND clock layout.

On the other side, Emilio has just pointed out (in private) that there's
a flag "CLK_SET_RATE_PARENT" that is meant for these cases.

Anyway, I feel inclined to your suggestion and just forget about the NAND
ECC clock for good, which is only confusing.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
