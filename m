From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Aug 2016 13:28:03 +0100
Subject: [PATCH RFC 4/5] drm/bridge: add dw-hdmi cec driver using Hans
 Verkil's CEC code
In-Reply-To: <57BC0337.2080203@xs4all.nl>
References: <20160812141421.GB1041@n2100.armlinux.org.uk>
 <E1bYDEs-0004rs-FP@rmk-PC.armlinux.org.uk>
 <57BC0337.2080203@xs4all.nl>
Message-ID: <20160831122802.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 10:03:03AM +0200, Hans Verkuil wrote:
> Hi Russell,
> 
> On 08/12/16 16:15, Russell King wrote:
> > +	ret = devm_request_threaded_irq(&pdev->dev, cec->irq,
> > +					dw_hdmi_cec_hardirq,
> > +					dw_hdmi_cec_thread, IRQF_SHARED,
> > +					DEV_NAME, cec->adap);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = cec_register_adapter(cec->adap);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * CEC documentation says we must not call cec_delete_adapter
> > +	 * after a successful call to cec_register_adapter().
> > +	 */
> > +	devm_remove_action(&pdev->dev, dw_hdmi_cec_del, cec);
> > +
> > +	hdmi_register_notifier(&cec->nb);
> 
> The notifier is registered here, but who provides CEC with the initial
> physical address? As I understand it, it only tells you when things change,
> not what the initial state is.

Correct, that's a short-coming of this.  Solving that is not really
an easy problem - the hdmi notifiers don't track the state (they
aren't really aware of state themselves), nor do they track who the
originator of the messages is (again, because they don't track state.)

Fixing that requires a much more complex solution - I don't think I've
time to solve that (as illustrated by this reply taking over a week.)

So, we can either decide that we're not going to merge any CEC drivers
and other HDMI audio drivers until we solve this problem, denying people
the ability to use CEC, or we can merge what we have now and work on
solving the problem later.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
