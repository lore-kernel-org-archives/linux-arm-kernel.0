From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 7 May 2012 20:44:38 +0000
Subject: [PATCH] ARM: BCMRING: fix IO mem static mapping
In-Reply-To: <4FA82414.7070407@broadcom.com>
References: <4FA82414.7070407@broadcom.com>
Message-ID: <201205072044.38612.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 May 2012, Jiandong Zheng wrote:
> Fix bcmring IO mem static mapping.

Hi Jiandong Zheng,

There are a few formalities that are wrong with your patches.
First of all, the patches are linewrapped. See
Documentation/email-clients.txt for how to set up thunderbird
so you can send patches correctly, or just use
"git send-email" instead, which simplifies this task. Your commit
messages are not well written. The email subject and the first line
of the description are almost identical, which mean that one will
read the same text twice in the git history.

> This causes bcmring booting issue since v3.2

This long format description however is too short, and it does not
explain why it was broken.

> Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com  <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>

And this line for some reason completely breaks the formatting of
the email address.

> ---
>    arch/arm/mach-bcmring/mm.c |   27 +++++++++++----------------
>    1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-bcmring/mm.c b/arch/arm/mach-bcmring/mm.c
> index 1adec78..b46ea07 100644
> --- a/arch/arm/mach-bcmring/mm.c
> +++ b/arch/arm/mach-bcmring/mm.c
> @@ -31,24 +31,19 @@
>        .type = MT_MEMORY }
> 
>    static struct map_desc bcmring_io_desc[] __initdata = {
> -    IO_DESC(MM_IO_BASE_NAND, SZ_64K),    /* phys:0x28000000-0x28000FFF
> virt:0xE8000000-0xE8000FFF  size:0x00010000 */
> -    IO_DESC(MM_IO_BASE_UMI, SZ_64K),    /* phys:0x2C000000-0x2C000FFF
> virt:0xEC000000-0xEC000FFF  size:0x00010000 */

Here you can see how the line wrapping broke the patch. It is not possible
to apply a patch like this.

My preferred method of receiving patches from subarch maintainers is using
git pull requests, and that would also help solve some of the problems
with your email setup. Patches are ok, too, though.

There are two other things I'd like to discuss with you, now that you've
shown up.

First of all, I'd like to understand where you are heading with the bcmring
platform support. My understanding is that you only support a single SoC
and a single board in there, but there are actually a lot of other products
in the same SoC family that could get supported here. Are any of them still
relevant enough for your company to support upstream? What is your timeline
for adding support for those, and how many other SoCs do you work on?

The other question is about the multiplatform kernel I've recently worked
on. bcmring is the only subarchitecture in Linux that puts header files
in its own directory outside of the mach/*.h hierarchy, which gets in the
way and is rather inconsistent. I've prepared a git branch to clean that
up, see the "testing/bcmring" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for this.
I've also added a patch to clean up some API abuse for MMIO accesses
that might otherwise cause problems. Can you test this branch and see
if everything still works for you?

	Arnd
