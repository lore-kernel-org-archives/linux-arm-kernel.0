From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 7 Feb 2012 09:49:52 +0530
Subject: Query: When will drv->poweroff() called
In-Reply-To: <201202061307.40628.rjw@sisk.pl>
References: <4F2F6B40.6070308@st.com> <201202061307.40628.rjw@sisk.pl>
Message-ID: <4F30A668.8010407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thanks Rafael.

On 2/6/2012 5:37 PM, Rafael J. Wysocki wrote:
> On Monday, February 06, 2012, Viresh Kumar wrote:
>> > 
>> > Hi Guys,
>> > 
>> > Sorry for asking this silly question, but i couldn't locate much
>> > help for it in documentation, so asking it.
>> > 
>> > We were testing hibernation for SPEAr13xx SoC family, based on
>> > ARM Cortex a9.
>> > 
>> > I observed that poweroff() callback of individual drivers are not
>> > getting called at all, while we test hibernate.
> They should be called in the last phase of hibernation, after the image
> has been created and the system is going for "power off" (hance the
> callback name).
> 
>> > I tried to go through the code to see what happened. It looked like
>> > there should be call to hibernation_set_ops() for platforms that are
>> > willing to get a call to poweroff() for their drivers.
> That's correct.  The ->poweroff() callbacks are only executed if
> hibernation_mode is equal to HIBERNATION_PLATFORM, which is not the
> default.
> 
>> > Otherwise shutdown of the busses gets called, which is a completely
>> > different path.
>> > 
>> > There are many drivers today, that are registering poweroff() from dev_pm_ops
>> > but are not doing bus specific shutdown stuff.
>> > 
>> > Even i tried to look for hibernation_set_ops() in kernel, and only acpi
>> > code is calling it.
> That's correct too.
> 
>> > I didn't understood how other ARM Sub-Arch's are handling this.
> Well, they are supposed to call hibernation_set_ops() and set the operations
> appropriately.  Those operations may be empty routines if they don't need
> to do anything, but they have to be defined.

Hi Amit,

Can you give some input on why none of the ARM platforms are calling
this routine currently.

-- 
viresh
