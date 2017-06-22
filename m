From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Jun 2017 20:25:59 +0800
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170622080730.o352kxrs5pz7wxnf@ninjato>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250> <20170620074126.GA1541@katana>
 <20170622074831.GA23753@dragon>
 <20170622080730.o352kxrs5pz7wxnf@ninjato>
Message-ID: <20170622122558.GB23753@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 10:07:30AM +0200, Wolfram Sang wrote:
> 
> > The audio codec is on address 0x22.
> > 
> > Why do you think it should be broken now?
> 
> Because I thought that we skipped the error handling for every transfer
> when we removed the call to reset_hardware from the xfer function.
> 
> So, either it still works because the transfer times out. But then
> i2cdetect should be really slow. The timeout is set to 1s, so it should
> take 1s to scan every address.
> 
> Or I am completely missing something. Then, I am sorry for the noise.

It's me who is missing something.  You are right.  With the current
driver, i2cdetect takes 1s to scan most addresses.  Except address 0x22,
those devices detected on other addresses are just wrong, and the
addresses vary from a scan to another.

With the proper error handling, i2cdetect now works very fast and only
gets audio codec on 0x22, which is correct.

$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --                         

Thanks a lot for identifying the bug.

Shawn
