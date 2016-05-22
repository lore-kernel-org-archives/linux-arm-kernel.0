From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 22 May 2016 16:18:20 +0200
Subject: sunxi spi clock problem
Message-ID: <CAOMqctQKNWz3mYPMModLTZ-hj38GxHqa3mBmDhbfTZz0zJ-CUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I tried running a spidev test program on linux 4.6 and I uncovered a
problem with the sunxi clk framework.

Basically the system would lock up after running the test program.

Digging deeper I found that it locks up with commit
[47284e3e0f3c427c93f8583549b6c938e8a18015] spi: sun4i: allow transfers
to set transmission speed

This exposes a problem with the test program. I try to set the SPI
sped to 1MHz but at other place the speed is multiplied by 1000 to
save typing zeros so the actual requested speed is 1GHz. This commit
probably allows that request to propagate leading to the observed
system lockup.

Given the parents OSC24M, pll6 and pll5 one of pll6 and pll5 is
probably set up at 2GHz (or both in turn because due to some rounding
neither goes fully up to 2GHz resulting in 864000000 SPI clock). Then
the system locks up.

I can limit the speed in the SPI driver which is rated at 100MHz in
SoC manual (giving 200MHz pll) but the clk driver should probably
limit the clock setting to sane speeds itself.

I am not familiar with the sunxi-clk code and it has unfortunately no
debug prints which would show what is programmed to what speed.

Thanks

Michal

root at a10s:~/spidisp# ./spitest -r 50 -d -s 1000000 /dev/spidev2.0
Debug mode.
spidev spi2.0: setup mode 0, 8 bits/w, 40000000 Hz max --> 0
spidev spi2.0: spi mode 0
spidev spi2.0: setup mode 0, 8 bits/w, 40000000 Hz max --> 0
spidev spi2.0: msb first
spidev spi2.0: setup mode 0, 8 bits/w, 40000000 Hz max --> 0
spidev spi2.0: 0 bits per word
spidev spi2.0: setup mode 0, 8 bits/w, 1000000000 Hz max --> 0
/dev/spidev2.0: spi mode 0x0, 8 bits per word, 1000000000 Hz maxspidev
spi2.0: mclk spi2 (24000000)

Sending 00
spidev spi2.0: mclk spi2 setting rate 2000000000Hz
spidev spi2.0: mclk spi2 (864000000)
spidev spi2.0: clkdiv 0 CDR2 0 regval 4096
spi_master spi2: spi2.0: timeout transferring 1 bytes at 1000000000Hz for
100(100)ms
spidev spi2.0: SPI transfer failed: -110
spi_master spi2: failed to transfer one message from queue
xfer: Connection timed out
buffer size: 1, result -110
buffer size: 1, result -110, Connection timed out
Sending
maximum buffer size: 0
Using gpio 50.
Writing gpio export 50 to /sys/class/gpio/export.
Reading gpio direction from /sys/class/gpio/gpio50/direction: in

Reading gpio inversion from /sys/class/gpio/gpio50/active_low: 0

Writing gpio direction in to /sys/class/gpio/gpio50/direction.
Reading gpio value from /sys/class/gpio/gpio50/value: 1

Writing gpio direction out to /sys/class/gpio/gpio50/direction.
Writing gpio value 0 to /sys/class/gpio/gpio50/value.
Writing gpio value 1 to /sys/class/gpio/gpio50/value.
Writing gpio value 0 to /sys/class/gpio/gpio50/value.
Writing gpio value 1 to /sys/class/gpio/gpio50/value.
Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
spidev spi2.0: mclk spi2 (864000000)
spidev spi2.0: mclk spi2 setting rate 2000000000Hz
spidev spi2.0: mclk spi2 (864000000)
spidev spi2.0: clkdiv 0 CDR2 0 regval 4096
