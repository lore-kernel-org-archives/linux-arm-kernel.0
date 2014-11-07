From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Fri, 07 Nov 2014 14:23:23 +0100
Subject: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <201411071202.16344.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
 <201411070903.11645.marex@denx.de> <545C992B.1070004@elproma.com.pl>
 <201411071202.16344.marex@denx.de>
Message-ID: <545CC7CB.1010107@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-11-07 o 12:02, Marek Vasut pisze:
> On Friday, November 07, 2014 at 11:04:27 AM, Janusz U?ycki wrote:
>> W dniu 2014-11-07 o 09:03, Marek Vasut pisze:
>>> On Friday, November 07, 2014 at 02:34:31 AM, Huang Shijie wrote:
>>>> why change them to gpio?
> +CC Alexandre, since he might be interested :-)

:)

>
>> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART port
>> in order to obtain as much uarts as possible using i.mx283.
>> Therefore gpios can be used for "hardware" flow control.
> Your logic is outright flawed here, the first sentence doesn't implicate the
> second sentence. In fact, those two are completely unrelated.

I didn't write MUST but CAN. There is a choice. Is flexibility of the 
driver disadvantage?

>>>>     If we change them to gpio.  Could the DMA still
>>>>
>>>> works fine?
>>>> did you test the DMA with this patch?
>>>>
>>>> Add Marek for this patch too.
>>> I didn't look too deep into the patch, so here's just my experience:
>>>
>>> 1) The AUART block signals and GPIO block signals are not sychronised
>>> using the
>>>
>>>      same clock. Therefore, the latency between toggling of the AUART
>>>      lines and the GPIO-driven pins will not be deterministic and will
>>>      vary. There might be a way to approximate that, but that's
>>>      definitelly not a reliable solution.
>>>      
>>>      This is very bad for example if you drive RS485 DIR line with the RTS
>>>      pin as a GPIO ; the RTS pin will toggle at non-deterministic time
>>>      compared to the end of UART transmission. This will trigger bit-loss
>>>      on the RS485 line and you just don't want that.
>>>
>>> 2) Speaking of RS485, there's [1] and [2]. which I believe apply to any
>>> combo
>>>
>>>      of UART+GPIO toggling.
>>>
>>> So I hate to bring the bad news , but UART+GPIO combo toggling is really
>>> a bad bad idea.
>> Unfortunately if hardware is limited there is no choice and UART+GPIO is
>> necessary.
> You will run into timing problems (see above).

A lot of 8250-compatible devices has no hardware flow control and in 
most cases
they works and it is enough even for 115200 speed if CTS is handled by irq.
So it depends on your needs.

>
> What you're proposing here is a workaround for broken hardware, which was proven
> to be a bad idea and NAK'd already multiple times in the past (please see the
> links I posted in my last email).

It is not broken  hardware - rather limited to lower speeds but still 
very useful solution.

>> Your experience confirms the discussion [3] with Russell King. DMA
>> should be disabled and
>> the patch disables DMA support in mxs_auart_init_gpios() if RTS or CTS
>> line is set as gpio.
> DMA has nothing to do with those problems here. DMA can be safely ignored
> for the purpose of the discussion altogether.

When gpios are used for RTS/CTS DMA is not used. However DMA is related 
due to the driver
and "fsl,uart-has-rtscts". If you look into code of the driver you 
should agree.

>
> Like I explained already -- the problem is with the GPIO and AUART block not
> being synchronised by the same clock. It is therefore impossible to predict
> and control when the GPIO signals and the AUART signals will toggle in relation
> to one another.
>
>> So I didn't test the patch with the DMA - I've just disabled it.
> This would break the driver for pretty much everyone using higher baud rates.

NO, there is a choice. If you don't use RTS/CTS as GPIO DMA isn't enabled.
It seems you didn't read neither the patch nor the driver's code and
analized only the sentence.

>
>> The question is different. The driver supports the cases for RTS/CTS:
>> 1)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
>>        DT sets fsl,uart-has-rtscts)
>>       a) settermios() sets CRTSCTS: DMA enabled, auto RTS/CTS is enabled
>>       b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS
>> controlled by get/set_mctrl()
>> 2)  both RTS/CTS assigned to hardware AUART (pinmux configured by DT,
>>        DT doesn't set fsl,uart-has-rtscts)
>>       a) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enabled
>>       b) settermios() doesn't set CRTSCTS: DMA disabled, RTS/CTS
>> controlled by get/set_mctrl()
>>
>> and after the patch it is more complex (because of mixed cases):
>> 3) both RTS/CTS assigned to gpios (DT sets or not fsl,uart-has-rtscts):
>>       the patch cancels fsl,uart-has-rtscts flag to disable DMA support,
>>       settermios() sets or not CRTSCTS: DMA disabled, RTS/CTS controlled
>> by get/set_mctrl(),
>>       both lines by gpios. In addition:
>>       a) settermios() doesn't set CRTSCTS: RTS of hardware AUART is also
>> controlled but
>>           the case assumes it is not selected by pinmux in DT
>>       b) settermios() sets CRTSCTS: auto RTS of hardware AUART is also
>> enabled but
>>           the case assumes it is not selected by pinmux in DT
>> 4) RTS assigned to hardware AUART (pinmux configured by DT,
>> fsl,uart-has-rtscts set or not),
>>       CTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag to
>> disable DMA support,
>>       a) settermios() doesn't set CRTSCTS: DMA disabled, CTS (as gpio)
>> read by get_mctrl(),
>>           RTS of hardware AUART controlled by set_mctrl()
>>       b) settermios() sets CRTSCTS: DMA disabled, CTS (as gpio) read by
>> get_mctrl(),
>>          auto RTS is enabled
>>      So case 4) is exactly 3) case with just different pinmux
>> configuration and the patch
>>      threats 3) and 4) as the same case.
>> 5) CTS assigned to hardware AUART (pinmux configured by DT,
>> fsl,uart-has-rtscts set or not),
>>       RTS assigned to gpio: the patch cancels fsl,uart-has-rtscts flag to
>> disable DMA support,
>>       a) settermios() doesn't set CRTSCTS: DMA disabled, CTS of hardware
>> AUART read by
>>           get_mctrl(), RTS (as gpio) controlled by set_mctrl(), in
>> addition RTS of hardware AUART
>>           is also controlled but the case assumes it is not selected by
>> pinmux in DT
>>       b) settermios() sets CRTSCTS: DMA disabled, auto RTS/CTS is enabled
>> but RTS is controlled by set_mctrl() as gpio because the case assumes it
>> is not selected
>>           by pinmux in DT
>>
>> It is not nice description but I hadn't idea how to write it more clear.
>> The mixed cases 4) and 5) are likely not so useful but possible and not
>> so expensive
>> to support.
>> Now the question: "fsl,uart-has-rtscts" name seems to be misleading now,
>> do you agree? It rather should include "dma" word in the name. Any
>> suggestion?
>>
>> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=16077
> The best suggestion I can give you is to fix your hardware early, before you
> run into nasty deep s.....tuff. These workarounds do not work and they will
> bit you later on, when it's hard to fix the hardware anymore.
The speed is limited but why don't you accept SW-HW mixed solutions?
Exactly the same method is accepted for 8250.
It is good to have choice than not. We can comment that speed is limited
for gpio-based hardware flow control. So please, rethink again.

best regards
Janusz
