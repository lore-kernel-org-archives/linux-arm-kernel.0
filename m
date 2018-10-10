From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Oct 2018 17:53:17 +0100
Subject: [PATCH] Revert "arm64: uaccess: implement unsafe accessors"
In-Reply-To: <20181010155544.19125-1-james.morse@arm.com>
References: <20181010155544.19125-1-james.morse@arm.com>
Message-ID: <20181010165316.GB212880@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 04:55:44PM +0100, James Morse wrote:
> This reverts commit a1f33941f7e103bcf471eaf8461b212223c642d6.
> 
> The unsafe accessors allow the PAN enable/disable calls to be made
> once for a group of accesses. Adding these means we can now have
> sequences that look like this:
> 
> | user_access_begin();
> | unsafe_put_user(static-value, x, err);
> | unsafe_put_user(helper-that-sleeps(), x, err);
> | user_access_end();
> 
> Calling schedule() without taking an exception doesn't switch the
> PSTATE or TTBRs. We can switch out of a uaccess-enabled region, and
> run other code with uaccess enabled for a different thread.
> 
> We can also switch from uaccess-disabled code back into this region,
> meaning the unsafe_put_user()s will fault.
> 
> For software-PAN, threads that do this will get stuck as
> handle_mm_fault() will determine the page has already been mapped in,
> but we fault again as the page tables aren't loaded.
> 
> To solve this we need code in __switch_to() that save/restores the
> PAN state.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Julien Thierry <julien.thierry@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Applied. Thanks.

-- 
Catalin
