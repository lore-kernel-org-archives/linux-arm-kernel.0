From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 10:29:43 +0100
Subject: [PATCH] arch: arm: mach-rpc: ecard: Remove some unused functions
In-Reply-To: <1420134912-1742-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420134912-1742-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <1988901.x1xNE8yBZx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 January 2015 18:55:12 Rickard Strandqvist wrote:
> Removes some functions that are not used anywhere:
> ecard_disablefiq() ecard_enablefiq()
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Looks like a correct change to me, very nice!

However looking a bit further you will notice that after this is removed,
there is more that becomes unused:

> -void ecard_enablefiq(unsigned int fiqnr)
> -{
> -	ecard_t *ec = slot_to_ecard(fiqnr);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->claimed && ec->ops->fiqenable)
> -			ec->ops->fiqenable(ec, fiqnr);
> -		else
> -			printk(KERN_ERR "ecard: rejecting request to "
> -				"enable FIQs for %d\n", fiqnr);
> -	}
> -}
> -
> -void ecard_disablefiq(unsigned int fiqnr)
> -{
> -	ecard_t *ec = slot_to_ecard(fiqnr);
> -
> -	if (ec) {
> -		if (!ec->ops)
> -			ec->ops = &ecard_default_ops;
> -
> -		if (ec->ops->fiqdisable)
> -			ec->ops->fiqdisable(ec, fiqnr);
> -	}
> -}

These are in fact the only references to the fiqenable/fiqdisable/fiqpending
callback pointers, so it would be helpful to remove them as well, along with
the stub implementation from 

Is cppcheck something you are working on yourself, or did you pick it up
from someone else? Is it possible to get cppcheck to also find those unused
callback pointers? I assume we have more of them in other code.

	Arnd
