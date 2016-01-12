From: tbm@cyrius.com (Martin Michlmayr)
Date: Mon, 11 Jan 2016 16:07:21 -0800
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20160111232231.GS6588@sirena.org.uk>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <20160111230059.GA12286@jirafa.cyrius.com>
 <20160111232231.GS6588@sirena.org.uk>
Message-ID: <20160112000721.GB12286@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@debian.org> [2016-01-11 23:22]:
> >      spi: Pump transfers inside calling context for spi_sync()
> 
> Can you please clarify?  You're saying this causes SATA timeouts but
> this is a change in the SPI subsystem and you're talking about MTD
> devices.  You've also not said which kernel version this is with...

Sorry for being unclear.  The problem is that other activities get
blocked (most notably SATA) when writing a 9 MB file to an SPI flash
chip.  The problem does not happen when writing a smaller (2 MB) file.
It only happens when writing to mtdblock, not to mtd (maybe flashcp
writes the file in smaller blocks?).

The problem still exists in 4.4.  I started with 3.16 which was known
to be good.  This was using the ARM board file for QNAP.  I then tried
Device Tree with 3.16 since someone suggested to try that.  I verified
that 3.19 works and that 4.0 shows the problem, and bisected it to the
commit I mentioned.

> In any case, please provide traces from ftrace with all the SPI trace
> enabled (via /sys/kernel/debug/trace/events/spi/enable).

I've never used ftrace so I need to look into that (or maybe Andrew
can help).

Anyway, here's the original log:

root at debian:~# cat mtd2 > /dev/mtdblock2
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: failed command: FLUSH CACHE EXT
ata1.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 20
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: hard resetting link
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl F300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: limiting SATA link speed to 1.5 Gbps
ata1: hard resetting link

-- 
Martin Michlmayr
http://www.cyrius.com/
