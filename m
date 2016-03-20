From: robh@kernel.org (Rob Herring)
Date: Sat, 19 Mar 2016 20:15:17 -0500
Subject: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
In-Reply-To: <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
Message-ID: <20160320011517.GA17705@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 02:24:08PM +0000, Juri Lelli wrote:
> ARM systems may be configured to have cpus with different power/performance
> characteristics within the same chip. In this case, additional information
> has to be made available to the kernel (the scheduler in particular) for it
> to be aware of such differences and take decisions accordingly.
> 
> Therefore, this patch aims at standardizing cpu capacities device tree
> bindings for ARM platforms. Bindings define cpu capacity parameter, to
> allow operating systems to retrieve such information from the device tree
> and initialize related kernel structures, paving the way for common code in
> the kernel to deal with heterogeneity.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
> 
> Changes from v1:
>  - removed section regarding capacity-scale
>  - added information regarding normalization
> ---
>  .../devicetree/bindings/arm/cpu-capacity.txt       | 222 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/cpus.txt     |   9 +
>  2 files changed, 231 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cpu-capacity.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> new file mode 100644
> index 0000000..fdfc453
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -0,0 +1,222 @@
> +==========================================
> +ARM CPUs capacity bindings
> +==========================================
> +
> +==========================================
> +1 - Introduction
> +==========================================
> +
> +ARM systems may be configured to have cpus with different power/performance
> +characteristics within the same chip. In this case, additional information
> +has to be made available to the kernel (the scheduler in particular) for
> +it to be aware of such differences and take decisions accordingly.
> +
> +==========================================
> +2 - CPU capacity definition
> +==========================================
> +
> +CPU capacity is a number that provides the scheduler information about CPUs
> +heterogeneity. Such heterogeneity can come from micro-architectural differences
> +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> +context is about differing performance characteristics; this binding tries to
> +capture a first-order approximation of the relative performance of CPUs.
> +
> +One simple way to estimate CPU capacities is to iteratively run a well-known
> +CPU user space benchmark (e.g, sysbench) on each CPU at maximum frequency and
> +then normalize values w.r.t.  the best performing CPU.  One can also do a
> +statistically significant study of a wide collection of benchmarks, but pros
> +of such an approach are not really evident at the time of writing.

I'll say again what I did previously. I don't have a problem this being 
in DT, but I want to see a defined method for determining the value. The 
above is a pretty vague statement. That can be run X to generate the 
value on the cpu. Or ARM providing the "golden" value for each core. As 
you said, it is only a 1st order approximation, so vendor to vendor 
implementation variations should not matter. 

I also worry about what happens in more complex cases with lots of 
possible OPPs such as Qualcomm chips. This single value may not be 
sufficient.

Rob
