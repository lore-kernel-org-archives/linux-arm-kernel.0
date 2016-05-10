From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 May 2016 11:45:11 +0100
Subject: [PATCH] arm64: kgdb: Match pstate size with gdbserver protocol
In-Reply-To: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
References: <1462815566-15086-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20160510104511.GH687@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2016 at 06:39:26PM +0100, Daniel Thompson wrote:
> Current versions of gdb do not interoperate cleanly with kgdb on arm64
> systems because gdb and kgdb do not use the same register description.
> This patch modifies kgdb to work with recent releases of gdb (>= 7.8.1).
> 
> Compatibility with gdb (after the patch is applied) is as follows:
> 
>   gdb-7.6 and earlier  Ok
>   gdb-7.7 series       Works if user provides custom target description
>   gdb-7.8(.0)          Works if user provides custom target description
>   gdb-7.8.1 and later  Ok
> 
> When commit 44679a4f142b ("arm64: KGDB: Add step debugging support") was
> introduced it was paired with a gdb patch that made an incompatible
> change to the gdbserver protocol. This patch was eventually merged into
> the gdb sources:
> https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=a4d9ba85ec5597a6a556afe26b712e878374b9dd
> 
> The change to the protocol was mostly made to simplify big-endian support
> inside the kernel gdb stub.

While that was how we discovered the inconsistency, a major concern is
that SPSR_EL* (i.e. PSTATE), as accessed by MRS/MSR is a 64-bit
quantity, even if the upper 32 bits are RES0 today.

It is conceivable that the upper 32 bits could be used in future (as
happened with CLIDR_EL1), and for this reason we expose those upper 32
bits from the kernel, and treat system registers as 64-bit quantities
generally.

So this was also about ensuring the interface was consistent and to some
extent future-proof.

Thanks,
Mark.
