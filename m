From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Oct 2017 14:57:36 +0200
Subject: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
In-Reply-To: <20171019133828.GC6615@lunn.ch> (Andrew Lunn's message of "Thu,
 19 Oct 2017 15:38:28 +0200")
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
 <20171019133828.GC6615@lunn.ch>
Message-ID: <87a80c4ukf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,
 
 On jeu., oct. 19 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Oct 19, 2017 at 03:10:03PM +0200, Gregory CLEMENT wrote:
>> From: Ken Ma <make@marvell.com>
>> 
>> Current edge both type gpio irqs which need to swap polarity in each
>> interrupt are not supported, this patch adds edge both type gpio irq
>> support.
>
> So is the assumption here that you can handle the interrupt and flip
> the edge, faster than it takes the signal to change?
>
> If the software is too slow, you loose the following edge? And you
> might loose the edge after that as well, since the software will at
> some point handle the interrupt and reconfigure the edge, potentially
> for the wrong edge?
>
> Or am i missing something which makes this race free?

To put more context, this patch is just the port of what is currently
done in gpio-mvebu.c.

I needed this support for the SD detect pin and didn't have any issue
because it was not an intensive use at all.

Going back to your concern, yes if the interrupt frequency is too high
we might loose 2 events. But the same things could happen with a single
edge, we can still miss an event.  But I agree that with the "both edge"
mode then we will loose 2 events instead of one.

It is the problem for the edge interrupt in general. So as soon as you
use edge interrupt you must be ready to loose some interrupt.

In the end I don't think it is a problem.

Gregory


>
>    Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
