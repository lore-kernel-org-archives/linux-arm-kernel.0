From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Feb 2017 12:11:54 +0100
Subject: [PATCH v8 3/3] dmaengine: pl330: Don't require irq-safe runtime PM
In-Reply-To: <20170213020340.GH2843@localhost>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142309eucas1p2b1277d96139eafc0d1dcc14145600476@eucas1p2.samsung.com>
 <1486650171-20598-4-git-send-email-m.szyprowski@samsung.com>
 <20170210045004.GN19244@localhost>
 <d299ae6c-78dc-9049-6bed-dc84fff17db3@samsung.com>
 <CAPDyKFqW2av1mjDvRP=R1my2kepeX69TS6cchzoHmwaoydT5Sg@mail.gmail.com>
 <20170213020340.GH2843@localhost>
Message-ID: <CAPDyKFpt9O8GM-7xeNJ8bF0JqUJ7nPaRmmC+aMVsdMH-yWBCNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> If we could set up the device link already at device initialization,
>> it should also be possible to avoid getting -EPROBE_DEFER for dma
>> client drivers when requesting their dma channels.
>
> Well if we defer then driver will regiser with dmaengine after it is
> probed, so a client will either get a channel or not. IOW we won't get
> -EPROBE_DEFER.

I didn't quite get this. What do you mean by "if we defer..."?

Defer into *what* and defer of *what*?  Could you please elaborate.

[...]

>>
>> Again, allow me to fill in. This issue exists for all ARM SoC which
>> has a dma controller residing in a PM domain. I think that is quite
>> many.
>>
>> Currently the only solution I have seen for this problem, but which I
>> really dislike. That is, each dma client driver requests/releases
>> their dma channel from their respective ->runtime_suspend|resume()
>> callbacks - then the dma driver can use the dma request/release hooks,
>> to do pm_runtime_get|put() which then becomes non-irq-safe.
>
> Yeah that is not the best way to do. But looking at it current one doesnt
> seem best fit either.
>
> So on seeing the device_link_add() I was thinking that this is some SoC
> dependent problem being solved whereas the problem statmement is non-atomic
> channel prepare.

You may be right.

Although, I don't know of other examples, besides the runtime PM use
case, where non-atomic channel prepare/unprepare would make sense. Do
you?

>
> As I said earlier, if we want to solve that problem a better idea is to
> actually split the prepare as we discussed in [1]
>
> This way we can get a non atomic descriptor allocate/prepare and release.
> Yes we need to redesign the APIs to solve this, but if you guys are up for
> it, I think we can do it and avoid any further round abouts :)

Adding/re-designing dma APIs is a viable option to solve the runtime PM case.

Changes would be needed for all related dma client drivers as well,
although if that's what we need to do - let's do it.

[...]

>>
>> So besides solving the irq-safe issue for dma driver, using the
>> device-links has additionally two advantages. I already mentioned the
>> -EPROBE_DEFER issue above.
>>
>> The second thing, is the runtime/system PM relations we get for free
>> by using the links. In other words, the dma driver/core don't need to
>> care about dealing with pm_runtime_get|put() as that would be managed
>> by the dma client driver.
>
> Yeah sorry took me a while to figure that out :), If we do a different API
> then dmaengine core can call pm_runtime_get|put() from non-atomic context.

Yes, it can and this works from runtime PM point of view. But the
following issues would remain unsolved.

1)
Dependencies between dma drivers and dma client drivers during system
PM. For example, a dma client driver needs the dma controller to be
operational (remain system resumed), until the dma client driver
itself becomes system suspended.

The *only* currently available solution for this, is to try to system
suspend the dma controller later than the dma client, via using the
*late or the *noirq system PM callbacks. This works for most cases,
but it becomes a problem when the dma client also needs to be system
suspended at the *late or the *noirq phase. Clearly this solution that
doesn't scale.

Using device links explicitly solves this problem as it allows to
specify this dependency between devices.

2)
We won't avoid dma clients from getting -EPROBE_DEFER when requesting
their dma channels in their ->probe() routines. This would be
possible, if we can set up the device links at device initialization.

>
> [1]: http://www.spinics.net/lists/dmaengine/msg11570.html
>
> --
> ~Vinod

Kind regards
Uffe
