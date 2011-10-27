From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 Oct 2011 10:09:53 +0200
Subject: [PATCH v3 1/4] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <1319702185-16108-2-git-send-email-rnayak@ti.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<1319702185-16108-2-git-send-email-rnayak@ti.com>
Message-ID: <20111027080953.GB18360@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 01:26:22PM +0530, Rajendra Nayak wrote:

> +	min_uV = of_get_property(np, "regulator-min-uV", NULL);
> +	if (min_uV)
> +		(*init_data)->constraints.min_uV = be32_to_cpu(*min_uV);
> +	max_uV = of_get_property(np, "regulator-max-uV", NULL);
> +	if (max_uV)
> +		(*init_data)->constraints.max_uV = be32_to_cpu(*max_uV);

If we have min_uV and max_uV we should also set REGULATOR_CHANGE_VOLTAGE
(and similarly for the currents).  

We should also have a way to enable status changes - since there's an
always_on property (which does make sense) I'd suggest that as a first
pass we should enable status changes if always_on is not set (these two
things are a bit redundant in the existing constrints).  This is
slightly risky as you can get a situation where new device driver
support for regulators starts unexpectedly turning off supplies but
that's always going to be a risk with constraints disassociated from the
kernel.
