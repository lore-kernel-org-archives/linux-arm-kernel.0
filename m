From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Mar 2015 12:05:58 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150316195255.GM8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk> <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk> <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk>
Message-ID: <550818A6.9020205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/03/15 19:52, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 07:16:05PM +0000, Sudeep Holla wrote:
>> On 16/03/15 18:16, Russell King - ARM Linux wrote:

[...]

> If I had to guess, I'd say the reason it's stopped there (exactly on a
> cache line boundary) is because both CPUs are waiting for an instruction
> fetch to complete into its L1 I-cache, and for some reason, the L2
> cache is not satisfying the request from either CPU.  The question of
> course is... why not.
>

As I had mentioned yesterday, I did compare the L2C settings between
v3.18 and later kernel and found them to be *exactly same*.

Since you suspected issues around instruction fetching, I tried playing
around the tag and data ram latencies. After some experiments, I found
that changing just the tag ram read latency to 2 cycles, the issue we
are seeing goes away at-least on my setup. It will be good to see the
behaviour on your setup with the patch below.

The default value which bootmon is programming happens to be worst
case scenario(8 cycles for all). Will recalls that it was changed to
minimum value after graphics guys complained about performance.

We need to check with h/w guys to get the correct optimal values for
these latencies.

Regards,
Sudeep

--->8

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts 
b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 23662b5a5e9d..030c90c1105d 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -172,7 +172,7 @@
                 interrupts = <0 43 4>;
                 cache-level = <2>;
                 arm,data-latency = <1 1 1>;
-               arm,tag-latency = <1 1 1>;
+               arm,tag-latency = <1 2 1>;
         };

         pmu {
