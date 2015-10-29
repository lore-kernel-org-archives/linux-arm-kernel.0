From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 17:28:19 +0100
Subject: [PATCH 0/3] Revert arm64 cache geometry
In-Reply-To: <20151029154346.GL8644@n2100.arm.linux.org.uk>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
 <CAKv+Gu-CgXU4O8SymcjmCYZqyAa0PZbJXwNqXfuCamxYY9C8GA@mail.gmail.com>
 <20151029154346.GL8644@n2100.arm.linux.org.uk>
Message-ID: <5A68E2B9-2254-42CA-8781-E2FA737C366C@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 29 okt. 2015, at 16:43, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
>> On Thu, Oct 29, 2015 at 12:22:51PM +0900, Ard Biesheuvel wrote:
>> Fair enough. It is a bit disappointing that we cannot trust these
>> values, but if the architecture does not mandate their accuracy, we
>> obviously should not be using them in the way that we are.
>> 
>> I think we have similar code in the ARM tree, so we should probably
>> make some changes there as well.
> 
> I've opposed exporting the cache dimensions to userspace for several
> reasons:
> 

I agree with the arguments below. However, what I refer to here is kernel code that infers whether a certain VIPT cache is non-aliasing based on the way size, which is calculated from values that are exposed to software for the sole purpose of enumerating cachelines by set/way.


> * it will become a nightmare with the various different register formats
>  to properly decode these values
> * older CPUs don't have the cache ID registers, so we'd need to augment
>  any export with additional static configuration somehow
> * I don't trust userland with this information to make the right choices,
>  especially when faced with further levels of caches.
> 
> The main reason for people wanting the cache dimensions has been "so we
> can select the optimal code for the CPU".  Given all the combinations
> of caches out there, I've always said selecting code based on one level
> of cache is totally insane, and userspace is better off doing some
> performance measurement of its implementations and selecting the most
> appropriate version.
> 
> There's many things that affect the performance of code paths with CPUs.
> It's not just about cache line size, but instruction latencies, write
> delays, branch prediction and so forth.  You can't _say_ "because this
> CPU has a 32K L1 cache, if I optimise my code as X it'll perform
> better everywhere with a 32K L1 cache than optimised Y."
> 
> Selecting code based on cache parameters is just wrong.
> 
> There may be cases where userspace would like to know the cache line
> size, so it can appropriately align data structures - but that again
> depends on what you're trying to achieve, and what if the L1 cache
> line size is different from the L2 cache line size...
> 
> It's a minefield, one which IMHO userspace shouldn't be trusted with.
> Userspace should assume the worst case cache line size seen in ARM
> CPUs and be done with it.
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
