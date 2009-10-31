From: dev.c0debabe@gmail.com (Stefan Schoenleitner)
Date: Sat, 31 Oct 2009 15:00:54 +0100
Subject: at91sam9260 on linux 2.6.31 with at91 patchset: UART looses bytes
	when receiving packets
In-Reply-To: <4AEC1D8D.7020209@gmail.com>
References: <594305.67002.qm@web84306.mail.re1.yahoo.com>
	<4AEC1D8D.7020209@gmail.com>
Message-ID: <4AEC4316.3050008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I added some debug code to the atmel_serial.c kernel driver now.
The result is that the kernel *correctly receives* all bytes from the "bad" packet:

kernel: hexdump(): 30 bytes
kernel: 0000    61 00 1a 01 01 c0 3c 22 cd 3c 36 4b 13 ae 56 99 .a.....<".<6K..V
kernel: 0010    00 21 e4 29 84 0d c3 6a 95 17 6f 4d 9f c7       .!.)...j..oM..


But in the application the 0x13 byte is never received:


hexdump(): 4 bytes
0000	61 00 1a 01                                     a...
read chunk of 25 bytes
hexdump(): 25 bytes
0000	01 c0 3c 22 cd 3c 36 4b ae 56 99 00 21 e4 29 84 ...<".<6K.V..!.)
0010	0a c3 6a 95 17 6f 4d 9f c7                      ..j..oM..



Is it possible that the byte 0x13 is somehow filtered out ?
If so, why does the same code work then on the PC but not on the ARM board ?

I suspect that my raw terminal setup is missing something ?
--------------------------------------------------------------------------
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
--------------------------------------------------------------------------

cheers,
stefan
