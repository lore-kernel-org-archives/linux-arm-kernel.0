From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Jul 2013 23:15:05 +0200
Subject: [PATCH v1 0/4] ARM: STi fixes and ethernet support
In-Reply-To: <51DBE718.2080007@st.com>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
 <201307090956.03191.arnd@arndb.de> <51DBE718.2080007@st.com>
Message-ID: <201307092315.06131.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 July 2013, Srinivas KANDAGATLA wrote:
> On 09/07/13 08:56, Arnd Bergmann wrote:
> > No, you should be using generic interfaces to do the things you need.
> > 
> > I believe what you are missing is an ethernet phy driver that is specific
> > to your SoC.
> It looks interesting way to solve the issue.
> 
> Did you mean "Ethernet PHY"?
> 
> Ethernet PHY is not integrated in the STiH41x SoC, We use an external
> ICPLUS phy ( drivers/net/phy/icplus.c) for both B2000 and B2020 boards.
> As we can't have  two Ethernet phy drivers at the same time, I think the
> suggestion might not work in this case.
> 
> The callbacks in the mach level are setting up two SOC specific System
> Configuration registers which configures the MAC (like PHY interface
> selection, which is sampled during MAC reset assertion).

Ah, right.

> MAC used in STiH41x supports multiple PHY interfaces, so the PHY
> interface selection is driven by external signals wired up to System
> Configuration registers. The MAC driver is not aware of these System
> Configuration registers. So for non-DT case, stmmac driver provided
> callbacks to do things like this.
> 
> For DT case, At the moment I think callbacks at MACH level is one
> possible solution. But am open for any discussions.

Ok, so a PHY driver might not be the best place to put this, but it's
one option, since the PHY driver already has to know about the
interface speed you are setting.

Having a global "*_setup_ethernet" callback is definitely not the
right way to go. Please describe what the function actually does
so we can come up with the right subsystem to move that functionality
to. If you are setting clocks, you should use the clock subsystem,
for taking the device out of reset, you should use the reset controller
subsystem and for setting up the phy, you should use the phy subsystem,
etc.

	Arnd
