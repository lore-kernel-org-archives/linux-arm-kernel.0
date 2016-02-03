From: fu.wei@linaro.org (Fu Wei)
Date: Thu, 4 Feb 2016 02:06:02 +0800
Subject: [PATCH v10 5/5] Watchdog: ARM SBSA Generic Watchdog half timeout
 panic support
In-Reply-To: <56B23E99.1030604@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-6-git-send-email-fu.wei@linaro.org>
 <56B23883.7000501@codeaurora.org>
 <CADyBb7sxPg-QUjTbeHFtYkctKc_g7D8O=+jqbXN+DCCoCEnFqA@mail.gmail.com>
 <56B23E99.1030604@codeaurora.org>
Message-ID: <CADyBb7s4opxfPFuX=1-qEE6uhsaMXgofAJPbHUQHrng2AUwqNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timur

On 4 February 2016 at 01:53, Timur Tabi <timur@codeaurora.org> wrote:
> Fu Wei wrote:
>>
>> sorry, are you saying : using pre-timeout instead of this half timeout?
>>
>> But even we have pre-timeout support, pre-timeout  == timeout / 2, it
>> can not be configured without touch timeout.
>>
>> if you want pre-timeout  != timeout / 2, we have to modify WCV in the
>> interrupt routine.
>>   (because of the explicit watchdog refresh  mechanism)
>>
>> Could you let me know why we need pre-timeout  here ??:-)
>
>
> What I meant was that if we had full-blown pre-timeout support in the
> watchdog layer, then you could use that to implement the
> panic-on-half-timeout feature.
>
> When pre-timeout is implemented, will you modify the interrupt handler to
> use it?

Sorry I am little confused.

Actually I am taking your suggestion to avoid touching WCV in
interrupt routine.
So even we have pre-timeout support , it is useless for this
panic-on-half-timeout feature,
because pre-timeout  == timeout / 2 (always).

So maybe I misunderstand your suggestion,
could you let me know : why we want pre-timeout here?


>
>>> >belong upstream.  But like I said, it's just my opinion, and I won't
>>> >complain if I'm outvoted.
>>
>>   I think this debugging feature is the  purpose of the two-stage
>> watchdog, if I understand correctly
>
>
> Hmmm... that make sense.  I think maybe you should drop the Kconfig option,
> and just have "static bool panic_enabled = false;"  Also, then do this:
>
> if (panic_enabled) {
>         ret = devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
>                                pdev->name, gwdt);
>         if (ret) {
>                 dev_err(dev, "unable to request IRQ %d\n", irq);
>                 return ret;
>         }
> }

yes, agree

>
> That way, the interrupt handler is never registered if the command-line
> parameter is not specified.
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
