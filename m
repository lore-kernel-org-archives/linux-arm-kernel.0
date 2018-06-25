From: joe@perches.com (Joe Perches)
Date: Mon, 25 Jun 2018 09:23:51 -0700
Subject: [PATCH v2 3/6] coresight: Introduce support for Coresight
 Address Translation Unit
In-Reply-To: <20180625112213.23492-4-suzuki.poulose@arm.com>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
 <20180625112213.23492-4-suzuki.poulose@arm.com>
Message-ID: <1dab29ef47d77c2456ee2500a4636f8793b53354.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-06-25 at 12:22 +0100, Suzuki K Poulose wrote:
> Add the initial support for Coresight Address Translation Unit, which
> augments the TMC in Coresight SoC-600 by providing an improved Scatter
> Gather mechanism. CATU is always connected to a single TMC-ETR and
> converts the AXI address with a translated address (from a given SG
> table with specific format). The CATU should be programmed in pass
> through mode and enabled even if the ETR doesn't use the translation
> by CATU.
[]
> diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
[]
> +static inline bool coresight_is_catu_device(struct coresight_device *csdev)
> +{
> +	enum coresight_dev_subtype_helper subtype;
> +
> +	/* Make the checkpatch happy */
> +	subtype = csdev->subtype.helper_subtype;
> +
> +	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
> +	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> +	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
> +}

I believe you should not make checkpatch happy here
by using a temporary but use the most readable form.

Probably the most readable form is:

	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
	       csdev->subtype.helper_subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;

where restricting line length to 80 columns is not useful
because the identifiers are very long.  The identifiers
are possibly longer than necessary.
