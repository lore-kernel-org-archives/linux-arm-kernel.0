From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 14 Jun 2017 09:53:39 +0800
Subject: [PATCH v15 2/7] power: add power sequence library
In-Reply-To: <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
 <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
Message-ID: <20170614015338.GA4635@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 12:24:42PM +0200, Ulf Hansson wrote:
> [...]
> 
> > +
> > +/**
> > + * of_pwrseq_on - Carry out power sequence on for device node
> > + *
> > + * @np: the device node would like to power on
> > + *
> > + * Carry out a single device power on.  If multiple devices
> > + * need to be handled, use of_pwrseq_on_list() instead.
> > + *
> > + * Return a pointer to the power sequence instance on success,
> > + * or an error code otherwise.
> > + */
> > +struct pwrseq *of_pwrseq_on(struct device_node *np)
> > +{
> > +       struct pwrseq *pwrseq;
> > +       int ret;
> > +
> > +       pwrseq = pwrseq_find_available_instance(np);
> > +       if (!pwrseq)
> > +               return ERR_PTR(-ENOENT);
> 
> In case the pwrseq instance hasn't been registered yet, then there is
> no way to deal with -EPROBE_DEFER properly here.
> 
> I haven't been following the discussions in-depth during all
> iterations, so perhaps you have already discussed why doing it like
> this.

Yes, it has been discussed. In order to compare with compatible string
at dts, we need to have one registered pwrseq instance for each
pwrseq library, this pre-registered one is allocated using
postcore_initcall, and the new (eg, second) instance is registered
after pwrseq_get has succeeded.

Peter

> 
> Anyway, that means all pwrseq instances needs to be registered an
> early boot level, to be safe. To me, that seems like poor design
> choice.
> 
> Otherwise I think this looks okay to me.
> 

-- 

Best Regards,
Peter Chen
