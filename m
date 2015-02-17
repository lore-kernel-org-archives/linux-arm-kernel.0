From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 17 Feb 2015 10:52:39 +0100
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <87k2zn5c5v.fsf@free.fr>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <20150209005503.3fad39c7@bbrezillon> <871tlx7dgu.fsf@free.fr>
 <20150211163343.GH11169@kwain> <87k2zn5c5v.fsf@free.fr>
Message-ID: <20150217095239.GD4507@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert,

On Thu, Feb 12, 2015 at 05:26:20PM +0100, Robert Jarzmik wrote:
> Antoine Tenart <antoine.tenart@free-electrons.com> writes:
> 
> >> All these ifs per variant will add complexity to the current driver, won't they
> >> ?
> >
> > Given the current state of this driver I believe this would be a better
> > idea to first rework it to use the nand framework properly. Then it will
> > be possible to have a look on what we have, to decide whether or not a
> > mrvl-nand-lib is needed.
> 
> I don't fully agree to delay.

And sorry, but I don't think reworking the pxa3xx driver this way is a
good idea. As I was saying, I'd like to rework it and doing this would
be useless once the rework is done.

> You're taking code, making sometimes copy-paste, for the berlin specific
> functions, and I think you're taking the bugs as well, which duplicates the fix
> effort.
> 
> For example, in nand_cmdfunc_berlin():
> +	if (info->reg_ndcr & NDCR_DWIDTH_M)
> +		column /= 2;
> 
> This is I think a copy-paste from its twin nand_cmdfunc(). Now consider what
> happens if the command is _not_ a read command, but an ONFI READID command
> (ONFI being specified by column=0x20 if memory serves me well).

In the Berlin specific cmdfunc we have ~10 lines copied from the others
cmd functions. That's not much. The pxa3xx driver is already factorized
and not a lot of functions are SoC-specific, except the cmdfunc which is
not that long. So you would want me to move all the driver to
mrvl-nand-lib and have a berlin_nand.c file with less than 100 lines
(i.e only its cmdfunc)? Thant would introduce small specific probing
functions and driver definitions and increase the code size, wouldn't
it?

> This is the reason I don't really like this patch. And this is also the reason
> why I believe you're in a perfect timing to improve things, by grouping the
> common function, and keeping the bugs in only one place, not many.

Well, I think that would not be the refactoring needed for this driver.

I may have been missing something. If so, please explain me which
code part is not factorized (except for the first 10 lines of the
cmd functions, which I can factorize if you really want it) and how the
driver would benefit from this?

Thanks,

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
