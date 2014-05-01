From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 1 May 2014 11:57:39 +0200
Subject: [RFC PATCH V4 6/7] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <20140501095246.GB22316@arm.com>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-7-git-send-email-steve.capper@linaro.org>
 <20140430152047.GF31220@arm.com> <20140430153317.GG31220@arm.com>
 <20140430153824.GA7166@linaro.org> <20140430172114.GI31220@arm.com>
 <20140501073402.GA30358@linaro.org>
 <20140501095246.GB22316@arm.com>
Message-ID: <20140501095739.GO11096@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 01, 2014 at 10:52:47AM +0100, Catalin Marinas wrote:
> Does gup_fast walking increment the mm_users? Or is it a requirement of
> the calling code? I can't seem to find where this happens.

No, its not required at all. One should only walk current->mm with
gup_fast, any other usage is broken.

And by delaying TLB shootdown, either through disabling IRQs and
stalling IPIs or by using RCU freeing, you're guaranteed your own page
tables won't disappear underneath your feet.
