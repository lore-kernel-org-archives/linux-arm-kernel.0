From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 2 Mar 2015 12:23:42 -0800
Subject: [PATCH v4 2/2] Input: bcm-keypad: Add Broadcom keypad controller
In-Reply-To: <54F4BC15.4020205@broadcom.com>
References: <sbranden@broadcom.com>
 <1425141357-7807-1-git-send-email-sbranden@broadcom.com>
 <1425141357-7807-3-git-send-email-sbranden@broadcom.com>
 <20150228221022.GA36282@dtor-ws> <20150228221518.GB36282@dtor-ws>
 <54F4BC15.4020205@broadcom.com>
Message-ID: <20150302202342.GE17094@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Scott,

On Mon, Mar 02, 2015 at 11:37:57AM -0800, Scott Branden wrote:
> Hi Dmitry,
> 
> I don't see the need for a check of the clock in bcm_kp_start or
> stop. See comment below.
> 
> On 15-02-28 02:15 PM, Dmitry Torokhov wrote:
> >On Sat, Feb 28, 2015 at 02:10:22PM -0800, Dmitry Torokhov wrote:
> >>Hi Scott,
> >>
> >>On Sat, Feb 28, 2015 at 08:35:57AM -0800, Scott Branden wrote:
> >>>+	/* Enable clock */
> >>>+
> >>>+	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
> >>>+	if (IS_ERR(kp->clk)) {
> >>>+		dev_info(&pdev->dev,
> >>>+			"No clock specified. Assuming it's enabled\n");
> >>
> >>I was doing the final pass before applying and I think that this is not
> >>quite correct, as it does not handle -EPROBE_DEFER properly which is
> >>quite common. I think we should do something like this:
> >>
> >>		error = PTR_ERR(kp->clk);
> >>		if (error != -ENOENT) {
> >>			if (error != -EPROBE_DEFER)
> >>				dev_err(.. "Failed to get clock" ...);
> >>			return error;
> >>		}
> >>		dev_dbg(... "No clock specified" ...);
> >>
> >>No need to resubmit if you are OK with this, I can make the change
> >>locally.
> >
> >Hmm, also bcm_kp_start() and bcm_kp_stop() should check if kp->clk is
> >valid before trying to enable/disable it.
> >
> I checked and other keyboard drivers do not check this.  I return an
> error in bcm_kp_start if the clk enable fails.  On stop, if the clk
> is not valid something is really, really wrong as well.

The other drivers simply abort probe() if they can't get clock, you
decided to allow probe() to finish and assume that clock is already
enabled, leaving kp->clk == ERR_PTR(-ENOENT) in your version. If you try
then calling clk_prepare_enable() with that pointer it is going to bomb,
that is why I said you need to check pointer validity in bcm_kp_start()
and bcm_kp_stop().

Thanks.

-- 
Dmitry
