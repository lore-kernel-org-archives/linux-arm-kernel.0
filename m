From: opendmb@gmail.com (Doug Berger)
Date: Tue, 28 Feb 2017 16:50:57 -0800
Subject: Memory Incoherence Issue
In-Reply-To: <20170209143331.GD19397@arm.com>
References: <989deba2-f1fb-550c-afdd-e7732d97583c@gmail.com>
 <20170209143331.GD19397@arm.com>
Message-ID: <ffef8f43-3269-9c67-e654-4d21dcf4ab84@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 06:33 AM, Will Deacon wrote:
> Hi Doug,
> 
> On Thu, Feb 02, 2017 at 06:00:02PM -0800, Doug Berger wrote:
>> We have a device that is based on a dual-core A15 MPCore host CPU
>> complex that has been exhibiting a problem with very infrequent memory
>> corruption when exercising a user space memory tester program
>> (memtester) in a system designed around a v3.14 Linux environment.
>> Unfortunately, it is not possible to update this system to the latest
>> kernel version for testing at this time.
> 
> So what are the options for changing the kernel being used here? Are you
> using v3.14, or a stable variant?
> 
> There have been many fixes since 3.14 (e.g. 8e6480667246 ("ARM: 8299/1:
> mm: ensure local active ASID is marked as allocated on rollover") and
> so you could simply be hitting a known, fixed issue.
> 
> Will
> 

Following up for the curious:
The observed failures have been associated with a software bug in the
Broadcom Brahma B15 readahead cache support patch originally submitted
for review here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328706.html

The software bug was caught and corrected before the updated submission
of the Broadcom Brahma B15 readahead cache support patch resubmitted here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480806.html

So you were correct that we were in fact hitting a known, fixed issue.

Unfortunately, the fix had not made its way into the 3.14 kernel used on
this system.

As usual the error is obvious once you know it's there:
static inline void __b15_rac_flush(void)
{
	u32 reg;

	__raw_writel(FLUSH_RAC, b15_rac_base + RAC_FLUSH_REG);
	do {
		/* This dmb() is required to force the Bus Interface Unit
		 * to clean oustanding writes, and forces an idle cycle
		 * to be inserted.
		 */
		dmb();
		reg = __raw_readl(b15_rac_base + RAC_FLUSH_REG);
-	} while (reg & RAC_FLUSH_REG);
+	} while (reg & FLUSH_RAC);
}

My only consolation is that you missed it too ;).

Thanks so much for your consideration and support,
    Doug
