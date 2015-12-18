From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 09:48:51 +0000
Subject: [PATCH 2/2] ARM: Make IPI_CPU_BACKTRACE a "non-secure" SGI
In-Reply-To: <20151218093412.GN8644@n2100.arm.linux.org.uk>
References: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
 <1450430173-26992-3-git-send-email-marc.zyngier@arm.com>
 <20151218093412.GN8644@n2100.arm.linux.org.uk>
Message-ID: <5673D683.8050002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 09:34, Russell King - ARM Linux wrote:
> On Fri, Dec 18, 2015 at 09:16:13AM +0000, Marc Zyngier wrote:
>> Having IPI_CPU_BACKTRACE as SGI15 may not work if the kernel is
>> running in non-secure mode and that the secure firmware has
>> decided to follow ARM's recommendations that SGI8-15 should
>> be reserved for secure purpose.
>>
>> Now that we are "only" using SGI0-6, change IPI_CPU_BACKTRACE
>> to use SGI7, which makes it more likely to work.
> 
> We should add a comment to the enum explaining this, so it's obvious
> for the future - best place is after the IPI_CPU_BACKTRACE entry.
> Not everyone checks the git logs for these kinds of details.

Indeed. How about something like this:

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fe517f1..37312f6 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -73,6 +73,11 @@ enum ipi_msg_type {
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
 	IPI_CPU_BACKTRACE,
+	/*
+	 * SGI8-15 can be reserved by secure firmware, and thus may
+	 * not be usable by the kernel. Please keep the above limited
+	 * to at most 8 entries.
+	 */
 };

 static DECLARE_COMPLETION(cpu_running);

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
