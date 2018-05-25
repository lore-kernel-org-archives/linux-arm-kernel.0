From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 25 May 2018 12:07:04 +0100
Subject: [PATCH 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
In-Reply-To: <CAPDyKFrTtvhxOhf9BPY1=cJ9VQyx9D=P3O0vCV+WXSVR82FozQ@mail.gmail.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-10-git-send-email-ulf.hansson@linaro.org>
 <1c21d18e-954a-f3a8-9817-0117b7cb7e4f@nvidia.com>
 <CAPDyKFozm88OM8cDFXXwvgdMirrt2=HhZtBdyhNjo2bgjHV2Mg@mail.gmail.com>
 <2c63af8c-4745-a751-8d3d-f7122e921e6f@nvidia.com>
 <CAPDyKFrTtvhxOhf9BPY1=cJ9VQyx9D=P3O0vCV+WXSVR82FozQ@mail.gmail.com>
Message-ID: <b3a94d63-678c-eab6-47a8-43eca95da979@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 11:45, Ulf Hansson wrote:

...

>> Right, but this case still seems like an error. My understanding is that
>> only drivers will use this API directly and it will not be used by the
>> device driver core (unlike dev_pm_domain_attach), so if anyone calls this
>> attempting to attach another PM domain when one is already attached, they
>> are doing something wrong.
> 
> [...]
> 
> You may be right!
> 
> What I was thinking of is whether multiple PM domains may be optional
> in some cases, but instead a PM domain have already been attached by
> dev_pm_domain_attach(), prior the driver starts to probe.
> 
> Then, assuming we return an error for this case, that means the caller
> then need to check the dev->pm_domain pointer, prior calling
> dev_pm_domain_attach_by_id(). Wouldn't it? Perhaps that is more clear
> though?

IMO the driver should know whether is needs multiple power-domains or 
not and if it needs multiple then it should just call 
dev_pm_domain_attach_by_id() N times without needing to checking 
dev->pm_domain first. If it fails then either the PM domain core did 
something wrong or power-domains are missing from DT, but either way 
there is an error, so let it fail.

Cheers
Jon

-- 
nvpublic
