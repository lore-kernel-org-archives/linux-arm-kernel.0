From: collinsd@codeaurora.org (David Collins)
Date: Tue, 24 Apr 2018 14:09:47 -0700
Subject: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180424174507.GI22073@sirena.org.uk>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
Message-ID: <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2018 10:45 AM, Mark Brown wrote:
>>> You'd need to ask Mark if he's OK with it, but a option #3 is to add a
>>> patch to your series fix the regulator framework to try setting the
>>> voltage if _regulator_get_voltage() fails.  Presumably in
>>> machine_constraints_voltage() you'd now do something like:
>>>
>>>   int target_min, target_max;
>>>   int current_uV = _regulator_get_voltage(rdev);
>>>   if (current_uV < 0) {
>>>     /* Maybe this regulator's hardware can't be read and needs to be initted */
>>>     _regulator_do_set_voltage(
>>>       rdev, rdev->constraints->min_uV, rdev->constraints->min_uV);
>>>     current_uV = _regulator_get_voltage(rdev);
>>>   }
>>>   if (current_uV < 0) {
>>>     rdev_err(rdev,
>>>       "failed to get the current voltage(%d)\n",
>>>       current_uV);
>>>       return current_uV;
>>>   }
> 
>>> If Mark doesn't like that then I guess I'd be OK w/ initting it to 0
>>> but this needs to be documented _somewhere_ (unlike for bypass it's
>>> not obvious, so you need to find someplace to put it).  I'd rather not
>>> hack the DT to deal with our software limitations.
> 
>> I'm not opposed to your option #3 though it does seem a little hacky and
>> tailored to the qcom_rpmh-regulator specific case.  Note that I think it
>> would be better to vote for min_uV to max_uV than min_uV to min_uV though.
> 
>> Mark, what are your thoughts on the best way to handle this situation?
> 
> I think that's probably only OK if we have a specific error code for the
> regulator being limited in this way otherwise our error handling for I/O
> problems involves us trying to reconfigure supplies which seems like it
> would be risky.  

Would you be ok with -EAGAIN being used for this purpose?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
