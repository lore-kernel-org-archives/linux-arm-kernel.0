From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 19 Oct 2015 10:51:36 +0200
Subject: [PATCH] i2c: at91: fix write transfers by clearing pending
 interrupt first
In-Reply-To: <5620BE9A.10302@lysator.liu.se>
References: <1444746104-20615-1-git-send-email-ludovic.desroches@atmel.com>
 <561D20E7.5070405@lysator.liu.se> <561D359D.8000500@atmel.com>
 <561D46FE.4090801@lysator.liu.se>
 <20151014054321.GA20049@odux.rfo.atmel.com>
 <56203B0E.1030104@lysator.liu.se> <5620BE9A.10302@lysator.liu.se>
Message-ID: <20151019085136.GK26893@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Oct 16, 2015 at 11:08:42AM +0200, Peter Rosin wrote:
> On 2015-10-16 01:47, Peter Rosin wrote:
> > On 2015-10-14 07:43, Ludovic Desroches wrote:
> >> On Tue, Oct 13, 2015 at 08:01:34PM +0200, Peter Rosin wrote:
> >>> On 2015-10-13 18:47, Cyrille Pitchen wrote:
> >>>> Le 13/10/2015 17:19, Peter Rosin a ?crit :
> >>>>> On 2015-10-13 16:21, Ludovic Desroches wrote:

[...]

> > I have started to get this when I run with this patch:
> > 
> > [   73.310000] at91_i2c f0014000.i2c: RXRDY still set!
> > [  198.200000] at91_i2c f0014000.i2c: RXRDY still set!
> > [  509.880000] at91_i2c f0014000.i2c: RXRDY still set!
> > [  615.750000] at91_i2c f0014000.i2c: RXRDY still set!
> > [  617.750000] at91_i2c f0014000.i2c: RXRDY still set!
> > [ 1766.640000] at91_i2c f0014000.i2c: RXRDY still set!
> > [ 2035.380000] at91_i2c f0014000.i2c: RXRDY still set!
> > [ 2227.190000] at91_i2c f0014000.i2c: RXRDY still set!
> > [ 2313.100000] at91_i2c f0014000.i2c: RXRDY still set!
> > 
> > My USB serial dongle was hung which was why I didn't notice until just now.
> > 
> > This is probably not when communication with the eeprom though, and certainly not
> > writing to it, but perhpaps when polling the temperature (using the jc42 driver).
> > I'll investigate further in the morning to see if I can pinpoint it.
> 
> Yep, it's the jc42 accesses that triggers this (to the same chip as the
> eeprom, but a different block of transistors I suppose).
> 
> Looking at the i2c bus, the accesses normally go like this:
> 
> [0.000000] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> [0.000521] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> [0.001024] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> [0.001524] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> [0.196991] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> [0.197514] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> [0.198019] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> [0.198520] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> 
> I.e. chunks of four transfers every ~200 ms (I removed the 1Hz rate
> limiter in the jc42 driver to get more frequent incidents).
> 
> But when the diagnostic (RXRDY still set!) is output it continues
> with this:
> 
> [0.399755] S 0x18 W 0x05 S 0x18 R 0xc1 0xbe NACK P
> [0.404998] S 0x18 W 0x04 S 0x18 R 0x00 0x00 NACK P
> [0.405508] S 0x18 W 0x03 S 0x18 R 0x00 0x00 NACK P
> [0.406008] S 0x18 W 0x02 S 0x18 R 0x00 0x00 NACK P
> 
> Notice the ~5 ms delay (about the time it should take to output
> the diagnostic at 115200 baud) after the access to register 0x05
> at 0.399755.
> 
> This is the only thing that I can observe on the bus, so it appears
> to be harmless.
> 
> It appears that the i2c access at 0.399755 finds the TWI
> registers in an odd state, but nothing from the access at
> 0.198520 appears to have gone wrong. Is this a race? Anyway,
> the diagnostic is pretty frequent and annoying. printk_once?

I'll try to reproduce it on my side. The only issue you have is having
the message about RXRDY? I mean no issue with i2c transfers?

It is not the possible bug we had in mind, this bug will prevent the
master device to release the i2c bus. It will stop the transfer but
without sending a stop on the bus.

Regards

Ludovic
