From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 15 Apr 2010 08:58:47 -0700
Subject: DMA Engine API performance issues
In-Reply-To: <j2i121039231004150213i76ecc96ahb5d9af96c46b27ae@mail.gmail.com>
References: <x2i121039231004132342sa230bfd4k832950fce534113f@mail.gmail.com>
	<i2ge9c3a7c21004141708y87d01ab6h94c653e4efa11b8d@mail.gmail.com>
	<j2i121039231004150213i76ecc96ahb5d9af96c46b27ae@mail.gmail.com>
Message-ID: <v2he9c3a7c21004150858t917f44d6q15b5eaa3247d6fff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 15, 2010 at 2:13 AM, melwyn lobo <linux.melwyn@gmail.com> wrote:
> Thanks so much for your explanation.
> OK..Looking at IPU implementation, irq handling is enrtirely in the
> interrupt routine, therefore no need for spin_lock_bh stuff.
> But for lower interrupt latency reasons we need to stick with the
> tasklet handling for processing interrupts.
>
> We were contemplating another solution for locking at our end for DMA
> implementation
> For locking
> if(irqs_disabled())
> ? ?spin_lock(&chan->lock);
> else
> ? ?spin_lock_bh(&chan->lock);
>
> for unlocking:
> if(irqs_disabled())
> ? ?spin_unlock(&chan->lock);
> else
> ? ?spin_unlock_bh(&chan->lock);
>
> Although this works ?fine, but will this be OK when we submit the driver.
>

This won't work and lockdep should complain about this situation.  The
minute you need to take the lock in the interrupt handler then all
other occurrences of the lock need to be promoted to _irq or
_irqsave() [1].

--
Dan

[1]: http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/c214.html
