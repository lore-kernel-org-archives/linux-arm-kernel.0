From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Dec 2016 18:58:24 +0000
Subject: [PATCHv4 10/10] arm64: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <1480445729-27130-11-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-11-git-send-email-labbott@redhat.com>
Message-ID: <20161206185823.GJ24177@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 10:55:29AM -0800, Laura Abbott wrote:
> 
> +	WARN(!__is_lm_address(x),
> +	     "virt_to_phys used for non-linear address :%pK\n", (void *)x);

Nit: s/ :/: /

It might be worth adding %pS too; i.e.

	WARN(!__is_lm_address(x),
	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
	     (void *)x, (void *)x);

... that way we might get a better idea before we have to resort to
grepping objdump output.

Other than that this looks good to me. This builds cleanly with and
without DEBUG_VIRTUAL enabled, and boots happily with DEBUG_VIRTUAL
disabled.

With both DEBUG_VIRTUAL and KASAN, I'm hitting a sea of warnings from
kasan_init at boot time, but I don't think that's a problem with this
patch as such, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
