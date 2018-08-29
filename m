From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 29 Aug 2018 08:49:43 -0500
Subject: [PATCH v2] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
In-Reply-To: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
References: <1535535863-1818-1-git-send-email-robert.walker@arm.com>
Message-ID: <20180829084943.eca3716eb2a2141e5eb8e6ee@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Aug 2018 10:44:23 +0100
Robert Walker <robert.walker@arm.com> wrote:

> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
> 
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.9.1 of OpenCSD.  A check for the new struct
> member has been added to the feature check for OpenCSD.
> 
> Signed-off-by: Robert Walker <robert.walker@arm.com>
> ---
...
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -3,6 +3,13 @@
>  
>  int main(void)
>  {
> +	/*
> +	 * Requires ocsd_generic_trace_elem.num_instr_range introduced in
> +	 * OpenCSD 0.9

0.9 != 0.9.1 in the above commit text: which is it?

> +	 */
> +	ocsd_generic_trace_elem elem;
> +	(void)elem.num_instr_range;
> +

This breaks building against older versions of OpenCSD, right?

>  	(void)ocsd_get_version();

Why don't we maintain building against older versions of the library,
and use the version information to make the decision on whether to use
the new feature being introduced in this patch?

Thanks,

Kim
