From: matthieu.castet@parrot.com (Matthieu Castet)
Date: Thu, 12 May 2011 22:17:02 +0100
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <BANLkTi=N8VNh3tPxYH8dQ0UtGpN=xSzKng@mail.gmail.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110512074421.GA2429@pengutronix.de>,
	<BANLkTi=N8VNh3tPxYH8dQ0UtGpN=xSzKng@mail.gmail.com>
Message-ID: <F5C24FC168F95048BB6B9E0B13EB33152BA6F5307A@DIAMANT.xi-lite.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+In this 8x8 BGA package the pins { A8, A7, A6, A5 } can be used as an SPI port
+(these are four pins: CLK, RXD, TXD, FRM). In that case, pin B5 can be used as
+some general-purpose GPIO pin. However, in another setting, pins { A5, B5 } can
+be used as an I2C port (these are just two pins: SCL, SDA). Needless to say,
+we cannot use the SPI port and I2C port at the same time. However in the inside
+of the package the silicon performing the SPI logic can alternatively be routed
+out on pins { G4, G3, G2, G1 }.

Enumerating all possible case will be impossible because of the number of possible cases 
(and hardware guys can be very creative).

If spi can be in  { A8, A7, A6, A5 } and 
{ G4, G3, G2, G1 }, Then you can output the spi on :
- { A8, A7, A6, A5 }
- { A8, A7, A6, G1 }
- { A8, A7, G2, A5 }
[...]
- { G4, G3, G2, A5 }
- { G4, G3, G2, G1 }
You have 2^4 = 16 cases

Now RXD (MISO) or/and FRM (CS) can be not connected and used as a gpio. You have 4 * 16 cases = 64 cases.

Now take a complex chip, 200 balls 4 mux per ball and you can have up to 4^200 configurations...

Pin muxing is really board specific  and shouldn't be in a "generic" driver.

But what you could abstract is a way to select a configuration of a pin, not a group of pin
 for the board files.

Matthieu
