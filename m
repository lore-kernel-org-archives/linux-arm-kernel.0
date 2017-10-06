From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 6 Oct 2017 09:29:57 +0200
Subject: Questions about bluetooth on N900
In-Reply-To: <20171001145051.7pyzz4bpodkd6i2b@earth>
References: <87tvzow7jv.fsf@sange.fi>
 <20170927160611.GA10775@xo-6d-61-c0.localdomain>
 <87h8vkpvtu.fsf@sange.fi> <20171001090133.GA16848@amd>
 <20171001145051.7pyzz4bpodkd6i2b@earth>
Message-ID: <20171006072957.GA18994@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > >  > There is some interest. I'd like to have working bluetooth, and people from postmarketos
> > >  > would probably like something, too. Unfortunately my experience is same as yours -- current
> > >  > mainline does not work well on N900.
> > > 
> > > I might try debugging that at some point, but I doubt I can resolve the issue,
> > > because I have no experience in serial port programming. With latest BlueZ I
> > > got my braille display working for few seconds, before it stalled.
> > > 
> > >  > > I'm considering to rebase the old hci_h4p driver on current mainline, because
> > >  > > I just need a working BT connection, not code that is of good quality. Some
> > > 
> > >  > Ok, I may save you some work. I have rebased version, it should be in
> > >  > linux-n900 on kernel.org.
> > > 
> > > I found a repo from
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/pavel/linux-n900/. I
> > > assume that's what you meant.
> > > 
> > > The latest version is based on 4.13, but it has also some changes which seem
> > > not to be related to BT. I incorporated them also, but I don't know if they
> > > are valid.
> > 
> > Feel free to take those or not.
> > 
> > > I was lucky that you had done rebasing of nokia_h4p, because I wouldn't have
> > > known what to do with DTS.
> > > 
> > > Unfortunately the driver does not work properly. I can access N900 to some
> > > extent with my braille display, but the connection has random freezes, and
> > > accessing my GPS receiver (through RFCOMM) causes the whole system to hang.
> > > 
> > > I get the following message to syslog something like 100 times per second when
> > > BRLTTY (the braille display daemon) is communicating with the display:
> > > Got IIR_RX_TIMEOUT, handling it as IIR_DRI
> > > 
> > > Active BT connection also seems to trigger a bug in nokia_h4p related to
> > > spinlocks. This happens in random intervals between 0.1 s and 30 s.
> > > 
> > > The bugs are:
> > > BUG: scheduling while atomic
> > > and
> > > BUG: workqueue leaked lock or atomic
> > > 
> > > Stack traces suggest that it is (at least sometimes) caused by h4p_set_clk
> > > calling clk_prepare_enable and clk_disable_unprepare functions, which should
> > > only be used in non-atomic context.
> > > 
> > > So, I thought it would be good for you to know that BT does not really work. I
> > > would like to work on this, but I'm afraid my knowledge is too limited to
> > > track this down. It would be good to know what is causing those IIR RX
> > > timeouts.
> > > 
> > > Also working on an obsolete driver feels like stupid now that there is a
> > > driver written more properly.
> > 
> > Yes, fixing obsolete driver is hard and has drawbacks. The new one
> > should be fixed.
> > 
> > I believe the way forward would be
> > 
> > a) add logging to the old driver, to see exact data being exchanged
> > during initialization.
> > 
> > b) add logging to the new driver, and compare old and new driver
> > 
> > c) fix the new driver to do the initialization same way the old driver
> > did
> 
> FWIW I don't think the problem on N900 with hci_nokia ("new") driver is
> related to incorrect data/packets being sent. I'm pretty sure there is
> still some problem with the handling of flow control signals (RTS/CTS +
> the GPIOs) resulting in packets not being sent and/or received properly.

Yes, that's possible. So logging RTS/CTS + gpio transitions along with
data will be useful.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171006/83ed2b83/attachment-0001.sig>
