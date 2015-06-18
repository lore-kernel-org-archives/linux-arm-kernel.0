From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 18 Jun 2015 09:02:10 +0200
Subject: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
In-Reply-To: <20150617200346.GC23268@linaro.org>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
 <20150617200346.GC23268@linaro.org>
Message-ID: <CAPDyKFp4Bh2C5PNNJS3bUqDLADS6MKTfH8UCzbm3c-ofbVOWow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> @@ -671,32 +475,29 @@ static int pm_genpd_runtime_suspend(struct device
>> *dev)
>>         if (IS_ERR(genpd))
>>                 return -EINVAL;
>>
>> +       /*
>> +        * We can't allow to power off the PM domain if it holds an
>> irq_safe
>> +        * device. That's because we use mutexes to protect data while
>> power
>> +        * off and on the PM domain, thus we can't execute in atomic
>> context.
>> +        */
>> +       if (dev->power.irq_safe)
>> +               return -EBUSY;
>> +
>
> This check will prevent the device from being saved/stopped. This should
> be allowed. Its the mutex_lock(&genpd->lock) below that would be a
> problem, if the device is IRQ safe. But that happens only after the
> device is stopped.

Yes, as we discussed around your patch in [1].

Earlier we could invoke the ->stop|start() callbacks for an IRQ
safe device. This version of $subject patch prevents that.

I am working on a v4, that brings back that functionality, but we can
actually do more. As from the changes in $subject patch, we don't need
to hold the mutex while invoking the runtime PM callbacks for a
device. This enables us to invoke them for IRQ safe devices, yet
another positive side effect.

>
> I am inclined to think that the existing check below is the correct
> place to check. Let me know if I am missing something.
>

You are correct.

Still, as I intend to invoke the runtime PM callbacks for IRQ safe
devices some minor change is also needed in pm_genpd_runtime_resume().

[...]

Kind regards
Uffe

[1]
http://www.spinics.net/lists/arm-kernel/msg425162.html
