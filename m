From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Fri, 08 Jul 2016 12:55:12 +0300
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
Message-ID: <577f7881.c90f190a.7312d.03c2@mx.google.com>
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
> > Unfortunately it seems to hit the crypto performance too.
> > The command "cryptsetup benchmark --cipher aes-cbc"
> > gives me around 35 MiB/s instead of 50 MiB/s.
> > 
> > The patch did not fix the hanging which appears instantly after enabling tdma
> > in the driver and running some crypto operation.
>
> I don't understand. Above you're saying that it fixes the problem, and
> now you're saying that it doesn't.

I'm sorry that ambiguity.
As I wrote to bugzilla (link above), there might be two different problems.

1. Without patching (Linux 4.4.10 -version):
"Cryptsetup benchmark never completes and the device locks up."
This happens always and instantly.

I found a workaround for this first problem. If I disable tdma on driver,
I can run successfully some crypto tasks (with quite poor performance),
including cryptsetup benchmark. Then I found the second problem.

2. After disabling tdma (patch provided on bugzilla):
"The device still hangs after a couple of crypto tasks, e.g. when writing a few
hundred MiB of data to btrfs which is on top of luks."

Your c5379ba8 -commit fixed the second problem for me.
Still I have the first problem when tdma is enabled.

> Could you test with the latest 4.7-rc kernel + the patch I provided?

Yes, I will.

Thanks,

Jussi
