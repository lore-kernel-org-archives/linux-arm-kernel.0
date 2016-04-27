From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 27 Apr 2016 12:21:19 +0100
Subject: [PATCH V4 16/18] coresight: tmc: implementing TMC-ETF AUX space
 API
In-Reply-To: <1461708634-6327-17-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
 <1461708634-6327-17-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5720A0AF.9090107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/16 23:10, Mathieu Poirier wrote:
> This patch implement the AUX area interfaces required to
> use the TMC (configured as an ETF) from the Perf sub-system.
>
> The heuristic is heavily borrowed from the ETB10 implementation.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +
> +		/*
> +		 * Make sure the new size is aligned in accordance with the
> +		 * requirement explained above.
> +		 */
> +		to_read = handle->size & mask;
> +		/* Move the RAM read pointer up */
> +		read_ptr = (write_ptr + drvdata->size) - to_read;
> +		/* Make sure we are still within our limits */
> +		read_ptr &= ~(drvdata->size - 1);

Correct me if I am wrong, I think this will break for ETR configuration (used from the following
patch 17/18). Since, for ETR, RRP/RWP will return the lower 32bit AXI address (not the queue offset).
So the last step would really spoil the read_ptr. We might have to set the read_ptr by adding the
appropriate offset from DBAL0.

Suzuki
