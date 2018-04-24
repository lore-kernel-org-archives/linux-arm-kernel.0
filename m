From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Apr 2018 18:45:07 +0100
Subject: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
Message-ID: <20180424174507.GI22073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 03:08:57PM -0700, David Collins wrote:
> On 04/19/2018 09:16 AM, Doug Anderson wrote:
> > On Wed, Apr 18, 2018 at 4:30 PM, David Collins <collinsd@codeaurora.org> wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > You'd need to ask Mark if he's OK with it, but a option #3 is to add a
> > patch to your series fix the regulator framework to try setting the
> > voltage if _regulator_get_voltage() fails.  Presumably in
> > machine_constraints_voltage() you'd now do something like:
> > 
> >   int target_min, target_max;
> >   int current_uV = _regulator_get_voltage(rdev);
> >   if (current_uV < 0) {
> >     /* Maybe this regulator's hardware can't be read and needs to be initted */
> >     _regulator_do_set_voltage(
> >       rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
> >     current_uV = _regulator_get_voltage(rdev);
> >   }
> >   if (current_uV < 0) {
> >     rdev_err(rdev,
> >       "failed to get the current voltage(%d)\n",
> >       current_uV);
> >       return current_uV;
> >   }

> > If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
> > but this needs to be documented _somewhere_ (unlike for bypass it's
> > not obvious, so you need to find someplace to put it).  I'd rather not
> > hack the DT to deal with our software limitations.

> I'm not opposed to your option #3 though it does seem a little hacky and
> tailored to the qcom_rpmh-regulator specific case.  Note that I think it
> would be better to vote for min_uV to max_uV than min_uV to min_uV though.

> Mark, what are your thoughts on the best way to handle this situation?

I think that's probably only OK if we have a specific error code for the
regulator being limited in this way otherwise our error handling for I/O
problems involves us trying to reconfigure supplies which seems like it
would be risky.  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/09cd228d/attachment.sig>
