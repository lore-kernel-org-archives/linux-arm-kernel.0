From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Feb 2014 17:36:24 +0000
Subject: [RFC PATCH 0/2] Introduce pte_isset for arm and arm64
In-Reply-To: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
References: <1393256005-2206-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140224173624.GH2553@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Mon, Feb 24, 2014 at 03:33:23PM +0000, Steve Capper wrote:
> Long descriptors on ARM and all ptes on ARM64 are 64 bits. Some pte
> attribute test functions such as pte_dirty return the bitwise-and of a
> flag with the pte value. If the flag to be tested resides in the
> upper 32 bits of the pte, then we run into the danger of the result
> being dropped if downcast.
> 
> For example:
> 	gather_stats(page, md, pte_dirty(*pte), 1);
> where pte_dirty(*pte) is downcast to an int.
> 
> Under ARM with LPAE, functions such as huge_pte_write also perform a
> downcast to unsigned long (which is 32 bits). 
> 
> This series introduces a new macro pte_isset which performs the bitwise
> and, then performs a double logical invert to ensure predictable
> downcasting.
> 
> The reasoning behind a new macro was that it creates an obvious
> pattern which can be followed by future changes to the pte functions.
> Rather than target specific pte functions, I opted to wrap all of them
> with this macro for the sake of simplicity (also the flags may move in
> future).
> 
> I was toying with using (bool), but decided that the !! looked slightly
> better. Under testing (with an Arndale and the Fast Model on 3.14-rc4)
> both strategies worked as expected.

Ok, but I still don't understand why this is needed over your previous
series. Just inlining the '!!' into the existing accessors should be fine,
no? Basically, I don't see what the new macro gains us.

Will
