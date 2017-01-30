From: jasmin@beck.ac (Jasmin Beck)
Date: Mon, 30 Jan 2017 17:03:39 +0100
Subject: mvneta MDIO problems
In-Reply-To: <20170130144407.GC25924@io.lakedaemon.net>
References: <1485351412.5441.82.camel@beck.ac>
 <20170130103628.09178f50@free-electrons.com>
 <20170130144407.GC25924@io.lakedaemon.net>
Message-ID: <1485792219.5441.164.camel@beck.ac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,
Hi Thomas,

thanks for your messages and the details regarding the report.

> Is there a kernel version where this problem does not exist? I.e is
> it a regression or an issue that always existed?

> Mine is currently running 4.8.6 with one patch on top for ath9k.??Let
> me know what kernel you want me to move to.

> It was also a problem with 4.2.8, which was the kernel I installed
> when I first stood up that box.

My testing-device is currently running 4.8.11-1~bpo8+1

There is another remote device, that I have not upgraded yet because of
this issue - it is still running 4.1.3-1~bpo8+1 with an uptime of
currently 66 days without experiencing the "link down" problem.
But it is not said, that this definitely means, that the issue is not
present in 4.1, because I had also experienced ~4-6 weeks uptime
without the issue on my testing-device here.
Possibly it is a regression in 4.2 and onwards, but not 100% sure.

> mvneta is not in charge of the MDIO bus, there's a separate mvmdio
> driver. Though it doesn't do anything in terms of HW initialization,?
> so I don't expect unloading/reloading this module to have any effect.

yes, I also supposed that this weekend because of the message:
>?[824281.528361] mvneta d0074000.ethernet eth1: cannot probe MDIO bus

So I just unloaded the module mvmdio, planning to insert some printk-
lines for obtaining more information... but unfortunately, unloading
mvmdio resulted in a NULL pointer exception/complete crash (even sysrq
through serial interface was not possible anymore) - possibly, this is
also a result of the "failed state"/the same bug, that leads to "link
down"?

> So it looks as if the PHY isn't responding anymore. Are you
> experiencing this on both network interfaces? Only one specifically?

> To date, I thought I was the only one, and that it was probably due
> to my funky printer that kicks down to 10MBit/half when in low power
> state.

It starts with occasionally link down/link up on eth0 or eth1, seems
"random". A link stays down for seconds, minutes (hours?) and then
comes back up.
After doing so for a while, the situation changes (-> failed state).
The links then either stay down or come up with 10M/Half-Duplex, but
being unable to transfer some data. Finally they go both down and stay
down.

When querying with ethtool in "failed state", it can not obtain any
information (I do not exactly remember the error message) - eth0 and
eth1 can behave differently regarding that in "failed state".

Furthermore, when trying "ip link set dev ethX up", eth0 and eth1 can
behave differently too. E.g. eth0 can state "NO-CARRIER" (ip link
show), and eth1 the mentioned "phy not found".

Currently, my box has an uptime of ?2 days, 16h and the process has
already started again with one link down/up:

[26727.775106] mvneta d0074000.ethernet eth1: Link is Down
[26729.851915] mvneta d0074000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off

It COULD be possible, that it depends on the cpu/network usage over
time... it *seems* to happen sooner after reboot since running a full
bitcoin-node on the testing-device, that constantly consumes network/io
and cpu time. But as the "time to first link down" varies a lot anyway,
this is possibly just coincidence.

> I reported it a month or so ago via irc, but at the time blamed the
> printer.??I'd love to dive in and fix it.

We both have kernel 4.8 installed, so comparing with 4.1 could be a
good start.

Or examining the "failed state" as soon as a box enters it - I can also
provide ssh-access to the serial-port of the testing device; please
just send your public key if you'd like to take a look at it.


Thanks & Regards
Jasmin


On Mon, 2017-01-30 at 14:44 +0000, Jason Cooper wrote:
> Hi Jasmin, Thomas,
> 
> On Mon, Jan 30, 2017 at 10:36:28AM +0100, Thomas Petazzoni wrote:
> > On Wed, 25 Jan 2017 14:36:52 +0100, Jasmin Beck wrote:
> 
> ...
> > > If you are interested in taking a look at the situation in
> > > "failed
> > > state", I can immediately provide ssh access to the serial
> > > console
> > > (though your ssh public key is needed in this case).
> > 
> > I don't think we ever had similar reports. I'm not personally
> > leaving
> > the Mirabox running for extended periods of time, so I've never
> > seen
> > this issue. We do have the Mirabox tested as part of kernelci.org,
> > but
> > it gets rebooted for every test, so we don't see this sort of
> > issue.
> > 
> > Jason, Andrew, maybe you are running Mirabox boards for extended
> > periods
> > of time? If so, have you seen a similar problem?
> 
> I do have a Mirabox running 24/7 and I've experienced the same issue.
> To date, I thought I was the only one, and that it was probably due
> to
> my funky printer that kicks down to 10MBit/half when in low power
> state.
> 
> I reported it a month or so ago via irc, but at the time blamed the
> printer.??I'd love to dive in and fix it.
> 
> Mine is currently running 4.8.6 with one patch on top for ath9k.??Let
> me know what kernel you want me to move to.
> 
> It was also a problem with 4.2.8, which was the kernel I installed
> when
> I first stood up that box.
> 
> thx,
> 
> Jason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6057 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/e9c90ccd/attachment-0001.bin>
