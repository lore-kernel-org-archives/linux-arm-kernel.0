From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Jun 2016 10:27:50 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <20160614164944.GC1041@n2100.armlinux.org.uk>
References: <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com> <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
 <20150402141336.GI24899@n2100.arm.linux.org.uk> <551D7EAB.1000200@arm.com>
 <1465918285.2840.41.camel@linaro.org>
 <20160614155220.GB1041@n2100.armlinux.org.uk> <5760346A.10903@arm.com>
 <20160614164944.GC1041@n2100.armlinux.org.uk>
Message-ID: <57611F96.90003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/06/16 17:49, Russell King - ARM Linux wrote:
> On Tue, Jun 14, 2016 at 05:44:26PM +0100, Sudeep Holla wrote:
>> Even with higher latency if the platform is unusable, I agree to remove.
>> If you think it's usable with the updated latency(<2 2 1>) then we can
>> update it.
>
> The kernels I'm booting have that updated latency.  It used to improve
> things, but for most of this year, it fails most boot attempts.  Out
> of the last 21 boot attempts, all 21 attempts failed with the above
> latency value.
>

Thanks, I do see that, it's unreliable with higher latencies too. If I
increase them, it seem to work, but again as the size of the image
increases the behavior changes.

So, apart from increasing the latency or removing the DT completely, I
was thinking of 3rd option of disabling L2CC on Vexpress CA9 coretile.
Let me know if that's acceptable. I thought it's reasonable as we
still can the platform support without L2CC enabled.

Regards,
Sudeep


-->8

diff --git i/arch/arm/boot/dts/vexpress-v2p-ca9.dts 
w/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index b608a03ee02f..9742448b4e85 100644
--- i/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ w/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -174,6 +174,7 @@
                 cache-level = <2>;
                 arm,data-latency = <1 1 1>;
                 arm,tag-latency = <1 1 1>;
+               status = "disabled";
         };

         pmu {
diff --git i/arch/arm/mm/cache-l2x0.c w/arch/arm/mm/cache-l2x0.c
index c61996c256cc..569fb1f0994b 100644
--- i/arch/arm/mm/cache-l2x0.c
+++ w/arch/arm/mm/cache-l2x0.c
@@ -1750,6 +1750,9 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
         if (!np)
                 return -ENODEV;

+       if (!of_device_is_available(np))
+               return -ENODEV;
+
         if (of_address_to_resource(np, 0, &res))
                 return -ENODEV;
