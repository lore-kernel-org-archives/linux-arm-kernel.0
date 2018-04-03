From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Tue, 3 Apr 2018 15:12:43 +0300
Subject: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
In-Reply-To: <20180403114006.u7tz2c7lvofsqwtg@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
 <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
 <20180403114006.u7tz2c7lvofsqwtg@flea>
Message-ID: <34b3af7e-8e05-b131-d3ac-4920daf6343a@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 02:40 PM, Maxime Ripard wrote:
> On Tue, Apr 03, 2018 at 02:08:43PM +0300, Sergey Suloev wrote:
>> On 04/03/2018 11:10 AM, Maxime Ripard wrote:
>>> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>>>> There is no need to handle 3/4 empty/full interrupts as the maximum
>>>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>>>> SoCs.
>>> That assumes that you'll be able to treat the FIFO full interrupt and
>>> drain the FIFO before we have the next byte coming in. This would
>>> require a real time system, and we're not in one of them.
>> AFAIK in SPI protocol we send and receive at the same time.
> It depends. The protocol allows it yes, but most devices I've seen can
> only operate in half duplex. But it's not really the point.
>
>> As soon as the transfer length is <= FIFO depth then it means that
>> at the moment we get TC interrupt all data for this transfer
>> sent/received already.
>>
>> Is your point here that draining FIFO might be a long operation and we can
>> lose next portion of data ?
> My point is that, if you get another interrupt(s) right before the
> FIFO full interrupt, that interrupt is going to be masked for as long
> as it is needed for the previous handler(s) to execute.
>
> If you're having another byte received while the interrupt is masked,
> you're losing data.
>
> Maxime
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

ok, I am going to put back 3/4 full handler then.
