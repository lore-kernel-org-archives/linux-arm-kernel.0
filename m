From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 10 Aug 2012 18:43:56 +0100
Subject: Why the region area don't decrease 1 in function
 sanity_check_meminfo?
In-Reply-To: <20120810153705.GZ18957@n2100.arm.linux.org.uk>
References: <CAKvkGKeqzAiqRAj+H+E-eoN9SOOMP-aMhUJYmUb0UK4ei=jouA@mail.gmail.com>
 <5025253D.3010007@arm.com> <20120810153705.GZ18957@n2100.arm.linux.org.uk>
Message-ID: <5025485C.80407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 10/08/12 16:37, Russell King - ARM Linux wrote:

>> With !HIGHMEM, sanity_check_meminfo checks for banks that completely or
>> partially overlap the vmalloc region. The check for partial overlap checks
>> __va(bank->start + bank->size) > vmalloc_min, but the last address of the
>> bank is (bank->start + bank->size -1).

> 
> Erm.
> 
> Let's say you have a bank at 0x80000000, which maps to 0xc0000000 virtual.
> This is 512MB in size (so it's last byte address is 0x9fffffff).  That
> places it at at 0xdfffffff.  Now, let's say vmalloc_min is 0xe0000000.
> 
> "bank->start + bank->size" would be 0xa0000000, right ?
> 
> So, "__va(bank->start + bank->size)" would be 0xe0000000.


Yep, except in our (hypothetical?) case below...
>

> And "0xe0000000 > vmalloc_min" would be false.
> 


Yup... My commit message is wrong. Sorry. The linear case is fine...

>> However, theoretically, if using using SPARSEMEM in a situation where the
>> physical to virtual address conversion is not monotonic increasing, the
>> incorrect test could result in a bank not being truncated when it should be.
> 
> Right, so what you're actually talking about is a non-linear translation
> by __va() and friends.  In that case, what you actually need is:
> 
> 	(__va(bank->start + bank->size - 1) + 1) > vmalloc_min
> or
> 	__va(bank->start + bank->size - 1) >= vmalloc_min
> 
> and not
> 
> 	__va(bank->start + bank->size - 1) > vmalloc_min
> 


Agreed. I prefer the second form, and there seems to be a precedent for
">=" further up in sanity_check_meminfo, too.

If you think it is worth fixing for this case, I'll make the fixes,
ensure the commit message is !wrong and submit this to the patch-system.

Jonny
