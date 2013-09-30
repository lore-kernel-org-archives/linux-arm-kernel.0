From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 30 Sep 2013 13:39:25 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <21065.25189.119250.773885@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <524455FD.7070808@pengutronix.de>
 <20130926155422.GQ12758@n2100.arm.linux.org.uk>
 <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
 <21061.21191.197931.54061@ipc1.ka-ro>
 <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
 <5245E2C5.1030705@pengutronix.de> <21065.23354.418805.871480@ipc1.ka-ro>
 <52495E24.4080703@pengutronix.de> <21065.25189.119250.773885@ipc1.ka-ro>
Message-ID: <524962ED.9000605@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2013 01:37 PM, Lothar Wa?mann wrote:
> Hi,
> 
> Marc Kleine-Budde writes:
>> On 09/30/2013 01:06 PM, Lothar Wa?mann wrote:
>>> Hi,
>>>
>>> Marc Kleine-Budde writes:
>>>> On 09/27/2013 07:24 PM, Matt Sealey wrote:
>>>>> Marc - I don't think FLEXCAN has changed layout at all in these areas.
>>>>> The hardware always worked this way..
>>>>
>>>> All flexcan cores support the RX FIFO, the mx6 supports an additional
>>>> mode for different acceptance filters.
>>>>
>>>>> The only difference here  is that the i.MX53 is doing something weird
>>>>> on the bus. The i.MX6Q is giving the absolutely correct BRESP for the
>>>>> transfer to the peripheral (in effect, a "go away, this is my data"
>>>>> failure, which the CPU turns into an imprecise abort since it no idea
>>>>> which transaction it committed aeons ago caused it).
>>>>>
>>>>> Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a data
>>>>> abort.. because it's not even a read-only region, it *should* be
>>>>> totally inaccessible to the CPU.
>>>>>
>>>>> The question I have is, when MCR[FEN] is set on i.MX53, does reading
>>>>> from those reserved registers give anything but 0's or garbage? I'm
>>>>> curious, that's all, it doesn't really matter ;)
>>>>
>>>> The driver only read from message buffer 0, and uses buffer 8 for tx.
>>>> The others are not accessed, unless in that chip start routine. We don't
>>>> need this loop, it comes from the original driver. I think no one has
>>>> ever noticed that bug, because all other CPUs have not complained.
>>>>
>>>> The driver without the loop is working on mx6 and Lothar is testing it
>>>> on mx53.
>>>>
>>> I can confirm, that the driver still works on i.MX53 as before the
>>> patch.
>>> Is someone going to prepare a patch, or should I do it, as I was the
>>> one who first brought up this issue?
>>
>> I have a patch ready, it's basically what I send you. Can I add your
>> Tested-by?
>>
> Yes, of course.

Tnx,
Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/6d1fb191/attachment-0001.sig>
