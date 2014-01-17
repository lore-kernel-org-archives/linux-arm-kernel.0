From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Jan 2014 17:59:30 +0800
Subject: [PATCH RFC 1/6] net: rfkill: gpio: fix gpio name buffer size off
 by 1
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D45EA9D@AcuExch.aculab.com>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <1389941251-32692-2-git-send-email-wens@csie.org>
 <063D6719AE5E284EB5DD2968C1650D6D45EA9D@AcuExch.aculab.com>
Message-ID: <CAGb2v67L__kusyfSxSc1Rmb6mtJ_VQQF+rCfr1AiUxCemaXMqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 5:46 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Chen-Yu Tsai
>> snprintf should be passed the complete size of the buffer, including
>> the space for '\0'. The previous code resulted in the *_reset and
>> *_shutdown strings being truncated.
> ...
>> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> ...
>> -     snprintf(rfkill->reset_name, len + 6 , "%s_reset", rfkill->name);
>> -     snprintf(rfkill->shutdown_name, len + 9, "%s_shutdown", rfkill->name);
>> +     snprintf(rfkill->reset_name, len + 7 , "%s_reset", rfkill->name);
>> +     snprintf(rfkill->shutdown_name, len + 10, "%s_shutdown", rfkill->name);
>
> I can't find the context for the above, but they look very dubious.
> I'd expect: snprintf(foo, sizeof foo, ...).
> If you are trying to truncate rfkill->name you need to use %.*s.

The driver allocates these buffers on the fly, a few lines above:

        len = strlen(rfkill->name);
        rfkill->reset_name = devm_kzalloc(&pdev->dev, len + 7, GFP_KERNEL);
        rfkill->shutdown_name = devm_kzalloc(&pdev->dev, len + 10, GFP_KERNEL);

I am not trying to truncate rfkill->name. Rather, the buffer length passed
to snprintf was wrong, so the resulting name was truncated by one character.


Thanks,
ChenYu
