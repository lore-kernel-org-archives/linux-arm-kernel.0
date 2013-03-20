From: ryan@presslab.us (Ryan Press)
Date: Wed, 20 Mar 2013 16:57:30 -0700
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the
 timer 0
In-Reply-To: <20130320182702.3dc3fa20@skate>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
 <CABx3TkU=y5_WTojbc9z17csaUh4PYxDUszdCdpWhmDM-JUEt5g@mail.gmail.com>
 <20130320182702.3dc3fa20@skate>
Message-ID: <CABx3TkXH_sFzgFkpoZRUkDywsHsMWbTYN-cA=BhvK9y4ogzgOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Mar 20, 2013 at 10:27 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Ryan Press,
>
> On Wed, 20 Mar 2013 09:44:42 -0700, Ryan Press wrote:
>
>> I can confirm this patch works for me as well.  I still have the
>> problem on my Globalscale Mirabox where only a forced 10Mb link works
>> on tx/rx.  With 100Mb only rx works, and 1Gb neither works.
>
> Did you test both network interfaces? Do you have the problem on both?
> I know there are issues on the Mirabox with the network interface that
> wasn't initialized by U-Boot (i.e if you tftp your kernel from
> interface 0, interface 0 works fine in Linux but not interface 1, if
> your tftp your kernel from interface 1, it's the opposite).

Ah, yes, so when I initialize the controller in U-Boot by attempting a
tftp download (and then just ctrl-c out) before booting then I get 1Gb
link.  At first I suspected the PHY registers being different, but I
dumped the registers when working vs non-working and they seemed the
same, but hard to know for sure.  Then I dumped some of the MAC
registers and I see that 0x2410 is different, it shows that
MVNETA_GMAC_RX_FLOW_CTRL_ENABLE and MVNETA_GMAC_TX_FLOW_CTRL_ENABLE
(working 0x2c3b vs non-working 0x2401) bits are set when it is
working.  0x2410 is just a status word and I don't know how to turn
the flow control on otherwise, and probably there is more than this
needed.

Thanks,
Ryan
