From: highguy@gmail.com (Stijn Devriendt)
Date: Mon, 28 Jan 2013 12:27:36 +0100
Subject: [PATCH 6/6 v14] gpio: Add block gpio to several gpio drivers
In-Reply-To: <5105303E.5050007@antcom.de>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
 <1358856404-8975-7-git-send-email-stigge@antcom.de>
 <CAOY=C6H5xETt5UNXUfRkGW9q+bj0y2R3sXNvW87XXvQcYoL_-g@mail.gmail.com>
 <510126E7.5090802@antcom.de>
 <CAOY=C6F0ExS1gtmA=4QMzXUMRjAH5o7K9KDwTjdU-dYHA1fF=g@mail.gmail.com>
 <5105303E.5050007@antcom.de>
Message-ID: <CAOY=C6E-SXM-FL+Y7zrmidHG4+6pgCnZ4APcn8kYj5TnAaqVAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 2:48 PM, Roland Stigge <stigge@antcom.de> wrote:
> On 27/01/13 13:18, Stijn Devriendt wrote:
>>>> In my patch, I go out of the way of this kind of thing for a simple reason:
>>>> You may generate incorrect timing by doing this.
>>>
>>> You are right, certain things like synchronous on+off is not really
>>> possible.
>>>
>>> However, the above at least supports switching on simulaneously, and
>>> switching off simultaneously, which is an improvement in certain cases
>>> (and this certain hardware part doesn't support more). Maybe this
>>> certain driver behaviour can be documented even better than just in the
>>> driver source.
>>>
>>
>> The question here is: do you expect a user of the block-GPIO API to
>> go look into the base-driver code to see what will be supported?
>>
>> In my version of the patch this means:
>> - do not provide a single GPIO-block that crosses multiple base-drivers
>> - only provide gpio_block_get/set for GPIO drivers that support the complete
>> operation in a single go. (for example, in the above example there would be
>> no gpio_block_set() function)
>>
>> Perhaps the best approach is to make this explicit: Allow drivers to expose
>> their capabilities wrt timing and allow users to request strict-timing or
>> loose-timing. Loose-timing allows multiple gpio-drivers to be combined and
>> allows drivers with separate set/clear, hi/lo registers to be used.
>
> Interesting idea. However, it will be difficult to agree on good metrics
> here. As Mark Brown pointed out, even when hardware seems to support
> "simultaneousness" by registers, this doesn't actually mean that voltage
> levels are switched simultaneously wrt. sub-nanosecond timing.
>
> Also, it depends on further wiring between the actually supported GPIO
> hardware chip and the integrated device's I/O connections.
>
> Resulting in scenarios where GPIO chips (in terms of Linux drivers)
> without explicit I/O set registers (e.g., set/clear regs) could be "more
> simultaneous" than those having explicit I/O regs but hardware wiring
> leading to bad "simultaneousness" behaviour.
>
> Questionable if the kernel could address those details.
>

True, but does the kernel _need_ to address that? If this is fixed at the
kernel level, at least the kernel is not the cause of the effect.
Strict-timing could mean as much as "the kernel will do everything it can
(int this case impose limits) to make sure timings are strict - actual
results may
depend on your H/W".
It allows graceful degradation at the driver level (e.g. fallback to requesting
separate pins and toggling them in the right order - or calling the request
function again with loose-timing + dev_warn(... "things may break!") )

OTOH, is it worth it? There may be extra work involved when doing the latter.
Usage of block GPIO for things like emulating busses will need testing anyway.

>> Of course, for a first version you may as well leave it out. Perhaps the
>> use-cases for cross-GPIO-driver blocks are not worth the extra complexity
>> as of today?
>
> I actually started the current block gpio patches to support this kind
> of use case. :-)

Right, our use-cases were less advanced... ;)

Regards,
Stijn

>
> Roland
