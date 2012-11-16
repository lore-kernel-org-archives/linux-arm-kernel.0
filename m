From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Nov 2012 20:25:53 +0100
Subject: [PATCH V2 1/5] arm: mvebu: Added support for coherency fabric
 in mach-mvebu
In-Reply-To: <20121116185610.GA1019@mudshark.cambridge.arm.com>
References: <1351545108-18954-1-git-send-email-gregory.clement@free-electrons.com>
 <1351545108-18954-2-git-send-email-gregory.clement@free-electrons.com>
 <20121105140258.GO3351@mudshark.cambridge.arm.com>
 <50A15A33.60405@free-electrons.com>
 <20121113104340.GD3940@mudshark.cambridge.arm.com>
 <50A3F860.5010601@free-electrons.com>
 <20121115101752.GA26453@mudshark.cambridge.arm.com>
 <50A5103F.1040903@free-electrons.com>
 <20121115162123.GC5885@mudshark.cambridge.arm.com>
 <50A51D0D.4090009@free-electrons.com>
 <20121116185610.GA1019@mudshark.cambridge.arm.com>
Message-ID: <50A69341.2090202@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 07:56 PM, Will Deacon wrote:
> On Thu, Nov 15, 2012 at 04:49:17PM +0000, Gregory CLEMENT wrote:
>> On 11/15/2012 05:21 PM, Will Deacon wrote:
>>> Anyway, that's by-the-by as this is all called early enough that we
>>> shouldn't care. The thing I don't like now is that the fabric initialisation
>>> is done entirely differently on the primary CPU than the secondaries. The
>>> primary probes the device-tree (well, it's also now hard-coded for v2) and
>>> accesses the registers from a C function(armada_370_xp_set_cpu_coherent) whilst
>>> the secondaries have hardcoded addresses and access via asm
>>> (armada_xp_secondary_startup).
>>
>>
>> Now it is hardcoded in both case as you pointed it. So the last
>> difference is setup from a C function or via asm.
>>
>> The differences between primary and secondary CPU when they enable the
>> coherency, is due to the fact that we really are in a different
>> situation. For primary CPU, as it is the only CPU online it doesn't
>> need to enable the coherency from the beginning, so we can wait to
>> have MMU enable and convenient feature. Whereas for the secondary CPU
>> they need the coherency from the very beginning are by definition they
>> won't be alone. That's why this very first instruction are written in
>> asm and they use physical address.
>>
>> I don't see how to handle it in a different way.
> 
> The code paths are fine, I would just like to see less duplication. Can you
> make the asm function PCS compliant and call it from C for the primary
> (setting the link register to secondary_startup for the secondary cores)?

Have you a pointer on how to do it (make the asm function PCS compliant)?

I will also need to add a parameter, because the base address are not the
same between primary CPU and secondary CPUS. With the first we use virtual
address whereas with the second the physical address.


> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
