From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 16 Jan 2017 11:45:51 +0800
Subject: [PATCH v6 23/25] usb: chipidea: Pullup D+ in device mode via phy
 APIs
In-Reply-To: <148433778067.32719.6179204976256776867@sboyd-linaro>
References: <20161228225711.698-1-stephen.boyd@linaro.org>
 <20161228225711.698-24-stephen.boyd@linaro.org>
 <20170103065318.GB14542@b29397-desktop>
 <148418039309.32258.7247753739063801774@sboyd-linaro>
 <20170112095040.GA15726@b29397-desktop>
 <148426139182.20672.2422337338087784924@sboyd-linaro>
 <20170113033536.GA20723@b29397-desktop>
 <148433778067.32719.6179204976256776867@sboyd-linaro>
Message-ID: <20170116034551.GA27364@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 12:03:00PM -0800, Stephen Boyd wrote:
> Quoting Peter Chen (2017-01-12 19:35:36)
> > On Thu, Jan 12, 2017 at 02:49:51PM -0800, Stephen Boyd wrote:
> > > 
> > > With the boards I have, vbus is not routed to the phy. Instead, there's
> > > a vbus comparator on the PMIC where the vbus line from the usb
> > > receptacle is sent. The vbus extcon driver probes the comparator on the
> > > PMIC to see if vbus is present or not and then notifies extcon users
> > > when vbus changes.
> > > 
> > > The ULPI register we write in the phy is a vendor specific register
> > > (called MISC_A) that has two bits. If you look at
> > > qcom_usb_hs_phy_set_mode() in this series you'll see that we set
> > > VBUSVLDEXTSEL and VBUSVLDEXT. VBUSVLDEXTSEL controls a mux in the phy
> > > that chooses between an internal comparator, in the case where vbus goes
> > > to the phy, or an external signal input to the phy, VBUSVLDEXT, to
> > > consider as the "session valid" signal. It looks like the session valid
> > > signal drives the D+ pullup resistor in the phy. These bits in MISC_A
> > > don't matter when the phy is in host mode.
> > > 
> > > So when the board doesn't route vbus to the phy, we have to toggle the
> > > VBUSVLDEXT bit to signal to the phy that the vbus is there or not. I
> > > also see that we're not supposed to toggle the VBUSVLDEXTSEL bit when in
> > > "normal" operating mode. So perhaps we should do everything in the
> > > qcom_usb_hs_phy_set_mode() routine during the role switch as you
> > > suggest, except toggle the VBUSVLDEXT bit. Toggling the VBUSVLDEXT bit
> > > can be done via some new phy op when the extcon triggers?
> > 
> > Why not call phy_set_mode(phy, DEVICE) directly at ci_handle_vbus_change when
> > you get extcon vbus event?
> > 
> 
> Right, I can call phy_set_mode(phy, DEVICE) there, but is that correct?
> How do we signal vbus is gone, with phy_set_mode(phy, HOST)? Mode
> doesn't seem the same as "vbus status changed" so this feels wrong.


> So when the board doesn't route vbus to the phy, we have to toggle the
> VBUSVLDEXT bit to signal to the phy that the vbus is there or not. I
> also see that we're not supposed to toggle the VBUSVLDEXTSEL bit when in
> "normal" operating mode. So perhaps we should do everything in the
> qcom_usb_hs_phy_set_mode() routine during the role switch as you
> suggest, except toggle the VBUSVLDEXT bit. Toggling the VBUSVLDEXT bit
> can be done via some new phy op when the extcon triggers?

So, you need to call phy_set_mode when switching between host and device.
Besides, you also need to toggle VBUSVLDEXT when the external vbus
is on or off at device mode (doesn't need for host mode), is it correct?

At include/linux/usb/phy.h, we have .set_vbus interface, maybe you need
to port it to generic phy framework.

-- 

Best Regards,
Peter Chen
