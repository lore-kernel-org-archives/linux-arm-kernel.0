From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 17 Nov 2016 22:48:37 +0100
Subject: [PATCH net 1/3] net: phy: realtek: add eee advertisement
 disable options
In-Reply-To: <CANAwSgTB5=8tVj1FrZF3EgjK5mjUMwLYb90NeWSFDCsRjsuB6A@mail.gmail.com>
References: <1479220154-25851-1-git-send-email-jbrunet@baylibre.com>
 <1479220154-25851-2-git-send-email-jbrunet@baylibre.com>
 <CANAwSgTjG8G0U+A1p7hOKND9rjY4BzZfPgyWWHAEryYkHj_UOw@mail.gmail.com>
 <1479378055.17538.57.camel@baylibre.com>
 <CANAwSgTB5=8tVj1FrZF3EgjK5mjUMwLYb90NeWSFDCsRjsuB6A@mail.gmail.com>
Message-ID: <1479419317.17538.75.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-11-17 at 23:30 +0530, Anand Moon wrote:
> Hi Jerone,
> 
> > > How about adding callback functionality for .soft_reset to handle
> > > BMCR
> > > where we update the Auto-Negotiation for the phy,
> > > as per the datasheet of the rtl8211f.

I think BMCR is already pretty well handled by the genphy, don't you
think ?

> > 
> > I'm not sure I understand how this would help with our issue (and
> > EEE).
> > Am I missing something or is it something unrelated that you would
> > like
> > to see happening on this driver ?
> > 
> [snip]
> 
> I was just tying other phy module to understand the feature.
> But in order to improve??the throughput I tried to integrate blow u-
> boot commit.
> 
> commit 3d6af748ebd831524cb22a29433e9092af469ec7
> Author: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> Date:???Thu Mar 12 18:54:59 2015 +0800
> 
> ????net/phy: Add support for realtek RTL8211F
> 
> ????RTL8211F has different registers from RTL8211E.
> ????This patch adds support for RTL8211F PHY which
> ????can be found on Freescale's T1023 RDB board.
> 
> And added the similar functionality to??.config_aneg????=
> &rtl8211f_config_aneg,
> 

I assume this is the commit you are referring to :?
http://git.denx.de/?p=u-boot.git;a=commit;h=3d6af748ebd831524cb22a29433
e9092af469ec7

I tried looking a this particular commit and the other ones in
realtek.c history of u-boot. I don't really see what it does that linux
is not already doing.

> And I seem to have better results in through put with periodic drop
> but it recovers.
> -----
> odroid at odroid64:~$ iperf3 -c 10.0.0.102 -p 2006 -i 1 -t 100 -V
> iperf 3.0.11
> Linux odroid64 4.9.0-rc5-xc2ml #18 SMP PREEMPT Thu Nov 17 22:56:00 

[...]

> 
> Test Complete. Summary Results:
> [ ID] Interval???????????Transfer?????Bandwidth???????Retr
> [??4]???0.00-100.00 sec??10.5 GBytes???902
> Mbits/sec????4?????????????sender
> [??4]???0.00-100.00 sec??10.5 GBytes???902
> Mbits/sec??????????????????receiver
> CPU Utilization: local/sender 5.6% (0.2%u/5.4%s), remote/receiver
> 17.1% (1.2%u/15.9%s)
> 

That's the kind of throughput we have on the C2 once the link is
reliable (with EEE switch off for GbE)

> Can your confirm this at your end.
> Once confirm I will try to send this as a fix for this issue.
> 

I'm testing the code to disable EEE in a generic way. I'll post the RFC
for it asap.

> -Best Regards
> Anand Moon
