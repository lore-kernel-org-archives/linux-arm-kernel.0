From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Tue, 7 Feb 2012 10:57:40 +0100
Subject: [PATCH] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F30ED55.6080908@linaro.org>
References: <1328270849-22324-1-git-send-email-daniel.lezcano@linaro.org>
 <4F2F9B2C.8030009@stericsson.com> <4F2FDF54.8080701@linaro.org>
 <4F30E324.4000005@stericsson.com> <4F30ED55.6080908@linaro.org>
Message-ID: <4F30F594.7090607@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 10:22 AM, Daniel Lezcano wrote:
> On 02/07/2012 09:39 AM, Rickard Andersson wrote:
>> On 02/06/2012 03:10 PM, Daniel Lezcano wrote:
>>> On 02/06/2012 10:19 AM, Rickard Andersson wrote:
>>>> Hi!
>>>>
>>>> Our comments:
>>> Thanks Rickard and Jonas for your comments.
>>>
>>>> - function names don't match commit comment disable/enable vs
>>>> recouple/decouple. Decouple is a better name than disable, because GIC
>>>> is not really disabled it is just disconnected.
>>> Ok, that makes sense.
>>>
>>>> - there is no reason to place these functions inside the db8500-prcmu.c
>>>> file. There is so much stuff in the PRCMU register base so we can not
>>>> have everything in one file. Why not have it as it is?
>>> Why spread the prcmu code when it is related to the prcmu ?
>>>
>>> Linus ? What do you think ?
>>>
>>>> - why the gic_mask function?
>>> Because the register has 31 bits reserved which could be used later
>>> without modifying this function.
>> This is will most likely not happen. If that happens we could add that
>> function then. We should remove it for now.
>>>> - The original code has been updated and now looks like this:
>>> That is the same code, except the while loop where, if this code
>>> assumption is correct, means we will do only one iteration in the loop.
>> Yes, but in theory you can be stuck forever in that loop, so please
>> remove the loop.
> Mmmh, can you elaborate please ? I think a comment and/or an error
> should be returned in this case, no ?
>
We do not need the loop. PRCMU FW does decouple of the GIC and if they 
for some reason does that at the same time (they should not) we will be 
stuck.
