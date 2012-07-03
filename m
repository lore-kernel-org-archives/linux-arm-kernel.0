From: robherring2@gmail.com (Rob Herring)
Date: Mon, 02 Jul 2012 21:37:16 -0500
Subject: [PATCH v3 0/4] DT clock bindings
In-Reply-To: <CAJOA=zNFZyOXrv8cpJJYhSyR6kvHr3awDvCwR689XyOKWYCMig@mail.gmail.com>
References: <1339512111-11172-1-git-send-email-robherring2@gmail.com>
 <87bokd15x7.fsf@octavius.laptop.org> <4FE33723.3040403@gmail.com>
 <20120621175443.GL4402@gmail.com> <4FEB0273.9050707@gmail.com>
 <CAJOA=zNFZyOXrv8cpJJYhSyR6kvHr3awDvCwR689XyOKWYCMig@mail.gmail.com>
Message-ID: <4FF25ADC.8040007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

On 07/02/2012 08:30 PM, Turquette, Mike wrote:
> On Wed, Jun 27, 2012 at 5:54 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 06/21/2012 12:54 PM, Mike Turquette wrote:
>>> On 20120621-10:00, Rob Herring wrote:
>>>> On 06/21/2012 02:27 AM, Chris Ball wrote:
>>>>>
>>>>> 2) Use alloc_bootmem() instead of kzalloc() in of_clk_add_provider(),
>>>>>    because we need to set up clocks during .init_early on ARM (which
>>>>>    happens pre-slab) so that they are available for platform init.
>>>>
>>>> This depends on 1 as the common clock code would have the same issue.
>>>> Generally, the first place clocks are needed is the timer init. At that
>>>> point, you can call kzalloc. This is where all the clock init used to be
>>>> done until init_early was added and some platforms have moved their
>>>> clock init. I don't think there was really ever much reason to move it
>>>> other than to make the timer init function only deal with timer setup.
>>>>
>>>
>>> Hi Rob,
>>>
>>> Just FYI I've been looking at using alloc_bootmem in the common clk code
>>> as a way to get rid of the static initialization stuff (which only
>>> existed due to very early initialization of timers).
>>
>> The slab is up at the time timers are initialized. The only real problem
>> is mixing clock init into the timer init functions and clk init in
>> init_early is cleaner in that regard.
>>
> 
> Hi Rob,
> 
> I'm afraid I don't follow you when you say "slab is up at the time
> timers are initialized".  On some platforms I believe that timer
> initialization takes place before slab is ready (.early_init).

Timers are not initialized in the .timer init hook? The clock init is
definitely in init_early in some cases, but I don't think the actual
timer init can be.

>>> The suggested change above to of_clk_add_provider would jive well with
>>> my change to the common clk code.
>>
>> Are you planning this for 3.6? If not, then this can be addressed at the
>> time the clk framework supports bootmem.
>>
>> I'm not so sure more users of bootmem are desired. There seems to be
>> some effort/desire to remove it:
>>
>> http://lists.linux-foundation.org/pipermail/ksummit-2012-discuss/2012-June/000562.html
>> https://lkml.org/lkml/2012/3/13/586
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/074886.html
> 
> So after looking at those mails it seems using memblock_alloc would be
> a better alternative.  Did I get that right?

Seems so, but my view is avoiding it altogether is the right way to me
just based on how few users there are of either within drivers/.

Anyway, this is all really besides the point for this series. If and
when the clock framework supports bootmem or memblock, then the DT clk
code can easily be adapted as part of that. It's just a matter of timing
and if you're not planning bootmem/memblock for 3.6 we can add this later.

Rob

> 
> Thanks,
> Mike
> 
>>
>> Rob
