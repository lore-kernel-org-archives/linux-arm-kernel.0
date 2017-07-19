From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 19 Jul 2017 14:52:31 +0100
Subject: [PATCH 07/11] firmware: arm_sdei: Add driver for Software
 Delegated Exceptions
In-Reply-To: <20170515174400.29735-8-james.morse@arm.com>
References: <20170515174400.29735-1-james.morse@arm.com>
 <20170515174400.29735-8-james.morse@arm.com>
Message-ID: <20170719135213.GA1538@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 06:43:55PM +0100, James Morse wrote:
> The Software Delegated Exception Interface (SDEI) is an ARM standard
> for registering callbacks from the platform firmware into the OS.
> This is typically used to implement RAS notifications.
> 
> Add the code for detecting the SDEI version and the framework for
> registering and unregistering events. Subsequent patches will add the
> arch-specific backend code and the necessary power management hooks.
> 
> Currently only shared events are supported.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  drivers/firmware/Kconfig    |   7 +
>  drivers/firmware/Makefile   |   1 +
>  drivers/firmware/arm_sdei.c | 606 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sdei.h        |  98 +++++++
>  include/uapi/linux/sdei.h   |  91 +++++++
>  5 files changed, 803 insertions(+)
>  create mode 100644 drivers/firmware/arm_sdei.c
>  create mode 100644 include/linux/sdei.h
>  create mode 100644 include/uapi/linux/sdei.h

[...]

> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> new file mode 100644
> index 000000000000..d22dda5e0fed
> --- /dev/null
> +++ b/drivers/firmware/arm_sdei.c
> @@ -0,0 +1,606 @@

[...]

> +int sdei_mask_local_cpu(unsigned int cpu)
> +{
> +	int err;
> +	struct arm_smccc_res res;
> +
> +	WARN_ON(preemptible());
> +	err = invoke_sdei_fn(&res, SDEI_1_0_FN_SDEI_PE_MASK, 0, 0, 0, 0, 0);

Randomly responding to an old patch here...


It seems awkward to have to declare res repeatedly when it's basically
unused.  Several callsites seem to do this.  Out of context, this looks
bug-like (though it's not a bug).

Could we make it explicit that the results other than x0 are unwanted by
passing NULL instead?

invoke_sdei_fn (or some downstream function) could declare its own res
for this case, but at least we'd only have to do that in one place.
arm_smccc_smc() and friends (at least the C interface in the headers)
could do something similar.

Cheers
---Dave
