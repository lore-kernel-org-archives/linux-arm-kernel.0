From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 24 Oct 2014 09:45:24 -0700
Subject: [RFC 6/7] mfd: qcom-smd-rpm: Driver for the Qualcomm RPM over SMD
In-Reply-To: <20141020072211.GC25349@x1>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-7-git-send-email-bjorn.andersson@sonymobile.com>
 <20141008084017.GD20647@lee--X1>
 <20141017135553.GA28882@sonymobile.com> <20141020072211.GC25349@x1>
Message-ID: <20141024164523.GH28611@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 20 Oct 00:22 PDT 2014, Lee Jones wrote:

> On Fri, 17 Oct 2014, Bjorn Andersson wrote:
> > On Wed 08 Oct 01:40 PDT 2014, Lee Jones wrote:
> 
> [...]
> 
> > > > +static struct qcom_smd_driver qcom_smd_rpm_driver = {
> > > > +	.probe = qcom_smd_rpm_probe,
> > > > +	.remove = qcom_smd_rpm_remove,
> > > > +	.callback = qcom_smd_rpm_callback,
> > > > +	.driver  = {
> > > > +		.name  = "qcom_smd_rpm",
> > > > +		.owner = THIS_MODULE,
> > > > +		.of_match_table = qcom_smd_rpm_of_match,
> > > > +	},
> > > > +};
> > > > +
> > > > +module_qcom_smd_driver(qcom_smd_rpm_driver);
> > > 
> > > I don't like this.  What's wrong with the existing platform driver
> > > code?
> > > 
> > 
> > I started off with having smd child devices as platform drivers and had some
> > accessor functions to find the open handles that triggered the probe() and
> > register the callback with those. But this didn't feel very sane, so I did
> > implemented a custom driver struct and probe prototype to simplify writing
> > drivers.
> > 
> > May I ask why you dislike this? This is how it's done in so many other places
> > in the kernel...
> 
> I don't believe that's the case.  All owners of their own
> module_*_driver() registration calls are busses (see below), whereas
> 'qcom_smd' is just a driver.  Things would soon get out of control if
> we allowed every driver in the kernel to supply their own driver
> registration information variants.
> 

I modelled this after rpmsg, with the intention of having qcom_smd provide a
"smd bus" and all client drivers sitting on that bus being probed and removed
as the remote services appear and disappear.

I'm afraid I don't understand what part I missed that makes my smd driver "just
a driver". I will reread the documentation and try to figure out what I might
have missed.

Regards,
Bjorn
