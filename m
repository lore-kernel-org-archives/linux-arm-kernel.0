From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 25 Feb 2014 10:47:41 +0100
Subject: [PATCH v2 0/6] ARM: STi reset controller support
In-Reply-To: <530C5D8C.1080809@st.com>
References: <1389696613-19683-1-git-send-email-srinivas.kandagatla@st.com>
 <1391437665-11913-1-git-send-email-srinivas.kandagatla@st.com>
 <1391592486.11239.4.camel@pizza.hi.pengutronix.de>
 <52F4D76F.8070301@st.com> <5304B849.2080806@st.com>
 <1393237988.3091.14.camel@pizza.hi.pengutronix.de>
 <530B514A.4070209@st.com>
 <1393254982.3091.44.camel@pizza.hi.pengutronix.de>
 <530C5D8C.1080809@st.com>
Message-ID: <1393321661.4156.2.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am Dienstag, den 25.02.2014, 09:08 +0000 schrieb srinivas kandagatla:
> On 24/02/14 15:16, Philipp Zabel wrote:
> > Hi Srinivas,
> > 
> > Am Montag, den 24.02.2014, 14:03 +0000 schrieb srinivas kandagatla:
> >> Thanks Philipp for your comments,
> >>
> >> On 24/02/14 10:33, Philipp Zabel wrote:
> >>>>> Did Srini's explanations convinced you?
> >>>>>
> >>>>> If so, could you queue the series for v3.15?
> >>> to be honest, I'm not comfortable with this explanation. If the
> >>> "powerdown" bits only gate the clocks to those modules, calling it a
> >>> reset control is clearly the wrong abstraction. If that is the case,
> >>> couldn't you handle those bits via the clock framework?
> >> I just had a re-look at the IPs specs for more information on where
> >> these power-down signals are actually terminating on the IP side.
> >>
> >> For example: ST-Synopsis Ethernet GMAC IP has two pins
> >> power_down_req[IN] and power_down_ack[OUT]. power_down_req is used by
> >> the software to either put the IP in powerdown or bring it out of
> >> powerdown state.
> > 
> > Now I'm a bit confused. There is no mention of GMAC in your patches,
> > and for ETH[01] they contain only the SOFTRESET bits. I have no issue
> > with the SOFTRESETs.
> Yes, GMAC was a bad example indeed. However this same logic applies to
> the USB IP as well.
> 
> GMAC power-down-reset can be added to the power-down-reset list for
> consistency.
> 
> We did not define the power-down-reset for GMAC because the reset state
> of GMAC will not be in power down. softreset should be enough to bring
> the IP in to a usable state. So the software never drives the power
> down-request but instead uses softreset in this particular case.
> 
> > 
> >> The IP itself drives power_down_ack to indicate when the power down
> >> request is successfully finished. For power_down/power_up request the IP
> >> will change the internal state accordingly including powering up/down
> >> its internal blocks and/or clock gating.
> >>
> >>> If on the other hand these powerdown bits also trigger reset machinery,
> >>> such that asserting and deasserting that bit will change the module's
> >>> internal state, I could be convinced to queue them like this.
> >> This is true with ST IPs, these lines change the state of the IP as
> >> described above. Reset framework seems to fits in very well with this
> >> behavior rather than power-domains or clock framework.
> > 
> > If you put the IP in power down when it is idle, and then power it up
> > again, will the IP registers have kept their previous state?
> No, the context is lost, the IP needs re-initialization.

alright then, I'll add them to the queue.

thanks
Philipp
