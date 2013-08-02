From: joelf@ti.com (Joel Fernandes)
Date: Fri, 2 Aug 2013 18:00:08 -0500
Subject: [PATCH 4/9] dma: edma: Find missed events and issue them
In-Reply-To: <51FBF749.4010303@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
 <1375104595-16018-5-git-send-email-joelf@ti.com> <51F7659E.3040302@ti.com>
 <51F89763.1010102@ti.com> <51F8D667.2040406@ti.com> <51F9C793.2000001@ti.com>
 <51F9FC87.3020706@ti.com> <51FAC50A.2020507@ti.com> <51FBB371.6030901@ti.com>
 <51FBF749.4010303@ti.com>
Message-ID: <51FC39F8.5020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Considering you agree with my understanding of the approach you proposed,

I worked on some code to quickly try the different approach (ping-pong)
between sets, here is a hack patch:

https://github.com/joelagnel/linux-kernel/commits/dma/edma-no-sg-limits-interleaved

As I suspected it also has problems with missing interrupts, coming back
to my other point about getting errors if ISR doesn't get enough time to
setup for the next transfer. If you'd use < 5 MAX_NR slots you start
seeing EDMA errors.

For > 5 slots, I don't see errors, but there is stalling because of
missed interrupts.

I observe that for an SG-list of size 10, it takes atleast 7 ms before
the interrupt handlers (ISR) gets a chance to execute. This I feel is
quite long, what is your opinion about this?

Describing my approach here:

If MAX slots is 10 for example, we split it into 2 cyclically linked
sets of size 5 each. Interrupts are setup to trigger for every 5 PaRAM
set transfers. After the first 5 transfer, the ISR recycles them for the
next 5 entries in the SG-list. This happens in parallel/simultaneously
as the second set of 5 are being transferred.

Thanks,

-Joel

On 08/02/2013 01:15 PM, Joel Fernandes wrote:[..]
> Even in your diagrams you are actually showing such a cyclic link
>
>
>>>>>>
>>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>>  ^      ^      ^
>>>>>>  |      |      |
>>>>>> P0  -> P2  -> P1  -> NULL
>
> Comparing this..
>
>>>>>>
>>>>>> Now, on next interrupt, P2 gets copied and thus can get recycled.
>>>>>> Hardware state:
>>>>>>
>>>>>> SG2  -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>>  ^       ^
>>>>>>  |       |
>>>>>> P0,2    P1  -> NULL
>>>>>>  |       ^
>>>>>>  |       |
>>>>>>  ---------
>>>>>>
>>>>>> As part of TC completion interrupt handling:
>>>>>>
>>>>>> SG2 -> SG3 -> SG4 -> SG5 -> SG6 -> NULL
>>>>>>  ^      ^      ^
>>>>>>  |      |      |
>>>>>> P0  -> P1  -> P2  -> NULL
>
> .. with this. Notice that P2 -> P1 became P1 -> P2
>
> The next thing logical diagram would look like:
>
>>>>>>
>>>>>> Now, on next interrupt, P1 gets copied and thus can get recycled.
>>>>>> Hardware state:
>>>>>>
>>>>>> SG3  -> SG4 -> SG5 -> SG6 -> NULL
>>>>>>  ^       ^
>>>>>>  |       |
>>>>>> P0,1    P2  -> NULL
>>>>>>  |       ^
>>>>>>  |       |
>>>>>>  ---------
>>>>>>
>>>>>> As part of TC completion interrupt handling:
>>>>>>
>>>>>> SG3 -> SG5 -> SG6 -> SG6 -> NULL
>>>>>>  ^      ^      ^
>>>>>>  |      |      |
>>>>>> P0  -> P2  -> P1  -> NULL
>
>
> "P1 gets copied" happens only because of the cyclic link from P2 to P1,
> it wouldn't have happened if P2 was linked to Dummy as you described.
>
> Now coming to 2 linked sets vs 1, I meant the same thing that to give
> interrupt handler more time, we could have something like:
>
>>>>>> As part of TC completion interrupt handling:
>>>>>>
>>>>>> SG1 -> SG2 -> SG3 -> SG4 -> SG5 -> NULL
>>>>>>  ^      ^             ^
>>>>>>  |      |             |
>>>>>> P0  -> P1  -> P2  -> P3  -> P4  ->  Null
>
> So what I was describing as 2 sets of linked sets is P1 and P2 being 1
> set, and P3 and P4 being another set. We would then recycle a complete
> set at the same time. That way interrupt handler could do more at once
> and get more time to recycle. So we would setup TC interrupts only for
> P2 and P4 in the above diagrams.
>
> Thanks,
>
> -Joel
>
