From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Feb 2014 16:33:03 -0800
Subject: BUG: Null pointer dereference on booting TC2 with
 vexpress_defconfig
In-Reply-To: <20140217223907.GH21070@cbox>
References: <20140217223907.GH21070@cbox>
Message-ID: <20140218003303.GI21070@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 02:39:07PM -0800, Christoffer Dall wrote:
> Booting my TC2 using 3.14-rc3 and vexpress_defconfig causes a NULL
> pointer dereference in schedule_work_on.
> 
> A quick look at the trace indicates that schedule_work() is called
> before system_wq is initialized.
> 
> Further, a bisect seems to indicate that this call path is triggered by
> the changes in this merge commit of Theodore T'so's random_for_linus
> tag:
> 0891ad829d2a0501053703df66029e843e3b8365
> 

Update, it's in fact this commit causing the trouble:
6265e169cd313d6f3aad3c33d0a5b0d9624f69f5

As far as I can gather the problem is that an IRQ comes in early, before
the workqueue structures have been setup, and add_interrupt_randomness()
calls credit_entropy_bits(), which calls schedule_work() and then
everything breaks.

Just removing the extra bit that pushes work to a workqueue doesn't
work, causing the system to just stop responding, because I assume mem
alloc functions need that extra entropy.

So I'm wondering if the system is trying to take interrupts too early,
or what exactly is going on.  The interrupts are from the non-secure
arch timer, which I think the kernel is in complete control of at this
point, so it shouldn't be a bootloader issue.

Anyway, hope someone can help me out.

-Christoffer
