From: tbm@cyrius.com (Martin Michlmayr)
Date: Mon, 11 Jan 2016 15:00:59 -0800
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20151011153548.GA9808@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
Message-ID: <20160111230059.GA12286@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few months ago Debian users with QNAP devices (ARM Kirkwood)
reported issues (mostly SATA timeouts) when doing kernel upgrades,
specifically when the new ramdisk was being written to flash.

cat file > /dev/mtdblockX worked fine on a 2 MB flash partition but
resulted in SATA timeouts on a 9 MB flash partition.

flascp file /dev/mtd2 works fine.

I've now bisected it down to this change:

 commit 0461a4149836c792d186027c8c859637a4cfb11a
 Author: Mark Brown <broonie@kernel.org>
 Date:   Tue Dec 9 21:38:05 2014 +0000

     spi: Pump transfers inside calling context for spi_sync()

-- 
Martin Michlmayr
http://www.cyrius.com/
