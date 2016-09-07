From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 7 Sep 2016 11:46:13 +0530
Subject: [PATCH 7/8] iommu: of: Handle IOMMU lookup failure with deferred
 probing or error
In-Reply-To: <1c5dde1d-1ffb-d045-c090-032b9f1c7de2@samsung.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
 <CAAFQd5C8BuOCc5ySw_3tVELDG4S+r_5VyDvOPnBBuVr-6CBfxg@mail.gmail.com>
 <000901d1f4af$e26b6c00$a7424400$@codeaurora.org>
 <1c5dde1d-1ffb-d045-c090-032b9f1c7de2@samsung.com>
Message-ID: <002c01d208cf$598d4a50$0ca7def0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

>Hi Sricharan,
>
>
>On 2016-08-12 17:40, Sricharan wrote:
>> Hi Tomaz,
>>
>>>> +               if (ops->add_device)
>>>> +                       ops = ops->add_device(dev) ? ops : NULL;
>>> Patch description fails to mention anything about this change. Also it
>>> looks slightly incorrect to lose the error condition here. I think we
>>> should at least print some error message here and tell the user that
>>> we are falling back to non-IOMMU setup.
>>      Ok, will have to improve the patch description to add this and will
>>      fix the error value as well. Will also add the remove_device during
>>       deconfigure as well.
>>
>>>
>>>>                  of_node_put(np);
>>>>                  idx++;
>>>> @@ -200,7 +213,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>>
>>>>   err_put_node:
>>>>          of_node_put(np);
>>>> -       return NULL;
>>>> +       return ops;
>>>>   }
>>>>
>>>>   void __init of_iommu_init(void)
>>>> @@ -211,7 +224,7 @@ void __init of_iommu_init(void)
>>>>          for_each_matching_node_and_match(np, matches, &match) {
>>>>                  const of_iommu_init_fn init_fn = match->data;
>>>>
>>>> -               if (init_fn(np))
>>>> +               if (init_fn && init_fn(np))
>>> When is it possible to have NULL init_fn?
>>     ya wrong, should not be needed.
>
>init_fn can be NULL if you convert IOMMU driver to use platform device
>infrastructure based initialization and you don't need to do anything
>before the driver gets probed, so please keep this check.
>
>I used this approach here:
>https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/commitdiff/a30735973573128b14bb4a25cf4debaa0979a655
>(this commit is a part of v4.8-clocks-pm branch)
>
>IOMMU_OF_DECLARE() with NULL init_fn is needed to notify IOMMU core that
>this IOMMU driver is available in the system and core has to defer
>probing of drivers before the IOMMU driver gets initialized from its
>controller's platform device.
>
   ok, thanks, understand. I was not thinking about the non-dt case.
I will keep this check then.

Regards,
 Sricharan     
