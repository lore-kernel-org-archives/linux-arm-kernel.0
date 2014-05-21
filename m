From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 21 May 2014 18:20:05 +0200
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <035001cf74f8$0aabdae0$200390a0$@samsung.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
 <53753443.8010303@gmail.com>
 <CAD=FV=V8UZoeOqEwfx_E015pLM+amTt51LrUa+dk7mTdn=vKgA@mail.gmail.com>
 <53753C17.1090002@gmail.com>
 <CAD=FV=WGa7j_As_NpySxU7OEd_SzuGWK6oxU6UeiJ-4HsoWvvg@mail.gmail.com>
 <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
 <CAASgrz2Nr69tpfC8ka9gbs2OvjLEGsvgAj4vBCFxhsamuFum7w@mail.gmail.com>
 <53754CE2.3000905@gmail.com>
 <CAD=FV=UMoL7i9rg_QtBAqPwisSQyRqRmk8wQhneMXAiLBjTT1A@mail.gmail.com>
 <CAPz6YkU8GDrLj8UkqEQXxxqxWF5_p427wKSDgAp+QPR7WE7Ujg@mail.gmail.com>
 <CAJFHJrrb2XFDZqJh4OuLdFP=J0aR4pGe-WLWKZ7ZpMfUSPGd4Q@mail.gmail.com>
 <5376A726.4000106@samsung.com>
 <CAD=FV=VXSP1TM9qY8PxFuQ+Tq2Ju57VdpzpwsHXqHshQm_havQ@mail.gmail.com>
 <035001cf74f8$0aabdae0$200390a0$@samsung.com>
Message-ID: <537CD235.2020304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.05.2014 15:24, Kukjin Kim wrote:
> Doug Anderson wrote:
>> 
>> Kukjin,
>> 
> Hi Doug,
> 
>> On Fri, May 16, 2014 at 5:02 PM, Kukjin Kim <kgene.kim@samsung.com>
>> wrote:
>>> On 05/17/14 07:56, Chirantan Ekbote wrote:
>>>>>>> 
>>>>>>> Anyway, I'm by no means opposed to switching to arch
>>>>>>> timers. They provide a well designed, generic interface
>>>>>>> and drivers shared by multiple platforms, which means
>>>>>>> more code sharing and possibly more eyes looking at the
>>>>>>> code, which is always good. However if they don't 
>>>>>>> support low power states correctly, we can't just remove
>>>>>>> MCT.
>>>>>> 
>>>>>> 
>>>>>> I think low power states aren't in mainline (right?).
>>>>>> 
>>>>>> One solution that might work could be to leave the device
>>>>>> tree entry alone but change the MCT init code to simply act
>>>>>> as a no-op if it sees an arch timer is in the device tree
>>>>>> and enabled.  Then when/if someone got the low power states
>>>>>> enabled we could just change source code rather than dts
>>>>>> files.
>>>>>> 
>>>> 
>>>> Doug and I were talking about this and we think we may have a
>>>> way to have the mct and arch timers co-exist.  The main issue
>>>> is that the mct (and therefore arch timer) gets cleared once
>>>> during boot and every time we do a suspend / resume.  This
>>>> happens in exynos4_mct_frc_start() but it's not immediately
>>>> clear to us why the counter needs to be reset at all.  If we
>>>> remove the lines that clear the counter then there is no longer
>>>> an issue with having both the mct and the arch timers on at the
>>>> same time.
>>>> 
>>>> Alternately, if there is some code that depends on the mct
>>>> being reset we could store an offset instead of clearing the
>>>> counter and then subtract that offset every time something
>>>> reads it.  Doug has a patch that does this at 
>>>> https://chromium-review.googlesource.com/#/c/200298/.
>>>> Effectively the visible behavior will not change.  Would either
>>>> of these options work?
>>>> 
>>> Hi all,
>>> 
>>> Even though I've heard something about the behavior of mct and
>>> arch timer...but I couldn't finish the talk to h/w guys yet. I
>>> need to talk
>> again
>>> in next week then I could provide some useful information. Sorry
>>> for late and can you please wait a minute before deciding
>>> whatever.
>> 
>> I think we could wait a few days.  Note however, that Chirantan's 
>> latest proposal keeps all existing functionality (can use both MCT
>> and arch timers).  It merely removes the unnecessary bit of the MCT
>> init code setting the timer.  No functionality is affected by
>> that.
>> 
> Let me explain the behavior of MCT and arch timer.
> 
> Basically the two blocks are connected and the arch timer uses the
> count value from MCT for reference on exynos5250 so following in this
> mail thread is expected and it's true.

To clarify, is this true regarding only the free running counter or also
global interrupt timers and local interrupt timers?

> 
> * If you read the MCT and the arch timer, they give the same value.
> 
> And as you know, usually the access to arch timer is faster than MCT
> because of APB bus access...but using MCT has some benefits sometimes
> it depends on use case of power management though.

It would be nice to have a clear list of advantages of MCT, as at the
moment in this thread we had only the advantages of arch timer presented.

> BTW, since
> exynos5260, exynos5420 and exynos5800 doesn't support arch timer, we
> have been using MCT on exynos5 SoCs.

Hmm, I thought arch timer was a core feature of ARM Cortex A15 (and A7)
cores. Also you mention Exynos5420, while Chirantan's patch removing MCT
node from exynos5420.dtsi, would suggest that it worked for him fine. (I
assume it was tested.)

Best regards,
Tomasz
