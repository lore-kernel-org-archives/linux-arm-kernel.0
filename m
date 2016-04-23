From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 23 Apr 2016 07:18:15 -0700
Subject: [PATCH 4/8] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <20160423045248.GD6968@hector.attlocal.net>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-5-git-send-email-andy.gross@linaro.org>
 <20160422234105.GH3202@tuxbot>
 <20160423045248.GD6968@hector.attlocal.net>
Message-ID: <20160423141815.GL3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 21:52 PDT 2016, Andy Gross wrote:

> On Fri, Apr 22, 2016 at 04:41:05PM -0700, Bjorn Andersson wrote:
> > On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:
[..]
> > > diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> > > index 8e1eeb8..7d7b12b 100644
> > [..]
> > >  
> > > +static void qcom_scm_init(void)
> > > +{
> > > +	__qcom_scm_init();
> > > +}
> > > +
> > >  static int qcom_scm_probe(struct platform_device *pdev)
> > >  {
> > >  	struct qcom_scm *scm;
> > > @@ -208,6 +213,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
> > >  	__scm = scm;
> > >  	__scm->dev = &pdev->dev;
> > >  
> > > +	qcom_scm_init();
> > > +
> > 
> > Why don't you call __qcom_scm_init() directly here?
> 
> Yeah that would save some stack ops.
> 
> As a side note, what do you think about just making the first transaction on the
> scm-64 side do this init to figure out 32/64 calling convention?
> 
> That would eliminate this mess.
> 

We will have quite a bunch of entry points in this API, so it will
probably be messier to have them all call some potential-init function.

Perhaps if it's possible to push it to the __qcom_scm_call{,_atomic}.
But I'm not sure we want those to be more complicated just to save this
one call...

> > >  	return 0;
> > >  }
> > >  
> > > diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
> > [..]
> > > +#define QCOM_SCM_V2_EBUSY	-12
> > >  #define QCOM_SCM_ENOMEM		-5
> > >  #define QCOM_SCM_EOPNOTSUPP	-4
> > >  #define QCOM_SCM_EINVAL_ADDR	-3
> > > @@ -56,6 +58,8 @@ static inline int qcom_scm_remap_error(int err)
> > >  		return -EOPNOTSUPP;
> > >  	case QCOM_SCM_ENOMEM:
> > >  		return -ENOMEM;
> > > +	case QCOM_SCM_V2_EBUSY:
> > > +		return err;
> > 
> > I don't think return -ENOMEM is the right thing to do here.
> 
> -EBUSY?
> 

That seems better.

> > >  	return -EINVAL;
> > >  }

Regards,
Bjorn
