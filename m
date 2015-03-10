From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 10 Mar 2015 14:43:57 +0200
Subject: [PATCH] video: treat signal like timeout as failure
In-Reply-To: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
Message-ID: <54FEE70D.3010307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/15 07:23, Nicholas Mc Guire wrote:
> if(!wait_for_completion_interruptible_timeout(...))
> only handles the timeout case - this patch adds handling the
> signal case the same as timeout and cleans up.
> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
> 
> Only the timeout case was being handled, return of 0 in 
> wait_for_completion_interruptible_timeout, the signal case (-ERESTARTSYS)
> was treated just like the case of successful completion, which is most 
> likely not reasonable.
> 
> Note that exynos_mipi_dsi_wr_data/exynos_mipi_dsi_rd_data return values
> are not checked at the call sites in s6e8ax0.c (cmd_read/cmd_write)!
> 
> This patch simply treats the signal case the same way as the timeout case,
> by releasing locks and returning 0 - which might not be the right thing to
> do - this needs a review by someone knowing the details of this driver.

While I agree that this patch is a bit better than the current state,
the code still looks wrong as Russell said.

I can merge this, but I'd rather have someone from Samsung look at the
code and change it to use wait_for_completion_killable_timeout() if
that's what this code is really supposed to use.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/43bc402a/attachment.sig>
