From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 08:26:41 -0400
Subject: [PATCH] ARM: mvebu: Fix the operand list in the inline asm of
 armada_370_xp_pmsu_idle_enter
In-Reply-To: <1404483736-16938-1-git-send-email-gregory.clement@free-electrons.com>
References: <1404483736-16938-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140708122641.GW23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 04:22:16PM +0200, Gregory CLEMENT wrote:
> In the inline asm part of the function armada_370_xp_pmsu_idle_enter()
> the input operand was used. The intent here was to let the compiler
> choose this register so it could do the optimization it
> needed.
> 
> However an input operand is not supposed to be modified by the inline
> asm code. This can lead to improper generated instructions.
> 
> In some case generated instruction the compiler made the choice to
> reuse the same register to store the return value. But in the assembly
> part this register was modified, so it can lead to return an wrong
> value.
> 
> The fix is to use a clobber. Thanks to this the compiler will know
> that the value of this register will be modified.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> I found this bug while adding cpu idle support for Armada 370 and only
> recently after rebasing the code on mvebu/soc. So this patch fixes
> something which can really happen even if we didn't notice it on
> Armada XP. Fortunately the code fixed was introduced during this
> release, so there is no need to backport it, just to apply it on
> 3.16-rc.
> 
> Thanks,
> Gregory
> 
>  arch/arm/mach-mvebu/pmsu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to mvebu/fixes with Thomas' Reviewed-by.

thx,

Jason.
