From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 08 Jul 2014 17:53:18 +0100
Subject: [Xen-devel] [PATCH v2 1/3] xen/arm: introduce XENFEAT_grant_map_11
In-Reply-To: <1404835150.25940.9.camel@kazak.uk.xensource.com>
References: <alpine.DEB.2.02.1407081552200.27641@kaball.uk.xensource.com>	<1404834132-15847-1-git-send-email-stefano.stabellini@eu.citrix.com>	<1404834562.25940.8.camel@kazak.uk.xensource.com>	<alpine.DEB.2.02.1407081653220.27641@kaball.uk.xensource.com>
 <1404835150.25940.9.camel@kazak.uk.xensource.com>
Message-ID: <53BC21FE.2000705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian and Stefano,

On 07/08/2014 04:59 PM, Ian Campbell wrote:
> On Tue, 2014-07-08 at 16:54 +0100, Stefano Stabellini wrote:
>> On Tue, 8 Jul 2014, Ian Campbell wrote:
>>> On Tue, 2014-07-08 at 16:42 +0100, Stefano Stabellini wrote:
>>>> The flag tells us that the hypervisor maps a grant page to guest
>>>> physical address == machine address of the page in addition to the
>>>> normal grant mapping address. It is needed to properly issue cache
>>>> maintenance operation at the completion of a DMA operation involving a
>>>> foreign grant.
>>>>
>>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>>> ---
>>>>  arch/arm/xen/enlighten.c         |    6 ++++++
>>>>  include/xen/interface/features.h |    3 +++
>>>>  2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
>>>> index b96723e..ee3135a 100644
>>>> --- a/arch/arm/xen/enlighten.c
>>>> +++ b/arch/arm/xen/enlighten.c
>>>> @@ -262,6 +262,12 @@ static int __init xen_guest_init(void)
>>>>  	xen_domain_type = XEN_HVM_DOMAIN;
>>>>  
>>>>  	xen_setup_features();
>>>> +
>>>> +	if (!xen_feature(XENFEAT_grant_map_11)) {
>>>> +		pr_warn("Please upgrade your Xen.\n"
>>>> +				"If your platform has any non-coherent DMA devices, they won't work properly.\n");
>>>> +	}
>>>
>>> Unfortunately this isn't quite complete. On a system where all devices
>>> are behind an SMMU then we would want to be able to disable the 1:1
>>> workaround, which in turn would imply disabling this feature flag too
>>> (since it is no longer necessary and also impossible to implement in
>>> that case).
>>
>> That is true, but in such a system we would have to tell the kernel that
>> DMAing is safe, so this will turn into:
> 
> Oh right, yes. Good then ;-)

FWIW, I've sent a patch series a couple ago to avoid using swiotlb when
the device is protected (see https://patches.linaro.org/25070/).

I should take time to rework properly and send a new version.

Regards,

-- 
Julien Grall
