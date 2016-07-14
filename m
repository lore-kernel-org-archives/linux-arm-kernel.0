From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Thu, 14 Jul 2016 15:29:14 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <5787859b.c3c4190a.282b0.3efb@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 7 Jul 2016 15:43:14 +0200, thomas.petazzoni at free-electrons.com wrote:

> > > > My Armada 385 -device hangs when using marvell-cesa -driver.
> > > > I'm using Linux 4.4.10 and armada-385-db-ap.dts.
> > > > I have also tried with the driver version of Linux 4.7-rc3.
> > > > 
> > > > Please see https://bugzilla.kernel.org/show_bug.cgi?id=120111 for details.  
> > 
> > > Can you try with
> > > http://git.infradead.org/linux-mvebu.git/commitdiff/c5379ba8fccd99d5f99632c789f0393d84a57805
> > > applied ?  
> > 
> > Thanks Thomas.
> > Your patch seems to fix a random hang during crypto operations.
>
> OK, great.
>

(Some lines snipped...)

> Could you test with the latest 4.7-rc kernel + the patch I provided?

Sorry about that silence. Finally I had some time for testing this.

I took Linux 4.7-rc7 (92d21ac74a9e3c09b0b01c764e530657e4c85c49) and just put "fix HW I/O coherency related deadlocks" to top of it.
Unfortunately, the result was exact same than 4.4.10.

First, without the driver:

# cryptsetup benchmark --cipher aes-cbc

# Tests are approximate using memory only (no storage IO).
#  Algorithm | Key |  Encryption |  Decryption
      aes-cbc   256b    21.9 MiB/s    23.6 MiB/s

Loading the driver:

# modprobe marvell_cesa
[  103.213901] marvell-cesa f1090000.crypto: CESA device successfully registered

And after that:
# cryptsetup benchmark --cipher aes-cbc

was never done.

Thanks,

Jussi
