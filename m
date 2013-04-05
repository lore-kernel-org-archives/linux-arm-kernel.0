From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 5 Apr 2013 13:08:02 +0200
Subject: [RFC PATCH v3 5/6] sched: pack the idle load balance
In-Reply-To: <1364308932.5053.46.camel@laptop>
References: <1363955155-18382-1-git-send-email-vincent.guittot@linaro.org>
 <1363955155-18382-6-git-send-email-vincent.guittot@linaro.org>
 <1364302359.5053.21.camel@laptop>
 <CAKfTPtD=_oS5gJeynUG=ft-Y1zEdxZEMhUPH9hSXx+H2pi4xgA@mail.gmail.com>
 <1364308932.5053.46.camel@laptop>
Message-ID: <CAKfTPtArtgkH5MU_xFAKjLDS-i32g2qQMdvyW=LLkG84tH8Hhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

After some toughts about your comments,I can update the buddy cpu
during ILB or periofdic LB to a new idle core and extend the packing
mechanism  Does this additional mechanism sound better for you ?

Vincent

On 26 March 2013 15:42, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, 2013-03-26 at 15:03 +0100, Vincent Guittot wrote:
>> > But ha! here's your NO_HZ link.. but does the above DTRT and ensure
>> > that the ILB is a little core when possible?
>>
>> The loop looks for an idle CPU as close as possible to the buddy CPU
>> and the buddy CPU is the 1st CPU has been chosen. So if your buddy is
>> a little and there is an idle little, the ILB will be this idle
>> little.
>
> Earlier you wrote:
>
>>       | Cluster 0   | Cluster 1   |
>>       | CPU0 | CPU1 | CPU2 | CPU3 |
>> -----------------------------------
>> buddy | CPU0 | CPU0 | CPU0 | CPU2 |
>
> So extrapolating that to a 4+4 big-little you'd get something like:
>
>       |   little  A9  ||   big A15     |
>       | 0 | 1 | 2 | 3 || 4 | 5 | 6 | 7 |
> ------+---+---+---+---++---+---+---+---+
> buddy | 0 | 0 | 0 | 0 || 0 | 4 | 4 | 4 |
>
> Right?
>
> So supposing the current ILB is 6, we'll only check 4, not 0-3, even
> though there might be a perfectly idle cpu in there.
>
> Also, your scheme fails to pack when cpus 0,4 are filled, even when
> there's idle cores around.
>
> If we'd use the ILB as packing cpu, we would simply select a next pack
> target once the old one fills up.
>
