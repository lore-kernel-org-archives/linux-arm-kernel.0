From: agraf@suse.de (Alexander Graf)
Date: Fri, 2 Sep 2016 18:58:00 +0200
Subject: [RFC/RFT PATCH] arm64: mm: allow userland to run with one fewer
 translation level
In-Reply-To: <1471781914-16681-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471781914-16681-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <abe7c6e4-8898-3e9b-da66-dd3ca10f27b0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21.08.16 14:18, Ard Biesheuvel wrote:
> The choice of VA size is usually decided by the requirements on the kernel
> side, particularly the size of the linear region, which must be large
> enough to cover all of physical memory, including the holes in between,
> which may be very large (~512 GB on some systems).
> 
> Since running with more translation levels could potentially result in
> a performance penalty due to additional TLB pressure, this patch allows the
> kernel to be configured so that it runs with one fewer translation level on
> the userland side. Rather than modifying all the compile time logic to deal
> with folded PUDs or PMDs, we simply allocate the root table and the next
> table adjacently, so that we can simply point TTBR0_EL1 to the next table
> (and update TCR_EL1.T0SZ accordingly)
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This is just a proof of concept. *If* there is a performance penalty associated
> with using 4 translation levels instead of 3, I would expect this patch to
> compensate for that, given that the additional TLB pressure should be on the
> userland side primarily. Benchmark results are highly appreciated.
> 
> As a bonus, this would fix the horrible yet real JIT issues we have been seeing
> with 48-bit VA configurations. IOW, I expect this to be an easier sell than
> simply limiting TASKSIZE to 47 bits (assuming anyone can show a benchmark where
> this patch has a positive impact on the performance of a 48-bit/4 levels kernel)
> and distros can ship kernels that work on all hardware (including Freescale and
> Xgene with >= 64 GB) but don't break their JITs.
> 
> This patch is most likely broken for 16k/47-bit configs, but I didn't bother to
> fix that before having the discussion.

Let's roll forward by a few years. In that time, there's a good chance
you will have nvdimms in a good number of systems out there with massive
address spaces that easily reach beyond the lousy 512GB you get with 3
levels.

That means at that point we'd have to roll back and have 48 bits
regardless - or add special attributes to have binaries that then can
demand bigger address space. Overall that doesn't sound terribly
appealing, so I'm not sure going for 39 as interim is a step into the
right direction.

That said, I'd be very happy to see benchmark results too :)


Alex
