From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 06 Jan 2017 14:50:21 +0100
Subject: [PATCH net-next v4 0/4] Fix OdroidC2 Gigabit Tx link issue
In-Reply-To: <20170106114226.GX14217@n2100.armlinux.org.uk>
References: <1480348229-25672-1-git-send-email-jbrunet@baylibre.com>
 <049b1efc-3bad-92e0-45ef-0563dc5d81de@gmail.com>
 <20170105232508.GU14217@n2100.armlinux.org.uk>
 <1483697496.28003.40.camel@baylibre.com>
 <20170106114226.GX14217@n2100.armlinux.org.uk>
Message-ID: <1483710621.28003.74.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-01-06 at 11:42 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 06, 2017 at 11:11:36AM +0100, Jerome Brunet wrote:
> > 
> > The purpose of this patch is to provide a way to mark as broken a
> > particular eee mode. At first, it had nothing to do with "set_eee"
> > but,
> > as Florian rightly pointed out, users shouldn't be able to re-
> > enable a
> > broken mode.
> 
> I think something else has been missed - I don't see much point to
> telling userspace that (eg) 1000baseT EEE is supported and then
> ignore attempts to advertise it.
> 
> If it's broken, then arguably the hardware doesn't support the mode,
> so we should really be masking those bits from the EEE supported mask
> as well.

indeed.

> 
> > 
[...]
> 
> > 
> > > 
> > > ?- maybe the problem here is that the PCS doesn't support support
> > > EEE in 1000baseT mode?
> > 
> > 
> > It does, and that's kind of the problem. EEE in ON for 100Tx and
> > 1000T
> > by default with this PHY. I have several platform with the same
> > MAC-PHY?
> > combination. Only the OdroidC2 shows this particular issue with
> > 1000T-
> > EEE
> > 
> > As explained in other mails in this thread. The problem does not
> > come
> > from the MAC entering LPI. It actually comes from the link partner
> > entering LPI on the Rx path under significant Tx transfer. For some
> > reason, this completely mess up our PHY.
> 
> For a 1000baseT link to enter low power, both ends have to enter LPI
> (see 802.3 78.1.3.3.1) - the Tx and Rx paths can't independently
> enter
> LPI.
> 
> So, if you have a busy Tx link, the link itself can't be entering
> LPI.
> Your link partner may be sending a request to enter LPI due to its
> own
> Tx path being idle, which should then be forwarded to your MAC.
> 
> It's pretty hard to see what could be messed up with that - I'd have
> expected the problems to occur when both ends were idle and the link
> had entered low power mode.

Well, maybe I'm not explaining the issue very well. Here the test done
which led me to this conclusion:

The?test?are?done?using?iperf. Receiving data works well, with the
expected performance. Sending data is the problem, and only under high
load:

Here are the lpi stats before starting the test:
? ? ?irq_tx_path_in_lpi_mode_n: 6
?????irq_tx_path_exit_lpi_mode_n: 5
?????irq_rx_path_in_lpi_mode_n: 76
?????irq_rx_path_exit_lpi_mode_n: 75
?????phy_eee_wakeup_error_n: 0

Sending data with iperf usually works for little while (between 0 and
10s)

# iperf3 -c 192.168.1.170 -p12345
Connecting to host 192.168.1.170, port 12345
local 192.168.1.30 port 54450 connected to 192.168.1.170 port 12345
Interval???????????Transfer?????Bandwidth???????Retr??Cwnd
0.00-1.00???sec???112 MBytes???938 Mbits/sec????0????409 KBytes???????
1.00-2.00???sec???112 MBytes???940 Mbits/sec????0????426 KBytes???????
2.00-3.00???sec???112 MBytes???939 Mbits/sec????0????426 KBytes???????
3.00-4.00???sec???112 MBytes???940 Mbits/sec????0????426 KBytes???????
4.00-5.00???sec???112 MBytes???940 Mbits/sec????0????426 KBytes???????
5.00-6.00???sec???112 MBytes???939 Mbits/sec????0????426 KBytes???????
6.00-7.00???sec??9.26 MBytes??77.6 Mbits/sec????2???1.41 KBytes <=Issue
? ?
7.00-8.00???sec??0.00 Bytes??0.00 bits/sec????1???1.41 KBytes???????
8.00-9.00???sec??0.00 Bytes??0.00 bits/sec????0???1.41 KBytes???????
^C10.00-13.58??sec??0.00 Bytes??0.00 bits/sec????1???1.41 KBytes???????
- - - - - - - - - - - - - - - - - - - - - - - - -
Interval???????????Transfer?????Bandwidth???????Retr
0.00-13.58??sec???681 MBytes???421 Mbits/sec????4?????????????sender
0.00-13.58??sec??0.00 Bytes??0.00 bits/sec??????????????????receiver
iperf3: interrupt - the client has terminated

iperf3 does not exit ant the link seems completely broken. We cannot
send or receive until the interface is brought down then up again.

Here are the LPI related stats after the test:
?????irq_tx_path_in_lpi_mode_n: 48
?????irq_tx_path_exit_lpi_mode_n: 48
?????irq_rx_path_in_lpi_mode_n: 325
?????irq_rx_path_exit_lpi_mode_n: 325
?????phy_eee_wakeup_error_n: 0


This happens with :
1) Default configuration: EEE enabled on the MAC, PHY with reset
settings (EEE advertised)
2) EEE disabled on the MAC, PHY still with reset settings (EEE
advertised). In such case there is no irq_tx_path_*_lpi_mode interrupts
at all but still a lot of irq_rx_path_*_lpi_mode interrupts. So even if
the mac does not drive anything EEE related, there is still something
happening between the PHY and the link partner regarding EEE.

3) Disabling EEE advertisement for 1000t: no irq_*_lpi_mode@all. The
feature is not negotiated and the Tx works well.

By the way, EEE work well for the 100tx on the same HW.

> 
> > 
> > > 
> > > On the SolidRun boards, they're using AR8035, and have suffered
> > > this
> > > occasional link drop problem.??What has been found is that it
> > > seems
> > > to
> > > be to do with the timing parameters, and it seemed to only be
> > > 1000bT
> > > that was affected.??I don't remember off hand exactly which or
> > > what
> > > the change was they made to stabilise it though, but I can
> > > probabily
> > > find out tomorrow.
> > > 
> > 
> > Since the same combination of MAC-PHY works well on other designs,
> > it
> > is also my feeling that is has something to do with some timing
> > parameter, maybe related to this particular PCB.
> 
> Maybe a different PHY interface???Meson seems to use RGMII, maybe
> others use SGMII - but then I'd expect 100base-Tx to also be broken.
> So not really sure.

Nope, same interface (RGMII), same SoC. Only the PCB layout and
external components might be different.

> 
> I was talking to Florian about that last night, because the mis-named
> phy_init_eee() tests for various phy interface modes before
> proceeding,
> which seems to be fairly rubbish as the list of interface modes is
> gradually increasing since it was introduced (and I need to add SGMII
> to it.)??The conclusion I've come to there is that the test should
> never have been part of phylib, because if there are restrictions on
> which phy interface modes are allowable for EEE, they're likely to be
> either PHY or MAC specific.
> 
> The other problem that having the test there causes is that if the
> existing users can't handle EEE over SGMII, then when I add SGMII to
> support my hardware, they end up breaking - far from desirable.
> There's no information on why the test is there, or even which PHYs
> or MACs it's applicable to, which makes this unnecessarily more
> difficult to now resolve.
> 
> My feeling is that the integration of EEE into phylib is fairly poor
> at the moment, and we need to be a lot smarter about it.

You know a lot more than I do on this topic obviously. I'm just trying
to make GbE work (as cleanly as possible) on that board to be honest.

So I'm not sure I understand, are you against EEE integration in phylib
entirely, or specifically against the test I added in set_eee to filter
out broken modes ?

Since set_eee directly set the register, I don't see where else I could
have put this test to prevent EEE broken modes from being re-enabled.

> 
> BTW, one of the problems (not caused by your patch) is that changing
> the EEE advertisment does not (on all PHY drivers) cause the link to
> be renegotiated - there's no call to phy_start_aneg() when the advert
> changes, and even if there was, there's no guarantee that
> phy_start_aneg() will even set the AN restart bit in the control
> register.
> 
> However, given that you're hooking into the set_eee function, I'm not
> sure why you placed your EEE advertisment thing into config_aneg() -
> isn't it more an initialisation thing (so should be in
> config_init()?)

What I change is what the PHY advertise, so it seems logical to do it
where "genphy_config_advert" was called. Just taking the existing code
as an example

> 
