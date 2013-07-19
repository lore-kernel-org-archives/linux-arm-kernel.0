From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 19 Jul 2013 13:15:33 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <20130719110947.GD24642@n2100.arm.linux.org.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
Message-ID: <51E92DE5.6090404@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 12:09, Russell King - ARM Linux wrote:
> On Fri, Jul 19, 2013 at 11:58:45AM +0100, Ben Dooks wrote:
>> I ran in to an issue with the alignment handler when running BE8 where
>> it loads instructions and fails to swap.
>>
>> Is there a better way of swapping instructions for ARM when loading
>> from arbitrary places? Have I missed any other places this could happen?
>
> Maybe we need a macro which deals with this automatically?
>
> 	arm_instr_to_cpu(x)
> 	thumb_instr_to_cpu(x)
>
> These should probably make use of the swab*() macros when an endian swap
> is needed.
>
>> The following patch is my first attempt at solving the problem for the
>> alignment handler:
>
> I'd suggest checking this with sparse too - you have some type errors here.

How about:

diff --git a/arch/arm/include/uapi/asm/byteorder.h 
b/arch/arm/include/uapi/asm/b
index 7737974..9e63a00 100644
--- a/arch/arm/include/uapi/asm/byteorder.h
+++ b/arch/arm/include/uapi/asm/byteorder.h
@@ -21,5 +21,13 @@
  #include <linux/byteorder/little_endian.h>
  #endif


+#ifdef CONFIG_CPU_ENDIAN_BE8
+#define cpu_to_arm_instr(__instr)      swab32(__instr)
+#define cpu_to_thum_instr(__instr)     swab16(__instr)
+#else
+#define cpu_to_arm_instr(__instr)      (__instr)
+#define cpu_to_thum_instr(__instr)     (__instr)
+#endif

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
