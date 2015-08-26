From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Aug 2015 11:48:39 +0100
Subject: [PATCH] arm: Handle starting up in secure mode
In-Reply-To: <20150826103940.GD6281@e103592.cambridge.arm.com>
References: <1440424572-27116-1-git-send-email-cov@codeaurora.org>
 <20150826103940.GD6281@e103592.cambridge.arm.com>
Message-ID: <20150826104839.GC21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 11:39:42AM +0100, Dave Martin wrote:
> On Mon, Aug 24, 2015 at 09:55:26AM -0400, Christopher Covington wrote:
> > ARM Linux appears to have never been made aware of the ARMv7 security
> > extensions. When CONFIG_ARM_SEC_EXT=y, have it probe for its security
> > state by checking whether CNTFRQ is writeable and potentially make
> > mode changes based on the information. The most features are available
> > from hypervisor (HYP) mode, so switch to it possible. Failing that,
> > prefer non-secure supervisor (SVC) mode to secure supervisor mode.
> 
> Up to now we've steered clear of this, since it's a bit of a fig leaf
> for broken firmware unless Linux actually has some valid use for the
> Security Extensions itself.
> 
> Shouldn't the bootloader or firmware be doing this stuff, and if not,
> why not?
> 
> 
> Some other things that would need to be considered in any case:
> 
>  * SoC-specific setup of the Non-secure view of the system:  This has
>    to happen very early, so making it DT aware is going to be hard --
>    failing that, we are effectively risking bringing back board files.
>    The split in responsibility between firmware/bootloader and kernel
>    needs to be clearly defined and (as far as possible) platform-
>    independent, otherwise we'll have total chaos.
> 
>  * Out of reset, generally the CPU state is only fully defined for the
>    highest exception level.  You probably need to be doing more setup
>    than you're currently doing.
> 
>  * SMP, secondary boot and suspend/resume -- again involving board-
>    specific code.
> 
>  * You need to safely "park" the Secure World before running anything
>    in Non-Secure.  As a minimum, you would need to quiesce any
>    Secure interrupt sources, disable all interrupt traps to Monitor
>    mode, and make sure that the Monitor vectors point somewhere
>    real, so that executing SMC doesn't send the CPU off into the
>    long grass...

Another question is: has this been tested with kexec?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
