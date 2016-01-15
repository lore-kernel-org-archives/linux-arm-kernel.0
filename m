From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 15 Jan 2016 23:08:41 +0100
Subject: [PATCH RFC 08/27] PM / Domains: Support IRQ safe PM domains
In-Reply-To: <20160115165758.GC1651@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-9-git-send-email-lina.iyer@linaro.org>
 <CAPDyKFoKpgURMYoepWH0TNK1=bFp4uyQCHUSnPiXmLxC7BNyRA@mail.gmail.com>
 <20160114183316.GB1651@linaro.org>
 <CAPDyKFpj0Gv=5hVwZWjmgmumHPriuYk+LLVBwjEeW9Jfj8p5Kw@mail.gmail.com>
 <20160115165758.GC1651@linaro.org>
Message-ID: <CAPDyKFo4qe8THwJQd1aNQwpbjV1phOGKz_gEuP-wRD6Dgtx0pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> I think case 2 and case 3 should be okay to support, but I am really
>> questioning case 1.
>>
> With you other patch, it does make sense to have 2 and 3 instead of 1
> and 2.

Okay!

> My only concern is as I view the SoC as a whole, there would be cases
> where the parent domain could only be non-IRQ safe (turning off a big
> regulator may require some sleep) and the subdomains are quicker and
> faster IRQ-safe domains. Putting up this restriction, chops up the

Just because they are "quick" (don't sleep) doesn't mean they have to
set the IRQ safe flag for the domain.

Let's compare how pm_runtime_irq_safe() is used for devices in
drivers. Lots of corresponding runtime PM callbacks don't sleep, but
that don't mean that the driver calls pm_runtime_irq_safe().

Drivers that are expecting to invoke pm_runtime_get_sync() (or other
synchronous runtime PM API) from atomic context, requires the
corresponding runtime PM callbacks to be IRQ safe. Only under these
circumstances the pm_runtime_irq_safe() is used.

> domain hierarchy. Imagine, if you could represent the whole power domain
> organization in DT, but because of this restriction, we may not be able
> to do that.

You do have a point. Considering my comment above, do you still think
this may become an issue?

Kind regards
Uffe
