From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 29 Jul 2014 09:25:11 +0800
Subject: [PATCH v2 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <87k370o61q.fsf@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
 <87k376vadk.fsf@free.fr> <20140726004212.4791.52407@quantum>
 <87k370o61q.fsf@free.fr>
Message-ID: <CAN1soZyk_2pd97XU9_n-W1cGst0-rORNMNQpUB5gOVO2hqqSOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 26, 2014 at 4:52 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Mike Turquette <mturquette@linaro.org> writes:
>
>> Quoting Robert Jarzmik (2014-07-21 11:23:51)
>>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>>
>>> > This is the second opus of this serie.
>>>
>>> Ping ?
>>
>> Hi Robert,
>>
>> Overall the series looks good to me. The only problem I see is that
>> somewhere in the use of the PARENTS() macro there is a section mismatch
>> introduced. I spent about 5 minutes looking at it and gave up. This
>> problem introduces 26 section mismatch warnings building
>> colibri_pxa270_defconfig.
> OK Mike, I'll fix this. This is probably because pxa27x_clocks array is not
> __init, and it references parents which are __init. I was lazy letting
> pxa27x_clocks not __init because I reuse the internal fields "hw" and "gate->hw"
> later (hence I didn't leave the __init).
> This is a bit dirty and I'll launder it.
>
> Moreover, I have one fix which I had fixed wrt boot ordering : the
> postcore_init() must die. The reason behind is that I have no guarantee of
> ordering between clocks init and clocksource init, and clocksource relies on
> clocks.
>
> The right way will be AFAIK to call the core clocks init :
>  - within the device-tree initialization function : pxa27x_dt_clocks_init()
>  calls pxa27x_clocks_init9)
>  - directly from pxa27x_init() or pxa_timer_init() in non-device tree setup
>
>> Once those are fixed up then I will be happy to take this series. Do you
>> want me to take all six patches through the clk tree, including the
>> arm/arm stuff?
> I would feel more comfortable if :
>  - you take the 4 first ones (3 clock ones + 1 arm pxa header bit definitions)
>  - Haojian takes the last 2 ones (pxa ones)
>
I prefer that all these patches could go through clock tree. I just
want to avoid
build issue.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Regards
Haojian
