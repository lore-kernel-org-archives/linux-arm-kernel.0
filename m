From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Sat, 08 Nov 2014 14:38:04 +0100
Subject: [PATCH v4 2/4] serial: mxs-auart: use mctrl_gpio helpers for
 handling modem signals
In-Reply-To: <201411081222.05722.marex@denx.de>
References: <1412960007-28159-1-git-send-email-j.uzycki@elproma.com.pl>
 <201411071548.58044.marex@denx.de> <545CF36D.3060501@elproma.com.pl>
 <201411081222.05722.marex@denx.de>
Message-ID: <545E1CBC.4070409@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-11-08 o 12:22, Marek Vasut pisze:
> On Friday, November 07, 2014 at 05:29:33 PM, Janusz U?ycki wrote:
>> W dniu 2014-11-07 o 15:48, Marek Vasut pisze:
>>> On Friday, November 07, 2014 at 02:23:23 PM, Janusz U?ycki wrote:
>>> [...]
>>>
>>>>>> Hardware RTS/CTS lines can be occupied by RX/TX of other AUART port
>>>>>> in order to obtain as much uarts as possible using i.mx283.
>>>>>> Therefore gpios can be used for "hardware" flow control.
>>>>> Your logic is outright flawed here, the first sentence doesn't
>>>>> implicate the second sentence. In fact, those two are completely
>>>>> unrelated.
>>>> I didn't write MUST but CAN. There is a choice. Is flexibility of the
>>>> driver disadvantage?
>>> If the flexibility brings in known problems, then yes, it is a problem.
>>> Not because of the flexibility, but because it brings in bugs.
>> New features new bugs :) Does it mean to stop development?
> You shouldn't push code which is known to be defective by design into mainline.

I've written in general. The patch is not defective and it has been 
discussed before (V4).
Did you read the code and the patch?

>>>>>>>>       If we change them to gpio.  Could the DMA still
>>>>>>>>
>>>>>>>> works fine?
>>>>>>>> did you test the DMA with this patch?
>>>>>>>>
>>>>>>>> Add Marek for this patch too.
>>>>>>> I didn't look too deep into the patch, so here's just my experience:
>>>>>>>
>>>>>>> 1) The AUART block signals and GPIO block signals are not sychronised
>>>>>>> using the
>>>>>>>
>>>>>>>        same clock. Therefore, the latency between toggling of the
>>>>>>>        AUART lines and the GPIO-driven pins will not be deterministic
>>>>>>>        and will vary. There might be a way to approximate that, but
>>>>>>>        that's definitelly not a reliable solution.
>>>>>>>        
>>>>>>>        This is very bad for example if you drive RS485 DIR line with
>>>>>>>        the RTS pin as a GPIO ; the RTS pin will toggle at
>>>>>>>        non-deterministic time compared to the end of UART
>>>>>>>        transmission. This will trigger bit-loss on the RS485 line and
>>>>>>>        you just don't want that.
>>>>>>>
>>>>>>> 2) Speaking of RS485, there's [1] and [2]. which I believe apply to
>>>>>>> any combo
>>>>>>>
>>>>>>>        of UART+GPIO toggling.
>>>>>>>
>>>>>>> So I hate to bring the bad news , but UART+GPIO combo toggling is
>>>>>>> really a bad bad idea.
>>>>>> Unfortunately if hardware is limited there is no choice and UART+GPIO
>>>>>> is necessary.
>>>>> You will run into timing problems (see above).
>>>> A lot of 8250-compatible devices has no hardware flow control and in
>>>> most cases
>>>> they works and it is enough even for 115200 speed if CTS is handled by
>>>> irq. So it depends on your needs.
>>> I presume that in such a case , the 8250 still handles the CTS line, not
>>> some external GPIO block, yes ?
>> Yes. However mxs includes both GPIO and AUART. Clocks differs but it is
>> still the same silicon.
>> External GPIO block is extreme example highly not recommended here.
> The way you implemented this particular change, it is possible to use arbitrary
> GPIO pin. There is no way you can guarantee anything about the latency of the
> GPIO toggling (I am repeating myself).

GPIO latency in SoC is usually smaller than any pin toggled in 8250 chip.
You can write some gpio-limiter patch for Richard's GPIO patch but in my 
opinion
it has no sense. DTB maker has to know what he is doing and why.
My patch concerns the mxs-auart driver so I can't understand
why your notes are addressed to me. You complain on much more patches in 
mainline,
not mine.

>
>>>>> What you're proposing here is a workaround for broken hardware, which
>>>>> was proven to be a bad idea and NAK'd already multiple times in the
>>>>> past (please see the links I posted in my last email).
>>>> It is not broken  hardware - rather limited to lower speeds but still
>>>> very useful solution.
>>> What exact "lower speed" are you talking about here and why ?
>> For example not more than 115200 but it depends on CPU load of course,
>> FIFO size
>> and device on the opposite site. RTS/CTS via GPIO require to know the limit
>> in an application.
> OK, this is completely unreliable solution, which works just by sheer luck.
>
>> I googled even so exotic thing like:
>> "8250: add support for DTR/DSR hardware flow control"
> The fact that those perversions exists doesn't make them right. It doesn't
> even make them mainlinable.

Again, not addressed to me. The world has accepted them.

>
>>>>>> Your experience confirms the discussion [3] with Russell King. DMA
>>>>>> should be disabled and
>>>>>> the patch disables DMA support in mxs_auart_init_gpios() if RTS or CTS
>>>>>> line is set as gpio.
>>>>> DMA has nothing to do with those problems here. DMA can be safely
>>>>> ignored for the purpose of the discussion altogether.
>>>> When gpios are used for RTS/CTS DMA is not used. However DMA is related
>>>> due to the driver
>>>> and "fsl,uart-has-rtscts". If you look into code of the driver you
>>>> should agree.
>>> This makes me believe that the DMA introduces too many timing
>>> fluctuations, so it's really not possible for you to keep toggling the
>>> GPIOs such that the bus would work. Is that the case ?
>> Yes, for RTS/CTS based on gpio DMA is not used. They are just toggled.
>> So you probably misunderstood me.
> I understand you -- in case DMA is enabled on the AUART block, your hack
> is no longer capable to working correctly, so everything falls apart.

You still didn't read the code or not carefully :)
If RTS/CTS aren't set as gpio it will work exactly as before - including 
DMA.
Otherwise I wouldn't push the patchset.

>
>>> [...]
>>>
>>>>>> Now the question: "fsl,uart-has-rtscts" name seems to be misleading
>>>>>> now, do you agree? It rather should include "dma" word in the name.
>>>>>> Any suggestion?
>>>>>>
>>>>>> [3] http://thread.gmane.org/gmane.linux.serial/16069/focus=16077
>>>>> The best suggestion I can give you is to fix your hardware early,
>>>>> before you run into nasty deep s.....tuff. These workarounds do not
>>>>> work and they will bit you later on, when it's hard to fix the
>>>>> hardware anymore.
>>>> The speed is limited but why don't you accept SW-HW mixed solutions?
>>> Did you read up on the RS485 timing problems and why that solution was
>>> never accepted for any driver ? I believe the threads explained that
>>> quite clearly.
>> Example of RS485 implementation where RTS is toggled by software:
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/dri
>> vers/tty/serial/omap-serial.c?id=4a0ac0f55b18dc297a87a85417fcf068658bf103
>> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/
>> drivers/tty/serial/omap-serial.c
> This is a question for Greg. I checked the discussion about this patch [1]
> and I see this timing issue was brought up, but the patch was applied anyway.
> I cannot tell you why , I just know that this GPIO approach has problems and
> I wrestled those a couple of days ago (without success, it's not possible to
> get correct timing).
>
> [1] http://www.spinics.net/lists/linux-serial/msg10574.html

Yes, this is the question for others - tty/serial's guru.
The timming isn't great but your opinion makes impossible to work most 
RS485 devices,
especially older but not only. You want to change the world here I 
think. In practive
costs usually have higher value than perfect timming if a solution works 
great without.
In the past hardware RS485 support even didn't exist. It is changing but 
slowly.

>>>> Exactly the same method is accepted for 8250.
>>> Can you point out this code please ?
>> If 8250 doesn't support auto flow control RTS/CTS are also toggled by
>> software,
>> uart_trottle(), uart_untrothle(), uart_handle_cts_change():
>> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L635
>> http://lxr.free-electrons.com/source/drivers/tty/serial/serial_core.c#L2796
>> Detected by irq (ms enabled when CRTSCTS) CTS change stops tx because
>> UPF_HARD_FLOW flag is not set by the mxs-auart driver.
> This doesn't use GPIO to toggle the RTS/CTS pins, it does toggle then via the
> 8250 IP block registers, right ?

Right. My patch allows to toggle the pins via SoC's pins - there is a 
choice in DT.
About latency I've written above.

>> Of course timing problem exists but in many cases it is not critical -
>> the toggle method was implemented many years ago and it seems to work.
> Yes, it does seem to work initially, that's why so many hardware people
> implement it, thinking the software people can fix those flubs. Problem
> is, this is one of those nasty problems, which cannot be fixed in software.

Look into the past. And, not each application needs perfect things. 
Hardware people do
not expect of magic things - they must know reality better than you assume.
It seems you have young people's approach. The real world is not 
perfect. There are
costs, limited set of available chips, limited PCB's space, habits, etc.

The thread doesn't concern my patchset at all now :)

thanks for the nice discussion
Janusz

>> The only problem for me is misleading "fsl,uart-has-rtscts" name because
>> the flag
>> only enables DMA if CRTSCTS is set and hardware flow control of AUART
>> block is used.
>>
>> best regards
>> Janusz
