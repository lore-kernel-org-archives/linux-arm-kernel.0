From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Apr 2016 14:27:16 +0100
Subject: [PATCH] arm64: erratum: Workaround for Kryo reserved system
 register read
In-Reply-To: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
References: <1460044456-5297-1-git-send-email-nkaje@codeaurora.org>
Message-ID: <20160412132715.GC8066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 09:54:16AM -0600, Naveen Kaje wrote:
> The ARMv8.0 architecture reserves several system register
> encodings for future use. These encodings should behave
> as read-only and always return zero on a read. The Kryo core
> errantly causes an instruction abort upon an AArch64
> read attempt to the following system register encodings using
> the MRS instruction:
> 	 3, 0, C0, [C4-C7], [2-3, 6-7]
> 	 3, 0, C0, C3, [3-7]
> 	 3, 0, C0, [C4,C6,C7], [4-5]
> 	 3, 0, C0, C2, [6-7]
> All system register encodings above use the following form
> Op0, Op1, CRn, CRm, Op2.
> Note that some of the encodings listed above include the system
> register space reserved for the following identification registers
> which may appear in future revisions of the ARM architecture beyond
> ARMv8.0.

Is this bug affecting test or production silicon? If the former (which I
presume is the case since such chip wouldn't have passed the ARM
validation suite), I won't merge the workaround into mainline. It is,
however, fine by me to give it to your early testers. We have a similar
approach with the ARM Ltd CPUs and don't upstream any CPU errata
workaround unless a partner goes with the silicon into production.

-- 
Catalin
