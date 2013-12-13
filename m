From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Dec 2013 11:39:03 +0000
Subject: [PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option
In-Reply-To: <CACmBeS1d-EX5oPD8f7P-ufmF=MutdTO+LgG23Cb0=biR8yQPCg@mail.gmail.com>
References: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
 <20131213095655.GB4360@n2100.arm.linux.org.uk>
 <CACmBeS1d-EX5oPD8f7P-ufmF=MutdTO+LgG23Cb0=biR8yQPCg@mail.gmail.com>
Message-ID: <20131213113903.GE4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 11:51:09AM +0100, Jonas Jensen wrote:
> On 13 December 2013 10:56, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > So, having these symbols enabled (provided the right ones for FA526 are
> > also enabled) makes no difference.  So I don't buy your explanation.
> 
> The explanation is indeed false, CPU_FA526 and CPU_ARM920T get along just fine.
> That's not where the problem is.
> 
> Panic goes away after removing CONFIG_ARM_THUMB=y.
> 
> I assume this is what should happen on processors without thumb?

I see what's causing this: the kuser helpers are using "bx lr" to return
which will be undefined on non-Thumb CPUs.  We generally cope fine with
non-Thumb CPUs, conditionalising where necessary on HWCAP_THUMB or the
T bit in the PSR being set.

However, it looks like the kuser helpers got missed.  As a check, please
look at arch/arm/kernel/entry-armv.S, find the line with:

	.macro	usr_ret, reg

and ensure that the mov pc, \reg case always gets used.  Please report
back.

Thanks.
