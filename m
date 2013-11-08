From: zonque@gmail.com (Daniel Mack)
Date: Fri, 08 Nov 2013 08:59:33 +0100
Subject: [PATCH v5] ARM: omap: edma: add suspend suspend/resume hooks
In-Reply-To: <87siv7pxpp.fsf@linaro.org>
References: <1383863549-7438-1-git-send-email-zonque@gmail.com>
 <87siv7pxpp.fsf@linaro.org>
Message-ID: <527C99E5.9020305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2013 01:02 AM, Kevin Hilman wrote:
> Daniel Mack <zonque@gmail.com> writes:

>> +	.resume_noirq	= edma_pm_resume,
>> +};
> 
> Also, I believe it was already suggested by Nishanth, but the late/early
> callbacks are probably more appropriate here than the noirq callbacks.
> Unless there's a *really* good reason to use the noirq callbacks, they
> should be avoided.

Ok, no problem to change that. Regarding the function ordering,
late/early didn't show any lockup in my tests yet.

> That being said, I wonder if the whole approach here is the right one.
> I know you're basing your stuff on some TI tree, but that doesn't make
> it the right way (usually, it's the opposite, but I digress...)  ;)

:)

Well, I was primarily looking for a solution to bring the edma back to
life after suspend. As I wrote in the first version of this patch that I
sent, I didn't even intent that patch to go mainline at all, given that
arch/arm/common/edma.c woill go away soon.

> IMO, EDMA should be done like we currently do I2C and not implement
> suspend/resume at all.  Instead, the driver should do runtime PM done on
> a per xfer basis.  Then when suspend comes along, all that needs to be
> done is ensure all in-flight xfers are done, then runtime PM will kick
> in.

I see your point in general, but isn't runtime PM there to actually save
power at runtime? Does disabling unused channels in the EDMA really
reduce the consumption of that IP block?


Daniel
