From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 30 Mar 2017 10:34:01 +0100
Subject: [kernel-hardening] [RFC v2][PATCH 02/11] lkdtm: add test for
 rare_write() infrastructure
In-Reply-To: <1490811363-93944-3-git-send-email-keescook@chromium.org>
References: <1490811363-93944-1-git-send-email-keescook@chromium.org>
 <1490811363-93944-3-git-send-email-keescook@chromium.org>
Message-ID: <1490866441.10874.44.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-29 at 11:15 -0700, Kees Cook wrote:
> diff --git a/drivers/misc/lkdtm_perms.c b/drivers/misc/lkdtm_perms.c
> index c7635a79341f..8fbadfa4cc34 100644
> --- a/drivers/misc/lkdtm_perms.c
> +++ b/drivers/misc/lkdtm_perms.c
> [...]
> +/* This is marked __wr_rare, so it should ultimately be .rodata. */
> +static unsigned long wr_rare __wr_rare = 0xAA66AA66;
> [...]
> +void lkdtm_WRITE_RARE_WRITE(void)
> +{
> +	/* Explicitly cast away "const" for the test. */

wr_rare isn't actually declared const above though? I don't think
__wr_rare includes a const, apologies if I missed it.

OOI, if wr_rare _were_ const then can the compiler optimise the a pair
of reads spanning the rare_write? i.e. adding const to the declaration
above to get:

    static const unsigned long wr_rare __wr_rare = 0xAA66AA66;
x = wr_read;
rare_write(x, 0xf000baaa);
y = wr_read;

Is it possible that x == y == 0xaa66aa66 because gcc realises the x and
y came from the same const location? Have I missed a clobber somewhere
(I can't actually find a definition of __arch_rare_write_memcpy in this
series so maybe it's there), or is such code expected to always cast
away the const first?

I suppose such constructs are rare in practice in the sorts of places
where rare_write is appropriate, but with aggressive inlining it could
occur as an unexpected trap for the unwary perhaps.

Ian.
