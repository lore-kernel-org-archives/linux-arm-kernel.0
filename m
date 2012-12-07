From: groeck-dsl@sbcglobal.net (Guenter Roeck)
Date: Fri, 7 Dec 2012 07:07:44 -0800
Subject: [RFC] gpiolib: introduce descriptor-based GPIO interface
In-Reply-To: <2562815.JQOcF2Dmj3@percival>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com>
 <1354779918-4028-2-git-send-email-acourbot@nvidia.com>
 <20121207024947.GA25121@roeck-us.net> <2562815.JQOcF2Dmj3@percival>
Message-ID: <20121207150744.GB28704@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 07, 2012 at 04:02:02PM +0900, Alex Courbot wrote:
> Hi Guenter,
> 
> On Friday 07 December 2012 10:49:47 Guenter Roeck wrote:
> > My own idea for a solution was to keep integer based handles, but replace
> > gpio_desc[] with a hash table. But ultimately I don't really care how
> > it is done.
> > 
> > Do you have a solution for gpiochip_find_base() in mind, and how to handle
> > reservations ? I had thought about using bit maps, but maybe there is
> > a better solution.
> 
> My plan so far is to use a sorted linked list of gpio_chips. Each chip 
> contains its base address and size, so this will make it possible to find 
> usable areas through a single parse. Current gpiochip_find_base() start from 

Excellent idea.

> ARCH_NR_GPIOS and look backwards in the integer space to find a free range, a 
> similar behavior can also be done if this is deemed better (GPIO numbers might 
> become high, but since we want to hide them this should not matter).
> 
You can not completely hide them, I would guess - you'd still want to export
them. Anyway, a simpler method would be to keep the list sorted in increasing
order and simply search for a large enough gap. If there is none, add the new
chip to the end of the list.

> The counterpart of the list is that fetching the descriptor corresponding to a 
> GPIO number is going to be linear instead of constant, but (1) the number of 
> gpio_chips on the system should never grow very high and (2) this is a good 
> incentive to use the descriptor-based API instead. :) Existing code could 
> easily be converted - once a GPIO is acquired, its number should be converted 
> immediatly to a descriptor and the gpiod_* functions used from them on. We can 
> probably write a sed or Coccinelle rule to do that through the whole kernel.
> 
Since the current approach loops through all gpio pins, it is still much better
than that - the complexity would be O(chips), not O(ngpios). As you said, there
won't be many chips, so that should scale for a long time.

> gpiochip_reserve() will require some more thinking using this model, but 
> something like a dummy chip can probably be introduced in the list. It will 
> need to be statically allocated however since memory allocation cannot be used 
> there.
> 
Introducing a dummy chip sounds like a good idea, and would have very low overhead.

Thanks,
Guenter
