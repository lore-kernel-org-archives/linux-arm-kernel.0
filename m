From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Oct 2013 16:44:02 +0100
Subject: [RFT PATCH v2 3/4] arm64: reduce duplicated code when
 saving/restoring FPSIMD for signal handling
In-Reply-To: <1381674029-430-3-git-send-email-liuj97@gmail.com>
References: <1381674029-430-1-git-send-email-liuj97@gmail.com>
 <1381674029-430-3-git-send-email-liuj97@gmail.com>
Message-ID: <20131014154401.GG7682@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 13, 2013 at 03:20:19PM +0100, Jiang Liu wrote:
> +void fpsimd_prepare_sigctx(struct fpsimd_state *state)
> +{
> +	/* dump the hardware registers to the fpsimd_state structure */
> +	fpsimd_save_state(state);
> +	fpsimd_clear_fpsr();
> +}

What don't particularly like is that you save the FP context and then
corrupt it. Can we get preempted after this function and before we save
it on the signal stack?

-- 
Catalin
