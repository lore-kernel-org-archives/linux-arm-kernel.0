From: stigge@antcom.de (Roland Stigge)
Date: Tue, 16 Oct 2012 00:55:20 +0200
Subject: [PATCH RFC 1/6 v3] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <507C888C.7040903@gmail.com>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-2-git-send-email-stigge@antcom.de>
 <507B9D05.1000204@gmail.com> <507C45EF.7080203@antcom.de>
 <507C888C.7040903@gmail.com>
Message-ID: <507C9458.1080803@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 16/10/12 00:05, Ryan Mallon wrote:
>>> This looks broken. If gbc was re-alloced above (index < 0) then
>>> gbc->remap == NULL and this will oops?
>>
>> No, because I took care that even though index can be < 0, the resulting
>> pointer is never dereferenced for -1.
> 
> Ah, I see. I think its a bit non-obvious and flaky though, since it
> looks like you are both dereferencing a potentially NULL pointer, and
> indexing an array with -1.
> 
> Even changing it to this I think makes it a bit more clear:
> 
> 	if (gbc->remap == 0 ||
>             bit - i != gbc->remap[gbc->nremap - 1].offset)
> 		gbc->nremap++;
> 		gbc->remap = krealloc(...);
> 		...
> 
> If you want to keep your way, at the very least I think it deserves a
> comment, since it is easy to misread.

Yes, commenting it now.

Note that it's rather out-of-bounds than NULL pointer. (But with similar
results, though. ;-) )

>> For this, the current API is working fine, even enabling userland access
>> via sysfs.
> 
> Fair enough. I didn't see the first round of patches. You probably can
> still use for_each_set_bit though (maybe convert the mask to unsigned
> long first to match the bitops API):
> 
> 	for_each_set_bit(j, &gbc->mask, BITS_PER_LONG)
> 		...

Thanks for the hint! Useful.

Roland
