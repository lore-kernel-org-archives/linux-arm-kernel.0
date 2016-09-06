From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Sep 2016 17:42:00 +0100
Subject: [PATCH v24 0/9] arm64: add kdump support
In-Reply-To: <35f81eb9-8bd0-16ae-e04d-5ea4b30c0ad6@caviumnetworks.com>
References: <20160809015248.28414-1-takahiro.akashi@linaro.org>
 <0267060a-d380-2e7a-0c33-0084bfc46d97@caviumnetworks.com>
 <20160831053109.GR20080@linaro.org>
 <cca40a49-3500-ded8-35a7-053adf79d12b@caviumnetworks.com>
 <20160905081501.GA16712@linaro.org>
 <976ca1f8-5efb-b45c-19b8-bde7bd06f5b8@caviumnetworks.com>
 <57CEE1E5.7040206@arm.com>
 <35f81eb9-8bd0-16ae-e04d-5ea4b30c0ad6@caviumnetworks.com>
Message-ID: <57CEF1D8.3000904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/16 17:15, Manish Jaggi wrote:
> 
>>> In my setup the GICD_CTRL[RWP] bit is not cleared in the
>>> crashkernels' distributor init function.
>>
>> Which instance is failing? The initial one (just after the initial
>> disable)? Or the one called from gic_dist_config()?
>>
> In crash kernel, when the GICD_CTRL is set to 0x0, RWP is not getting clear.
> And is never cleared for any subsequent writes.

That's weird. It means writes are still pending, and never drained. What
happens if you put a dsb(sy) in the wait_for_rwp() loop?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
