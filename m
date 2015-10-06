From: peda@lysator.liu.se (Peter Rosin)
Date: Tue, 6 Oct 2015 18:41:16 +0200
Subject: Regression: at24 eeprom writing
In-Reply-To: <CAH9NwWdv=JGGoy4JaGf77v=Z70Ms1ieeKGXNcW2weFaR2wy9+g@mail.gmail.com>
References: <560F0DB1.2020101@lysator.liu.se> <56118304.8020002@lysator.liu.se>
 <CAH9NwWdv=JGGoy4JaGf77v=Z70Ms1ieeKGXNcW2weFaR2wy9+g@mail.gmail.com>
Message-ID: <5613F9AC.3090609@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-10-05 08:16, Christian Gmeiner wrote:
> Hi Peter.
> 
> Sorry for the late answer - I am currently on my way to Dublin. Maybe
> it helps if you enable
> I2C_DEBUG_CORE and I2C_DEBUG_BUS. In theory you should see a little
> bit better what
> happens on the bus.

Good suggestion. I did a new run (vanilla 4.2), and this is what I saw on
the bus this time:

[0.00000] S W50 0x00 "product = 1-776-" P
[0.00184] S W50 NACK P
[0.00195] S W50 NACK P
[0.02027] S W50 0x10 ACK...
[0.04035] ...ACK 0x10 "3.0\n" P
[0.04100] S W50 NACK P
[0.04111] S W50 NACK P
[0.06032] S W50 "serial = 380" P
[0.06174] S W50 NACK P
[0.06185] S W50 NACK P
[0.08032] S W50 0x20 ACK...
[0.10034] ...ACK 0x20 "000002\n" P
[0.10127] S W50 NACK P
[0.10138] S W50 NACK P
[0.12039] S W50 0x27 "         " P
[0.12155] S W50 NACK P
[0.12166] S W50 NACK P
[0.14040] S W50 0x30 "                " P
[0.14219] S W50 NACK P
[0.14230] S W50 NACK P
[0.16042] S W50 0x40 "                " P
...

And this is the corresponding part of the log from the same run
(offset ~197.79 s):

[  197.790000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=17
[  197.790000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.790000] at91_i2c f0014000.i2c: transfer: write 17 bytes.
[  197.800000] at91_i2c f0014000.i2c: transfer complete
[  197.800000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=5
[  197.800000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.800000] at91_i2c f0014000.i2c: transfer: write 5 bytes.
[  197.800000] at91_i2c f0014000.i2c: wrote 0x10, to go 4
[  197.800000] at91_i2c f0014000.i2c: wrote 0x33, to go 3
[  197.800000] at91_i2c f0014000.i2c: received nack
[  197.820000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=5
[  197.820000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.820000] at91_i2c f0014000.i2c: transfer: write 5 bytes.
[  197.820000] at91_i2c f0014000.i2c: wrote 0x10, to go 4
[  197.820000] at91_i2c f0014000.i2c: received nack
[  197.840000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=5
[  197.840000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.840000] at91_i2c f0014000.i2c: transfer: write 5 bytes.
[  197.840000] at91_i2c f0014000.i2c: wrote 0x10, to go 4
[  197.840000] at91_i2c f0014000.i2c: wrote 0x33, to go 3
[  197.840000] at91_i2c f0014000.i2c: wrote 0x2e, to go 2
[  197.840000] at91_i2c f0014000.i2c: wrote 0x30, to go 1
[  197.840000] at91_i2c f0014000.i2c: wrote 0xa, to go 0
[  197.840000] at91_i2c f0014000.i2c: transfer complete
[  197.840000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=13
[  197.840000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.840000] at91_i2c f0014000.i2c: transfer: write 13 bytes.
[  197.840000] at91_i2c f0014000.i2c: received nack
[  197.860000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=13
[  197.860000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.860000] at91_i2c f0014000.i2c: transfer: write 13 bytes.
[  197.860000] at91_i2c f0014000.i2c: transfer complete
[  197.860000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=8
[  197.860000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.860000] at91_i2c f0014000.i2c: transfer: write 8 bytes.
[  197.860000] at91_i2c f0014000.i2c: wrote 0x20, to go 7
[  197.860000] at91_i2c f0014000.i2c: wrote 0x30, to go 6
[  197.860000] at91_i2c f0014000.i2c: received nack
[  197.880000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=8
[  197.880000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.880000] at91_i2c f0014000.i2c: transfer: write 8 bytes.
[  197.880000] at91_i2c f0014000.i2c: wrote 0x20, to go 7
[  197.880000] at91_i2c f0014000.i2c: received nack
[  197.900000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=8
[  197.900000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.900000] at91_i2c f0014000.i2c: transfer: write 8 bytes.
[  197.900000] at91_i2c f0014000.i2c: wrote 0x20, to go 7
[  197.900000] at91_i2c f0014000.i2c: wrote 0x30, to go 6
[  197.900000] at91_i2c f0014000.i2c: wrote 0x30, to go 5
[  197.900000] at91_i2c f0014000.i2c: wrote 0x30, to go 4
[  197.900000] at91_i2c f0014000.i2c: wrote 0x30, to go 3
[  197.900000] at91_i2c f0014000.i2c: wrote 0x30, to go 2
[  197.900000] at91_i2c f0014000.i2c: wrote 0x32, to go 1
[  197.900000] at91_i2c f0014000.i2c: wrote 0xa, to go 0
[  197.900000] at91_i2c f0014000.i2c: transfer complete
[  197.900000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=10
[  197.900000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.900000] at91_i2c f0014000.i2c: transfer: write 10 bytes.
[  197.900000] at91_i2c f0014000.i2c: received nack
[  197.920000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=10
[  197.920000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.920000] at91_i2c f0014000.i2c: transfer: write 10 bytes.
[  197.920000] at91_i2c f0014000.i2c: transfer complete
[  197.920000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=17
[  197.920000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.920000] at91_i2c f0014000.i2c: transfer: write 17 bytes.
[  197.920000] at91_i2c f0014000.i2c: received nack
[  197.940000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=17
[  197.940000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.940000] at91_i2c f0014000.i2c: transfer: write 17 bytes.
[  197.940000] at91_i2c f0014000.i2c: transfer complete
[  197.940000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=17
[  197.940000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.940000] at91_i2c f0014000.i2c: transfer: write 17 bytes.
[  197.940000] at91_i2c f0014000.i2c: received nack
[  197.960000] i2c i2c-0: master_xfer[0] W, addr=0x50, len=17
[  197.960000] i2c i2c-0: at91_xfer: processing 1 messages:
[  197.960000] at91_i2c f0014000.i2c: transfer: write 17 bytes.
[  197.960000] at91_i2c f0014000.i2c: transfer complete
...

Observations/questions:

- The number of NACKs seen on the bus does not match the number
  of "received nack" messages, every double NACK on the bus only
  has a single "received nack" message AFAICT.
- The bus driver seems to think that the 20ms ACKs are NACKs.
  Could it be that the eeprom is engaging in clock stretching
  or something such?
- After a 20ms ACK that the bus driver thinks is a NACK, the last
  command is reissued, but that seems to result in the tail being
  added to the ongoing command that the bus driver thinks have
  already terminated with a NACK. Or something?
- It seems to work better when I write spaces.

Cheers,
Peter
