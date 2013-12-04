From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 4 Dec 2013 11:17:27 -0500 (EST)
Subject: [PATCH] serial: pl011: use port lock to guard control register
 access
In-Reply-To: <1386149930.3417.22.camel@linaro1.home>
References: <1386149930.3417.22.camel@linaro1.home>
Message-ID: <alpine.LFD.2.10.1312041105470.31246@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Dec 2013, Jon Medhurst (Tixy) wrote:

> I can't help but think I've missed something fundamental here as it
> seems wrong to be in the situation at all where were initialising
> hardware if it is already being used?
> 
> Also, even with this fix I still see spurious/corrupt output on the
> serial port at the point the port is initialised, so there is obviously
> some other issues in this area.

I don't know if this is still the case nowdays, but that might be due to 
the fact that the tty layer initializes the port speed to 9600 bauds 
when opened.  So there might be a period when the port goes from 115200 
bauds (from the serial console setup) to 9600 bauds, to finally go back 
to 115200 bauds configured by the getty process.  If the serial console 
is in the middle of outputting something when user space opens the port 
then you might see garbled output for a brief period.

[ On some boards the typical speed is 38400 instead of 115200 but the 
  same concern applies. ]

I think that if a serial console has already initialized a port then the 
tty's initial parameters could simply default to those from the already 
active serial console sharing the same port.


Nicolas
