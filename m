From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 2 Jul 2012 13:22:45 -0500
Subject: [PATCH] gpio/omap: fix invalid context restore of gpio bank-0
In-Reply-To: <20120701084540.GK4202@atomide.com>
References: <1340990551-19426-1-git-send-email-jon-hunter@ti.com>
 <CAMQu2gx+tCujB0a+2zL8RGdJe5Y2VLPOyPUOPkys3VS7JdaKbg@mail.gmail.com>
 <20120701084540.GK4202@atomide.com>
Message-ID: <4FF1E6F5.9080402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/01/2012 03:45 AM, Tony Lindgren wrote:
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120629 21:23]:
>> On Fri, Jun 29, 2012 at 10:52 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>> Currently the gpio _runtime_resume/suspend functions are calling the
>>> get_context_loss_count() platform function if the function is populated for
>>> a gpio bank. This function is used to determine if the gpio bank logic state
>>> needs to be restored due to a power transition. This function will be populated
>>> for all banks, but it should only be called for banks that have the
>>> "loses_context" variable set. It is pointless to call this if loses_context is
>>> false as we know the context will never be lost and will not need restoring.
>>>
>>> For all OMAP2+ devices gpio bank-0 is in an always-on power domain and so will
>>> never lose context. We found that the get_context_loss_count() was being called
>>> for bank-0 during the probe and returning 1 instead of 0 indicating that the
>>> context had been lost. This was causing the context restore function to be
>>> called at probe time for this bank and because the context had never been saved,
>>> was restoring an invalid state. This ultimately resulted in a crash [1].
>>>
>>> There are multiple bugs here that need to be addressed ...
>>>
>>> 1. Why the always-on power domain returns a context loss count of 1? This needs
>>>   to be fixed in the power domain code. However, the gpio driver should not
>>>   assume the loss count is 0 to begin with.
>> Indeed. GPIO driver should not assume the value.
>>
>>> 2. The omap gpio driver should never be calling get_context_loss_count for a
>>>   gpio bank in a always-on domain. This is pointless and adds unneccessary
>>>   overhead.
>> Make sense too.
>>
>>> 3. The OMAP gpio driver assumes that the initial power domain context loss count
>>>   will be 0 at the time the gpio driver is probed. However, it could be
>>>   possible that this is not the case and an invalid context restore could be
>>>   performed during the probe. To avoid this otherwise only populated the
>>>   get_context_loss_count() function pointer after the initial call to
>>>   pm_runtime_get() has occurred. This will ensure that the first
>>>   pm_runtime_put() initialised the loss count correctly.
>>>
>>> This patch addresses issues 2 and 3 above.
> 
> Should this one be Cc: stable? If this is a regression, then the regression
> causing commit should be mentioned.

So that raises a good point. Looking at the stable branch (3.4.4) it is
missing 3 other fixes too [1][2][3]. So this particular problem would
not have been exposed, however, I am wondering if there are other
problems lingering there.

This is a regression is exposed by [2]. I should add that to the changelog.

Cheers
Jon

[1]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b3c64bc30af67ed328a8d919e41160942b870451
[2]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1b1287032df3a69d3ef9a486b444f4ffcca50d01
[3]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=22770de11cb13e7120f973bca6c800de371a6717
