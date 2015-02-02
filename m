From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 02 Feb 2015 16:00:01 +0100
Subject: [PATCH v2, RFC] RTC: PXA: Fix regression of interrupt before
 ioremap
In-Reply-To: <87fvatnzl7.fsf@free.fr>
References: <54CA1ECA.8050000@tul.cz> <87fvatnzl7.fsf@free.fr>
Message-ID: <54CF90F1.4020703@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I agree that driver without .open looks ugly, but only thing in rtc-pxa 
.open were two request_irq and I don't think it is good idea to have 
them there (interrupts should be disabled trough register settings and 
not by handler freeing).

I'm not familiar with the linux RTC subsystem, so I don't know if it is 
OK to get interrupt (and rtc_update_irq) without opened /dev/rtc. 
Intuitively I have feeling it is OK, but even if not disabling can be 
done with some register flag.

BTW It seems that kernel have only around 9 drivers in drivers/rtc which 
contain .open function.

OT: rtc-sa1100 seems to be compatible with PXAxxx (it is even in 
Kconfig). Are there any reasons to have two drivers for one SoC?

Petr

On 29.1.2015 20:42, Robert Jarzmik wrote:
> Petr Cvek <petr.cvek@tul.cz> writes:
>
>> Interrupts appear before register set of the PXA2xx RTC controller is ioremaped.
>>
>> This fixes regression from:
>>    'commit a44802f8fb7e593adabc6ef53c8df45a1717fa9b ("drivers/rtc/rtc-pxa.c: fix alarm can't wake up system issue")'
>>    'commit 2f6e5f9458646263d3d9ffadd5e11e3d8d15a7d0 ("drivers/rtc: remove IRQF_DISABLED")'
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
>
> No sorry, I don't like this.
> It's not your patch I don't like, it fixes a real problem, but what happens then
> if :
>   - kernel boots
>   - a process opens /dev/rtc0
>
> The real issue is with patch a44802f "drivers/rtc/rtc-pxa.c: fix alarm can't
> wake up system issue". I'd rather have you revert a44802f, which makes no sense
> to me ...
>
> Leo if you want to comment on it, feel free, and tell me if you tried your patch
> with the code in Documentation/rtc.txt ?
>
> Cheers.
>
> --
> Robert
>
