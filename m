From: appro@openssl.org (Andy Polyakov)
Date: Sun, 29 Mar 2015 16:07:02 +0200
Subject: [PATCH] crypto/arm: accelerated SHA-512 using ARM generic ASM
 and NEON
In-Reply-To: <1427527726-25022-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427527726-25022-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <55180706.9030104@openssl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This updates the SHA-512 NEON module with the faster and more
> versatile implementation from the OpenSSL project. It consists
> of both a NEON and a generic ASM version of the core SHA-512
> transform, where the NEON version reverts to the ASM version
> when invoked in non-process context.
> 
> Performance relative to the generic implementation (measured
> using tcrypt.ko mode=306 sec=1 running on a Cortex-A57 under
> KVM):
> 
> 	input size	block size	asm	neon	old neon
> 
> 	8192		8192		1.51	3.51	2.69

One should keep in mind that improvement coefficients vary greatly from
platform to platform. Normally you *should* observe higher coefficients
in asm column and *can* observe smaller differences between "neon" and
"old neon". BTW, 1.51 is unexpectedly low, I wonder which compiler
version stands for 1.0? Nor can I replicate difference between "neon"
and "old neon", I get smaller difference, 17%, on Cortex-A57. Well, I'm
comparing in user-land, but it shouldn't be that significant at large
blocks...

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This should get the same treatment as Sami's sha56 version: I would like
> to wait until the OpenSSL source file hits the upstream repository so that
> I can refer to its sha1 hash in the commit log.

Update is committed as
http://git.openssl.org/gitweb/?p=openssl.git;a=commitdiff;h=b1a5d1c652086257930a1f62ae51c9cdee654b2c.
Note that the file I've initially sent privately was a little bit off.
Sorry about that. But that little bit is just a commentary update that
adds performance result for Cortex-A15. So that kernel patch as
originally posted is 100% functionally equivalent.

Cheers.
