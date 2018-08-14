From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 14 Aug 2018 17:20:53 -0600
Subject: [PATCH 08/13] coresight: Add support for CLAIM tag protocol
In-Reply-To: <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
References: <1533562915-21558-1-git-send-email-suzuki.poulose@arm.com>
 <1533562915-21558-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180814232053.GA5131@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 02:41:50PM +0100, Suzuki K Poulose wrote:
> Add support for the CLAIM tag protocol for negotiating the
> device ownership with other agents trying to use the coresight
> component (internal vs. external). The Coresight architecture
> specifies CLAIM tags (managed via CLAIMSET CLAIMCLR registers)
> to negotiate the ownership of the device. PSCI recommends the
> reservation of the bits in CLAIM tags for self-hosted and external
> debug use. This patch implements the protocol for claiming
> the devices before they are actually used.

I think the first paragraph of the cover letter (minus the reference to the
documentation since you've included it below) would be perfect instead of the
above.

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-priv.h |  7 +++
>  drivers/hwtracing/coresight/coresight.c      | 85 ++++++++++++++++++++++++++++
>  include/linux/coresight.h                    | 20 +++++++
>  3 files changed, 112 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index c11da55..579f349 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -25,6 +25,13 @@
>  #define CORESIGHT_DEVID		0xfc8
>  #define CORESIGHT_DEVTYPE	0xfcc
>  
> +
> +/*
> + * Coresight device CLAIM protocol.
> + * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
> + */
> +#define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
> +
>  #define TIMEOUT_US		100
>  #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)
>  
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index e73ca6a..8f06866 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -128,6 +128,91 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	return -ENODEV;
>  }
>  
> +static inline u32 coresight_read_claim_tags(void __iomem *base)
> +{
> +	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
> +}
> +
> +static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
> +{
> +	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
> +}
> +
> +static inline bool coresight_is_claimed_any(void __iomem *base)
> +{
> +	return coresight_read_claim_tags(base) != 0;
> +}
> +
> +static inline void coresight_set_claim_tags(void __iomem *base)
> +{
> +	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
> +	isb();
> +}
> +
> +static inline void coresight_clear_claim_tags(void __iomem *base)
> +{
> +	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
> +	isb();
> +}
> +
> +/*
> + * coresight_claim_device_unlocked : Claim the device for self-hosted usage
> + * to prevent an external tool from touching this device. As per PSCI
> + * standards, section "Preserving the execution context" => "Debug and Trace
> + * save and Restore", DBGCLAIM[1] is reserved for Self-hosted debug/trace and
> + * DBGCLAIM[0] is reserved for external tools.
> + *
> + * Called with CS_UNLOCKed for the component.
> + * Returns : 0 on success
> + */
> +int coresight_claim_device_unlocked(void __iomem *base)
> +{
> +	if (coresight_is_claimed_any(base))
> +		return -EBUSY;
> +
> +	coresight_set_claim_tags(base);
> +	if (coresight_is_claimed_self_hosted(base))
> +		return 0;
> +	/* There was a race setting the tags, clean up and fail */
> +	coresight_clear_claim_tags(base);
> +	return -EBUSY;
> +}
> +
> +int coresight_claim_device(void __iomem *base)
> +{
> +	int rc;
> +
> +	CS_UNLOCK(base);
> +	rc = coresight_claim_device_unlocked(base);
> +	CS_LOCK(base);
> +
> +	return rc;
> +}
> +
> +/*
> + * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
> + * Called with CS_UNLOCKed for the component.
> + */
> +void coresight_disclaim_device_unlocked(void __iomem *base)
> +{
> +
> +	if (coresight_is_claimed_self_hosted(base))
> +		coresight_clear_claim_tags(base);
> +	else
> +		/*
> +		 * Either we or the external agent doesn't follow
> +		 * the protocol.
> +		 */
> +		WARN_ON_ONCE(1);

When writing "... or the external agent doesn't follow the protocol", I deduce
that an external agent would have trampled our claim tag.  I think this needs
to be said explicitly in the comment.

> +}
> +
> +void coresight_disclaim_device(void __iomem *base)
> +{
> +	CS_UNLOCK(base);
> +	coresight_disclaim_device_unlocked(base);
> +	CS_LOCK(base);
> +}
> +
>  static int coresight_enable_sink(struct coresight_device *csdev,
>  				 u32 mode, void *data)
>  {
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5353582..16151a2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -257,6 +257,13 @@ extern int coresight_enable(struct coresight_device *csdev);
>  extern void coresight_disable(struct coresight_device *csdev);
>  extern int coresight_timeout(void __iomem *addr, u32 offset,
>  			     int position, int value);
> +
> +extern int coresight_claim_device(void __iomem *base);
> +extern int coresight_claim_device_unlocked(void __iomem *base);
> +
> +extern void coresight_disclaim_device(void __iomem *base);
> +extern void coresight_disclaim_device_unlocked(void __iomem *base);
> +
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> @@ -266,6 +273,19 @@ coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
>  static inline void coresight_disable(struct coresight_device *csdev) {}
>  static inline int coresight_timeout(void __iomem *addr, u32 offset,
>  				     int position, int value) { return 1; }
> +static inline int coresight_claim_device_unlocked(void __iomem *base)
> +{
> +	return 0;
> +}
> +
> +static inline int coresight_claim_device(void __iomem *base)
> +{
> +	return 0;
> +}

Returning 0 would give a caller the impression the operation has succeeded when
in fact it didn't.  I think we should return an error code here.

> +
> +static inline void coresight_disclaim_device(void __iomem *base) {}
> +static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
> +
>  #endif
>  
>  #ifdef CONFIG_OF
> -- 
> 2.7.4
> 
