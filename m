From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 12 Jan 2017 14:47:42 +0100
Subject: [PATCH v8 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
References: <1483607246-14771-1-git-send-email-cedric.madianga@gmail.com>
 <1483607246-14771-3-git-send-email-cedric.madianga@gmail.com>
 <20170111082208.vzu7xgpd4eakyldl@pengutronix.de>
 <CAOAejn2eOy2sn1VkE979ne23Sj9L6+kaQDNpL1EUKb2m=6sGXw@mail.gmail.com>
 <20170111153940.dtxzvtdici3r7l54@pengutronix.de>
 <CAOAejn2pW20VPP_yGtvJ_ufvj6Xj1poBiiA2WqkALiaLyyONug@mail.gmail.com>
 <20170112120309.fmrt2lwz3vklqmti@pengutronix.de>
Message-ID: <CAOAejn289GLOSP-nPJnO_VpXLpyhTsF1bWQ7Ns9OfgPQCa8YTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-12 13:03 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Cedric,
>
> On Thu, Jan 12, 2017 at 12:23:12PM +0100, M'boumba Cedric Madianga wrote:
>> 2017-01-11 16:39 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> > On Wed, Jan 11, 2017 at 02:58:44PM +0100, M'boumba Cedric Madianga wrote:
>> >> 2017-01-11 9:22 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> >> > This is surprising. I didn't recheck the manual, but that looks very
>> >> > uncomfortable.
>> >>
>> >> I agree but this exactly the hardware way of working described in the
>> >> reference manual.
>> >
>> > IMHO that's a hw bug. This makes it for example impossible to implement
>> > SMBus block transfers (I think).
>>
>> This is not correct.
>> Setting STOP/START bit does not mean the the pulse will be sent right now.
>> Here we have just to prepare the hardware for the 2 next pulse but the
>> STOP/START/ACK pulse will be generated at the right time as required
>> by I2C specification.
>> So SMBus block transfer will be possible.
>
> A block transfer consists of a byte that specifies the count of bytes
> yet to come. So the device sends for example:
>
>         0x01 0xab
>
> So when you read the 1 in the first byte it's already too late to set
> STOP to get it after the 2nd byte.
>
> Not sure I got all the required details right, though.

Ok I understand your use case but I always think that the harware manages it.
If I take the above example, the I2C SMBus block read transaction will
be as below:
S Addr Wr [A] Comm [A]
           S Addr Rd [A] [Count] A [Data1] A [Data2] NA P

The first message is a single byte-transmission so there is no problem.

The second message is a N-byte reception with N = 3

When the I2C controller has finished to send the device address (S
Addr Rd), the ADDR flag is set and an interrupt is raised.
In the routine that handles ADDR event, we set ACK bit in order to
generate ACK pulse as soon as a data byte is received in the shift
register and then we clear the ADDR flag.
Please note that the SCL line is stretched low until ADDR flag is cleared.
So, as far I understand, the device could not sent any data as long as
the SCL line is stretched low. Right ?

Then, as soon as the SCL line is high, the device could send the first
data byte (Count).
When this byte is received in the shift register, an ACK is
automatically generated as defined during adress match phase and the
data byte is pushed in DR (data register).
Then, an interrupt is raised as RXNE (RX not empty) flag is set.
In the routine that handles RXNE event, as N=3, we just clear all
buffer interrupts in order to avoid another system preemption due to
RXNE event but we does not read the data in DR.

After receiving the ACK, the device could send the second data byte (Data1).
When this byte is received in the shift register, an ACK is
automatically generated.
As the first data byte has not been read yet in DR, the BTF (Byte
Transfer Finihed) flag is set and an interrupt is raised.
So, in that case, the SCL line is also streched low as long as the
data register has not been read.
In the routine that handle BTF event, we enable NACK in order to
generate this pulse as soon as the last data byte will be received and
then we read DR register ([Count])
At this moment, SCL line is released and the device could send the
last data byte.

After receiving the ACK, the device could send the third and last data
byte (Data2)
When this byte is received in the shift register, a NACK is
automatically generated as we enable it as explained above.
As the second data byte  (Data1) has not been read yet in DR, the BTF
flag is set again and an interrupt is raised.
The SCL line is stretched low and in that way we could set the STOP
bit to generate this pulse.
Then we run 2 consecutives read of DR to retrieve [Data1] and [Data2]
and to set SCL high.

So, thanks to SCL stretching, it seems that NA and P will be generated
at the right time.

Please let me know if it is not correct.

Best regards,

Cedric
