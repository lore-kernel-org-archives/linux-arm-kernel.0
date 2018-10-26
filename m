From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 26 Oct 2018 10:30:32 +0200
Subject: [PATCH] dt-bindings: arm: Fix cpu capacity mismatch in example
In-Reply-To: <20181026041107.4hofhlcubbo5claq@vireshk-i7>
References: <138600f5d504b41202a29a1e130a7aa4e51f1925.1540451976.git.viresh.kumar@linaro.org>
 <80206cb7-b550-1cf6-abf4-e4b17de4cdb5@linaro.org>
 <20181026041107.4hofhlcubbo5claq@vireshk-i7>
Message-ID: <d4d6af05-61f1-4123-c2dc-4ee0946f79e8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/2018 06:11, Viresh Kumar wrote:
> On 25-10-18, 14:04, Daniel Lezcano wrote:
>> I think it is actually correct. The example is confusing on what the
>> numbers are. IIUC, it is:
>>
>> (after normalizing)
>>
>> dhrystone result on big CPU is 1024 at 1100MHz
>> dhrystone result on little CPU is 446 at 850MHz
>>
>> We have to scale the result of the little for 1100MHz in order to compare.
>>
>> 1100/850 = 1.294
>>
>> dhrystone result on little CPU is 446 * 1.294 = 577 at 1100MHz
>>
>> So we put the normalized values 1024 and 577. The arch_topology will
>> scale 577 back to 446 as it will compute the max capacity based on the
>> max freq which is 850MHz.
>>
>> The *final* capacities are 1024 for cluster0 and 446 for cluster1 (read
>> the cpu max capacity, the ones showed in the sysfs).
>>
>> Did I miss something ?
> 
> No. What about making it more clear in the example to save the next idiot (like
> me) from wasting time :)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> index 9b5685a1d15d..d061e6575bde 100644
> --- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> +++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
> @@ -61,7 +61,10 @@ mhz values (normalized w.r.t. the highest value found while parsing the DT).
>  Example 1 (ARM 64-bit, 6-cpu system, two clusters):
>  capacities-dmips-mhz are scaled w.r.t. 1024 (cpu at 0 and cpu at 1)
>  supposing cluster0 at max-freq=1100 and custer1 at max-freq=850,
> -final capacities are 1024 for cluster0 and 446 for cluster1
> +final capacities are 1024 for cluster0 and 446 for cluster1.
> +Note that the values mentioned below in the example (1024 and 578)
> +aren't normalized based on max frequency of each cluster and that is
> +left for the operating system to do.

Yes, it will help but if you want to make things even more clear, I
suggest to elaborate the text a bit and give the numbers above to
explain (1100/850=1.294, 446 * 1.294 = 577, ...)


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
