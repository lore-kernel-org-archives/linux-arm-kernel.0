From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 21:58:46 +0000
Subject: [PATCH 2/7] arm64: sdei: Always use sdei stack for sdei events
In-Reply-To: <1537970184-44348-3-git-send-email-julien.thierry@arm.com>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-3-git-send-email-julien.thierry@arm.com>
Message-ID: <20181107215844.GC12248@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 02:56:19PM +0100, Julien Thierry wrote:
> SDEI events can occur at any point, including when the stack pointer is
> not aligned. SP could be modified to respect alignment 16-byte alignement,
> but there is a need to deal with code using SP as scratch register.
> 
> Always reserve the SDEI stacks to handle its events.
> 
> Since stack allocation relies on VMAPed stacks, lets make SDEI depend on
> VMAP_STACK.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> ---
>  arch/arm64/include/asm/sdei.h |  2 --
>  arch/arm64/kernel/entry.S     |  2 --
>  arch/arm64/kernel/sdei.c      | 23 ++++++++---------------
>  drivers/firmware/Kconfig      |  1 +
>  4 files changed, 9 insertions(+), 19 deletions(-)

One side-effect of this change is that SDEI cannot be enabled in conjunction
with KASAN. James -- are you ok with that?

Will
