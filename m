From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Sat, 27 Sep 2014 13:15:00 +0200
Subject: [PATCH 2/4] serial: mxs-auart: use mctrl_gpio helpers for handling
 modem signals
In-Reply-To: <20140927105408.GD5182@n2100.arm.linux.org.uk>
References: <1411811197-12638-1-git-send-email-j.uzycki@elproma.com.pl>
 <1411811197-12638-3-git-send-email-j.uzycki@elproma.com.pl>
 <5426926C.60402@elproma.com.pl>
 <20140927105408.GD5182@n2100.arm.linux.org.uk>
Message-ID: <54269C34.8040702@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-09-27 12:54, Russell King - ARM Linux pisze:
> On Sat, Sep 27, 2014 at 12:33:16PM +0200, Janusz U?ycki wrote:
>> Could somebody comment if DMA could be enabled also
>> if CTS/RTS is supported by GPIOs? Is it safe?
>> It would allow me to avoid ugly code in mxs_auart_settermios(),
>> as commented Russel King.
> Russel*L* please, otherwise you are giving me implicit permission to
> mis-spell your name.

Sorry. I will care about.
Many people change my name also from Janusz to Januzs.

>> Otherwise I have to keep backward compatibility on DMA
>> and HW flow control, and fix the ugly code.
>>
>> Marek Vasut:
>> "Why do you think DMA would do any good on long transfers without
>> flowcontrol."
> The problem with DMA without hardware flow control is that the UART
> transmission will run at full speed, with characters back to back.
>
> You will have a variable amount of latency when dealing with the CTS
> signal - interrupt handling latency in Linux can be quite variable.
> (I'm not sure whether this has improved recently, USB used to be
> particularly bad, causing 3+ ms latencies.)
>
> When CTS is deasserted, you have to pause the transmission as soon as
> possible to avoid overflowing the remote end.  At 115200 baud, each
> character takes around 90us to be transmitted.  If you are delayed in
> handling the CTS interrupt for 3ms, then you will have transmitted
> around 35 characters in that time, which could be enough to cause an
> overflow at the remote end.
>
> Since the idea of flow control is to prevent overruns/overflow at the
> receiver, this is far from ideal.
>
> If Linux had a way to handle flow control interrupts as a higher
> priority than other interrupts (especially interrupting an already
> in-progress interrupt handler) then having GPIOs as flow control
> signals would be a much saner proposition.
>
> Unfortunately, lockdep completely gets in the way of that.
It means it is possible but not in Linux today?
I think the problem is not interrupt delay, which is often much below 100us
(we get ~10us delay on DCD).
USB or PCIe are exceptions  - interrupt is packed to frame by serialized
and even polled by USB controller.
Isn't the problem rather how to break DMA transmission fast?
Hardware flow control not always requires to stop transmission
immediately. Usually delay of some chars is acceptable if remote receiver
implements low/high water mark (overflow trigger lower than RX FIFO size).

best regards
Janusz
