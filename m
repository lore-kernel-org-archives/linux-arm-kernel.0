From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 27 Sep 2013 21:55:49 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <524455FD.7070808@pengutronix.de>
 <20130926155422.GQ12758@n2100.arm.linux.org.uk>
 <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
 <21061.21191.197931.54061@ipc1.ka-ro>
 <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
Message-ID: <5245E2C5.1030705@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 07:24 PM, Matt Sealey wrote:
> On Fri, Sep 27, 2013 at 4:41 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>>> If r2 is indeed the address of the access, then this is entirely down
>>> to a misuse of the hardware; from the manual:
>>>
>>> ~
>>> When the FEN bit is set in the MCR, the memory area from 0x80 to 0xFF (which is
>>> normally occupied by MB0 to MB7) is used by the reception FIFO engine.
>>> Table 34-6
>>> shows the Rx FIFO data structure. The region 0x80-0x8F contains an
>>> message buffer
>>
>> What manual are you referring to? In my "i.MX 6Dual/6Quad Applications
>> Processor Reference Manual, Rev. 1, 04/2013" flexcan is chapter 26 and
>> Table 34-6 is: Single-Ended Source Termination Resistance Settings
>> of the HDMI interface.
> 
> Actually that was from the i.MX53 manual.. it's table 26-7 in the MX6
> manual and the description is different, but the hardware operation is
> *identical*.

Yes, mx25, mx35, mx53 and mx28 seem to be identical when it comes to the
message buffers. The flexcan on mx6 has an additional acceptance filter
functionality.

>>> I'm surprised this ever worked.. if the area 0x90-0xDF is being used
>>> by the FIFO internally then the difference between i.MX53 ('working')
>>> and i.MX6Q ('imprecise abort') is that the i.MX6Q is causing the
>>> proper bus response. We can only hope that the i.MX53 is ONLY not
>>> causing the proper bus response and not actually letting you write
>>> into a FIFO internal data area..
>>
>> This seems a plausible explanation.
>>
>> The definition:
>> |struct flexcan_mb {
>> |       u32 can_ctrl;
>> |       u32 can_id;
>> |       u32 data[2];
>> |};
>> |
>> |/* Structure of the hardware registers */
>> |struct flexcan_regs {
>> |       u32 mcr;                /* 0x00 */
>> [...]
>> |       struct flexcan_mb cantxfg[64];
>> |                                 ^^
>> has obviously nothing to do with reality!
> 
> It does, as you found later, reflect reality as it is where the
> message buffers 0-5 go when the FIFO is disabled. After that there are
> filter registers.. some unions or egregious casting is required, but
> the structure is semi-correct.
> 
> This is defined in the i.MX6Q manual at least in section 26.4:
> 
> ~~~
> 26.4 Message Buffer Structure
> Message Buffer Address: Base + 0x0080-0x047C
> ~~~
> 
> But when FEN is set, this is internal FIFO data after entry 0, as
> defined in section 26.5:
> 
> ~~~
> 26.5 Rx FIFO Structure
> When the MCR[RFEN] bit is set, the memory area from $80 to $DC (which
> is normally
> occupied by MBs 0 to 5) is used by the reception FIFO engine.
> 
> The region 0x80-0x8C contains the output of the FIFO which must be
> read by the CPU as
> a Message Buffer. This output contains the oldest message received and
> not read yet. The
> region 0x90-0xDC is reserved for internal use of the FIFO engine.
> ~~~
> 
> Marc - I don't think FLEXCAN has changed layout at all in these areas.
> The hardware always worked this way..

All flexcan cores support the RX FIFO, the mx6 supports an additional
mode for different acceptance filters.

> The only difference here  is that the i.MX53 is doing something weird
> on the bus. The i.MX6Q is giving the absolutely correct BRESP for the
> transfer to the peripheral (in effect, a "go away, this is my data"
> failure, which the CPU turns into an imprecise abort since it no idea
> which transaction it committed aeons ago caused it).
> 
> Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a data
> abort.. because it's not even a read-only region, it *should* be
> totally inaccessible to the CPU.
> 
> The question I have is, when MCR[FEN] is set on i.MX53, does reading
> from those reserved registers give anything but 0's or garbage? I'm
> curious, that's all, it doesn't really matter ;)

The driver only read from message buffer 0, and uses buffer 8 for tx.
The others are not accessed, unless in that chip start routine. We don't
need this loop, it comes from the original driver. I think no one has
ever noticed that bug, because all other CPUs have not complained.

The driver without the loop is working on mx6 and Lothar is testing it
on mx53.

regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/4cb62a1f/attachment.sig>
