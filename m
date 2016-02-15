From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Feb 2016 18:14:25 +0000
Subject: [PATCH v4 23/23] arm64: Panic when VHE and non VHE CPUs coexist
In-Reply-To: <20160215172653.GM6298@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
 <1455216004-19499-24-git-send-email-marc.zyngier@arm.com>
 <20160215172653.GM6298@arm.com>
Message-ID: <56C21581.5030003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/16 17:26, Will Deacon wrote:
> On Thu, Feb 11, 2016 at 06:40:04PM +0000, Marc Zyngier wrote:
>> Having both VHE and non-VHE capable CPUs in the same system
>> is likely to be a recipe for disaster.
>>
>> If the boot CPU has VHE, but a secondary is not, we won't be
>> able to downgrade and run the kernel at EL1. Add CPU hotplug
>> to the mix, and this produces a terrifying mess.
>>
>> Let's solve the problem once and for all. If you mix VHE and
>> non-VHE CPUs in the same system, you deserve to loose, and this
>> patch makes sure you don't get a chance.
>>
>> This is implemented by storing the kernel execution level in
>> a global variable. Secondaries will park themselves in a
>> WFI loop if they observe a mismatch. Also, the primary CPU
>> will detect that the secondary CPU has died on a mismatched
>> execution level. Panic will follow.
> 
> This should really be based on Suzuki's series for handling generic
> mismatches:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401727.html
> 
> To avoid growing a dependency on something that's unlikely to make it
> for 4.6, I'd be inclined to drop your homegrown checks altogether amd
> help Suzuki with his series as a separate activity (i.e. it needn't be
> a blocker imo).

That's fine, I'll drop that one - we can revisit it and fold it into
Suzuki's series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
