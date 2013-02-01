From: robherring2@gmail.com (Rob Herring)
Date: Fri, 01 Feb 2013 08:15:37 -0600
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: Allow initialisation
 of GIC by DT
In-Reply-To: <20130201105849.GB21191@e106331-lin.cambridge.arm.com>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-3-git-send-email-horms+renesas@verge.net.au>
 <20130131123213.GB7235@e106331-lin.cambridge.arm.com>
 <20130201001119.GO10312@verge.net.au> <20130201003410.GA30007@verge.net.au>
 <20130201105849.GB21191@e106331-lin.cambridge.arm.com>
Message-ID: <510BCE09.7050302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 04:58 AM, Mark Rutland wrote:
> On Fri, Feb 01, 2013 at 12:34:10AM +0000, Simon Horman wrote:
>> On Fri, Feb 01, 2013 at 09:11:19AM +0900, Simon Horman wrote:
>>> On Thu, Jan 31, 2013 at 12:32:13PM +0000, Mark Rutland wrote:
>>>> Hi Simon,
>>>>
>>>> On Thu, Jan 31, 2013 at 01:50:49AM +0000, Simon Horman wrote:

>>>>> +
>>>>> +        gic: interrupt-controller at f0001000 {
>>>>> +                compatible = "arm,cortex-a9-gic";
>>>>> +                #interrupt-cells = <3>;
>>>>> +                #address-cells = <1>;
>>>>
>>>> Why is #address-cells needed here (and without #size-cells)? I see it's in the
>>>> binding document example, but I can't figure out why.
>>>
>>> Its here because I copied the example.
>>> I will see about removing it from here.
> 
> Rob, Grant, do either of you know if there's a reason for this that we've
> missed?
> 
> The gic doesn't have any direct children, and this doesn't seem to be
> some decvicetree interrupt-controller magic.

If you look at of_irq_map_raw, there are cases that look at
#address-cells. Those appear to be only when you have an interrupt-map
though.
> 
> If this is superfluous, how about the patch below?

The docs probably should state #addr-cells is only required with
interrupt-map.

> 
> I took a quick look at arch/arm/boot/dts/. Some gic nodes don't have
> #address-cells, some have it but not #size-cells, and some have both. These
> should probably be cleaned up too.

Some boards are using interrupt-map, so they may need #address-cells. So
I'm inclined to leave things alone.

Rob

> 
> [...]
> 
> Thanks,
> Mark.
> 
> ---->8----
> 
> From dc734edb8040513785429c11e40a420870dc55a4 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Fri, 1 Feb 2013 10:18:05 +0000
> Subject: [PATCH] Docs: gic: remove #address-cells from example
> 
> The gic has no child nodes, and so doesn't need #address-cells. Having
> the property defined in the example only serves as a source of
> confusion.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 62eb8df..45b99ab 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -54,7 +54,6 @@ Example:
>  	intc: interrupt-controller at fff11000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> -		#address-cells = <1>;
>  		interrupt-controller;
>  		reg = <0xfff11000 0x1000>,
>  		      <0xfff10100 0x100>;
> 
