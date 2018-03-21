From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 21 Mar 2018 11:41:07 +0000
Subject: [PATCH] arm/arm64: smccc: Fix CLANG compilation for ARM 64 bit
 archs
In-Reply-To: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
References: <1521584046-19692-1-git-send-email-isaacm@codeaurora.org>
Message-ID: <2dd0342a-6cd5-9875-3519-4aef1b321258@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/18 22:14, Isaac J. Manjarres wrote:
> Currently, there are references to registers that
> have had their names changed in 64 bit ARM architectures,
> such as "r0." While GCC automatically does the conversion of
> these registers to their 64 bit counterparts, CLANG
> does not, resulting in compilation failures when
> building the kernel. Allow for differentiation of
> which register names to use, based on ARM architecture.

As Mark pointed out, please re-read section B1.2.1 of the Armv8 ARM - if 
you want to propose working around a bug in Clang wherein it doesn't 
understand the difference between the name of a register and the name of 
a register access*, then by all means go ahead (it is rather subtle, 
after all). Just don't dress it up in misinformation about the architecture.

Robin.


*Although as far as I can tell, Clang is actually just wildly 
inconsistent in this regard:

[root at space-channel-5 ~]# clang --version
clang version 5.0.1 (tags/RELEASE_501/final)
Target: aarch64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
[root at space-channel-5 ~]# clang -O0 reg.c
reg.c:3:31: error: unknown register name 'r0' in asm
         register unsigned long a asm("r0");
                                      ^
reg.c:18:24: error: unknown register name 'q2' in asm
         register double y asm("q2");
                               ^
2 errors generated.
[root at space-channel-5 ~]# cat reg.c
int main(void) {
// architecturally correct, but not allowed
	register unsigned long a asm("r0");

// allowed
	register unsigned long b asm("x2");

// nonsensical, yet still allowed
	register unsigned long c asm("w1");
	
// FPSIMD equivalent of "r0" case, but allowed
	register double w asm("v0");

// FPSIMD equivalent of "x1" case, also allowed
	register double x asm("d1");

// Yet another access size, not allowed
	register double y asm("q2");

// Nonsensical access size, but allowed
	register double z asm("s3");
}
[root at space-channel-5 ~]#
