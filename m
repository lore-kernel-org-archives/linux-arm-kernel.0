From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Aug 2015 17:53:26 +0100
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
Message-ID: <20150825165326.GL21300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Aug 25, 2015 at 04:42:08PM +0100, Russell King wrote:
> Provide a software-based implementation of the priviledged no access
> support found in ARMv8.1.
> 
> Userspace pages are mapped using a different domain number from the
> kernel and IO mappings.  If we switch the user domain to "no access"
> when we enter the kernel, we can prevent the kernel from touching
> userspace.
> 
> However, the kernel needs to be able to access userspace via the
> various user accessor functions.  With the wrapping in the previous
> patch, we can temporarily enable access when the kernel needs user
> access, and re-disable it afterwards.
> 
> This allows us to trap non-intended accesses to userspace, eg, caused
> by an inadvertent dereference of the LIST_POISON* values, which, with
> appropriate user mappings setup, can be made to succeed.  This in turn
> can allow use-after-free bugs to be further exploited than would
> otherwise be possible.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/Kconfig                   | 15 +++++++++++++++
>  arch/arm/include/asm/assembler.h   | 30 ++++++++++++++++++++++++++++++
>  arch/arm/include/asm/domain.h      | 21 +++++++++++++++++++--
>  arch/arm/include/asm/uaccess.h     | 14 ++++++++++++++
>  arch/arm/kernel/process.c          | 24 ++++++++++++++++++------
>  arch/arm/lib/csumpartialcopyuser.S | 14 ++++++++++++++
>  6 files changed, 110 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a750c1425c3a..a898eb72da51 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1694,6 +1694,21 @@ config HIGHPTE
>  	bool "Allocate 2nd-level pagetables from highmem"
>  	depends on HIGHMEM
>  
> +config CPU_SW_DOMAIN_PAN
> +	bool "Enable use of CPU domains to implement priviledged no-access"

Minor comment, but you've consistently misspelt "privileged".

Anyway, I tried this on my TC2 board running Debian Jessie armhf and,
whilst it boots to a shell on the console, ssh connections appear to
hang on the client before even trying to auth. I don't see anything
like a domain fault and the machine is still responsive on the console.
Disabling this option gets things working again for me.

Note that I *do* see undefined instruction exceptions from sshd
regardless of this patch, however I think they're triggered from
something like libcrypto which is prepared to handle the SIGILL.

FWIW, I'm using your ten patches from this series on top of 4.2-rc8 and
I've put the .config here:

  http://www.willdeacon.ukfsn.org/bitbucket/oopsen/pan/pan-tc2.config

Will
