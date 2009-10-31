From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Sat, 31 Oct 2009 12:20:45 +0100
Subject: at91sam9260 on linux 2.6.31 with at91 patchset: UART looses bytes
	when receiving packets
In-Reply-To: <594305.67002.qm@web84306.mail.re1.yahoo.com>
References: <594305.67002.qm@web84306.mail.re1.yahoo.com>
Message-ID: <4AEC1D8D.7020209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for your quick response.

Gerard Kam wrote:
>> Interestingly is is *always the same byte* on the same
>> position in the stream that is lost.
> 
> By "same position in the stream" do you mean "same position in the packet"?
> What is the byte position?

Yes, it's the same position in the same packet every time.
To be more specific it is always the 13th byte in the 12th packet that
is lost.
Before that there are 11 packets successfully received with an overall
length of 269 bytes.
Then, from the packet where the byte is lost 12 bytes are read correctly
and the 13th byte is dropped.
(Hence with regard to the previous packets it's
the (269+13) 282th byte that is dropped).

> What is the baud rate? 

I tried it with 115200 and with 230400 baud.
(At the moment the DSP board doesn't support other baud rates without
having to do some soldering.)

My tests showed that at both rates the problem is *exactly* the same.

> Maybe use HW flow control?

I tried it with and without hardware handshaking, the results are
*exactly* the same.
I also monitored the RTS line coming from the sam9260 with a scope: it's
at all times low meaning that the receiver is ready to receive new data.

Without hardware handshaking I even added an excess delay of 100ms
between sending packets to the DSP board (so that also the response
packets coming from the DSP arrive later).
The result is still the same so I really believe that it is not a
congestion or handshaking issue here.

> I'm using at91sam9260 rev A, kernel 2.6.28 and USART0 in raw mode, CTSRTS enabled and 111,111 baud (the device cannot do 115200).

I have a serial console attached to the board that runs at 115200 which
works just fine.
However to get the exact baud rate (and the error) that is used when the
port is configured with 115200 or 230400 baud I added a printk() to the
atmel_serial.c driver.

At 115200 baud it uses a quotient of 49 which is written to the BRGR
register as long int (thus it writes to the whole 32bit register).
For this reason in the baud rate generator the fractional divider is
disabled and the clock divider CD is set to 49.

With a master clock rate of MCK=90MHz we get a baud rate of
90000kHz/16/49 = 114.795 kbaud.
According to the formula given in the datasheet this would give a baud
rate error of 1-(115200/114795) = -0.003528028 = 0.35% error.

Hence the error is actually pretty low and a baud rate of 115200 should
work just fine.
The datasheet also says that it is not recommended to work with an error
higher than 5%.
Since in our case we are having an error of 0.35% there should be no
problem at all.
For this reason I'm not sure why you're telling that the device cannot
do a baud rate of 115200 ?

At a baud rate of 230400 the driver uses a quotient of 24.
Thus the actual baud rate is 90000kHz/16/24 = 234.375 kbaud and the
error would be 1-(230400/234375) = 0.01696 = 1.69% error.
Thus also for 230400 baud the error is still well below the 5% mark.


> The packets (16 to 400 bytes) have CRC32 checksums, and I haven't seen
a single lost byte.

My packets have a parity byte in the packet header as well which is
correct for all packets except for the last one.
Obviously the parity byte for that packet is not correct since one byte
is missing from the response.

Maybe I'm doing something wrong in my serial port setup code ?
The device is opened with:
------------------------------------------------------------------------
if ((fd=open(DEVICE, O_RDWR|O_APPEND|O_NDELAY|O_NOCTTY))<0)
    {
        perror("open");
        return -1;
    }
------------------------------------------------------------------------

I then configure it with:
------------------------------------------------------------------------
    if ((err=tcgetattr(fd, &oldtio))<0)
        goto error;

    memcpy(&newtio, &oldtio, sizeof(struct termios));

    // set baud rates
    cfsetispeed(&newtio, speed);
    cfsetospeed(&newtio, speed);

    // set format 8N1
    newtio.c_cflag &= ~CSIZE;   // Mask the character size bits
    newtio.c_cflag &= ~PARENB;
    newtio.c_cflag &= ~CSTOPB;
    newtio.c_cflag &= ~CSIZE;
    newtio.c_cflag |= CS8;      // Select 8 data bits

    // use hardware flow control (RTC/CTS)
    newtio.c_cflag |= CRTSCTS;

    // raw input
    newtio.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);

    // raw ouput
    newtio.c_oflag &= ~OPOST;

    // enable receiver and local mode
    newtio.c_cflag |= (CLOCAL | CREAD);

    newtio.c_cc[VTIME]=0;
    newtio.c_cc[VMIN]=1;

    if ((err=tcsetattr(fd,TCSANOW,&newtio))<0)
        goto error;

    // flush buffers
    tcflush(fd, TCIOFLUSH);
------------------------------------------------------------------------

Then I read from the port in non-blocking mode with code like this:
------------------------------------------------------------------------
       // wait until data is available
        uart_data_available(fd, true);

        if ((bytes_read=read(fd, ptr, bytes_left))<0)
        {
            if (errno==EAGAIN)
                break;

            perror("could not receive header");
            return -1;
        }

        printf("read chunk of %i bytes\n", bytes_read);
------------------------------------------------------------------------

The uart_data_available() function uses select() to wait until data is
available.

With that code I get valid responses that look like:
(In these dumps the 4 byte header is not included)
------------------------------------------------------------------------
read chunk of 26 bytes
hexdump(): 26 bytes
0000	01 c0 3c 29 cd 37 26 41 01 a6 56 bb 00 01 e4 0a ...<).7&A..V....
0010	95 08 d4 42 80 1f 6a 4d 9f c7                   ...B..jM..
------------------------------------------------------------------------

The packet with the missing byte looks like this however:
------------------------------------------------------------------------
read chunk of 25 bytes
hexdump(): 25 bytes
0000	01 c0 3c 22 cd 3c 36 4b ae 56 99 00 21 e4 29 84 ...<".<6K.V..!.)
0010	0a c3 6a 95 17 6f 4d 9f c7                      ..j..oM..
------------------------------------------------------------------------

On my PC where I'm sniffing the DSP's TX pin@the same time this
packet is received correctly:
(here the first 4 bytes i marked with XX are the header which is not
included in the dumps above)
------------------------------------------------------------------------
0000	XX XX XX XX 01 c0 3c 22 cd 3c 36 4b 13 ae 56 99 .a.....<".<6K..V

0000	00 21 e4 29 84 0d c3 6a 95 17 6f 4d 9f c7       .!.)...j..oM..
------------------------------------------------------------------------

As you can see (with respect to the 4 bytes header) the 13th byte (0x13)
 is correctly received on the sniffing PC but missing in the response
received by the sam9260.

I'm now trying to add some code to the atmel_serial.c driver so that the
kernel directly prints all the bytes it receives.
If the responses I get there are the same than in my application I can
assume that my code is correct and the problem must be somewhere else.

cheers,
stefan
