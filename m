From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 21 Mar 2012 11:38:58 -0700
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <alpine.DEB.2.00.1203210130520.30543@utopia.booyaka.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <CAP245DXV5oE+-y+PQCcSM016h-J+UgTi1efmdrcyeQge4k1Cfw@mail.gmail.com>
 <201203161218.05125.arnd.bergmann@linaro.org>
 <201203162057.58706.arnd@arndb.de>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
 <20120316234706.GJ3852@pengutronix.de>
 <alpine.DEB.2.00.1203201611330.22974@utopia.booyaka.com>
 <alpine.LFD.2.02.1203202233340.24151@xanadu.home>
 <4F694A6A.4050706@codeaurora.org>
 <alpine.DEB.2.00.1203210130520.30543@utopia.booyaka.com>
Message-ID: <4F6A2042.9030302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 12:44 AM, Paul Walmsley wrote:
> Hello Saravana,
>
> On Tue, 20 Mar 2012, Saravana Kannan wrote:
>
>> To add a few more thoughts, while I agree with Paul that there is room for
>> improvement in the APIs, I think the difference in opinion comes when we ask
>> the question:
>>
>> "When we eventually refine the APIs in the future to be more expressive, do we
>> think that the current APIs can or cannot be made as wrappers around the new
>> more expressive APIs?"
>>
>> Absolutes are almost never right, so I can't give an absolute answer.
>> But I'm strongly leaning towards "we can" as the answer to the question.
>> That combined with the reasons Nicholas mentioned is why I think the
>> APIs should not be marked as experimental in anyway.
>
> The resistance to documenting that the clock interface is not
> well-defined, and that therefore it is likely to change, and that users
> should not expect it to be stable, is perplexing to me.
>
> Certainly a Kconfig help text change seems trivial enough.  But even the
> resistance to CONFIG_EXPERIMENTAL has been quite surprising to me, given
> that every single defconfig in arch/arm/defconfig sets it:
>
> $ find arch/arm/configs -type f  | wc -l
> 122
> $ fgrep -r CONFIG_EXPERIMENTAL=y arch/arm/configs | wc -l
> 122
> $
>
> (that includes iMX, by the way...)
>
> Certainly, neither Kconfig change is going to prevent us on OMAP from
> figuring out what else is needed to convert our platform to the common
> clock code.  And given the level of enthusiasm on the lists,

I think the enthusiasm we are seeing are from the clock driver 
developers. And for good reasons. Everyone is tired of having to write 
or rewrite their own implementation.

> I don't think
> it's going to prevent many of the other ARM platforms from experimenting
> with the conversion, either.
>
> So it would be interesting to know more about why you (or anyone else)
> perceive that the Kconfig changes would be harmful.

But the enthusiasm of the clock driver developers doesn't necessarily 
translate to users of the clock APIs (other driver devs). My worry with 
marking it as experimental in Kconfig and to a certain extent in the 
documentation is that it will discourage the driver devs from switching 
to the new APIs. If no one is using the new APIs, then platforms can't 
switch to the common clock framework either. If a lot of platform don't 
convert to the common clock framework, the effort to get it merged in 
now is not also very meaningful.

Also, at the rate at which we come to an agreement on new APIs, I think 
these new APIs should be considered quite stable :-) It's certainly 
better than what we have today. We should encourage driver devs to move 
to these new APIs and get the benefits while we go on another 2 yr cycle 
to agree on the next set of APIs improvements.

And as I said before, I think it's much less likely that we will break 
backward source compatibility when we do the next improvement. We could 
have mostly avoid this large scale change by calling the APIs 
prepare/unprepare/gate/ungate (or whatever) and make clk_enable/disable 
similar to clk_prepare_enable/clk_disable_unprepare(). That would have 
avoid a lot of drivers from having to mess with their clock calls. But 
we didn't think about that in the excitement for improved APIs. I think 
this will still be seared in our minds enough to make sure we don't 
repeat that in the future.

That covers all I have to say on this topic.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
