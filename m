From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 25 Oct 2018 14:04:12 +0200
Subject: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
In-Reply-To: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
Message-ID: <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/2018 10:27, Viresh Kumar wrote:
> The example text says the capacity value should be 446, while the
> example have it set to 578 instead. Fix the mismatch.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpu-capacity.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 9b5685a1d15d..7a0d6b429c8d 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -61,7 +61,7 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
>  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu at 0 and cpu at 1)
>  supposing cluster0 at max-freq=1100 and custer1 at max-freq=850,
> -final capacities are 1024 for cluster0 and 446 for cluster1
> +final capacities are 1024 for cluster0 and 578 for cluster1
>  
>  cpus {
>  	#address-cells = <2>;

I think it is actually correct. The example is confusing on what the
numbers are. IIUC, it is:

(after normalizing)

dhrystone result on big CPU is 1024 at 1100MHz
dhrystone result on little CPU is 446 at 850MHz

We have to scale the result of the little for 1100MHz in order to compare.

1100/850 = 1.294

dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz

So we put the normalized values 1024 and 577. The arch_topology will
scale 577 back to 446 as it will compute the max capacity based on the
max freq which is 850MHz.

The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
the cpu max capacity, the ones showed in the sysfs).

Did I miss something ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
