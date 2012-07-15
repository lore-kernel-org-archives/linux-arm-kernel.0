From: rob@landley.net (Rob Landley)
Date: Sun, 15 Jul 2012 15:45:42 -0500
Subject: [RESEND PATCH 1/1] clk: add DT support for clock gating control
In-Reply-To: <4FFFED7C.9050406@googlemail.com>
References: <4FFE7979.4060000@googlemail.com> <4FFEBF8A.1020700@gmail.com>
 <4FFECC4E.4070001@googlemail.com> <4FFF93DC.30103@gmail.com>
 <4FFFED7C.9050406@googlemail.com>
Message-ID: <50032BF6.9000704@landley.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I believe clock anything is Thomas Gleixner, just making sure he's seen
it...

Rob

On 07/13/2012 04:42 AM, Sebastian Hesselbarh wrote:
> On 07/13/2012 05:19 AM, Rob Herring wrote:
>> What's implemented in Linux should not define the binding. The binding
>> should describe the hardware.
>> [...]
>> True, but not your problem to implement. A binding doesn't necessarily
>> mean there is a full Linux implementation. We just don't want to create
>> something only to find others need something completely different.
> 
> Ok, what about a DT describing the following for a simple register-based
> clock gating controller and the corresponding gated-clock independent of
> the controller. I am sure there are a bunch of SoCs out there that
> control their clock gates by writing some bits to a register. If that
> DT description matches your expectations, I ll prepare patches with
> documentation and implementation for common clock framework.
> 
> Sebastian
> 
> -- 
>  /* Simple clock gating controller based on bitmasks and register */
> cgc: clock-gating-control at f1000000 {
>   compatible = "clock-gating-control-register";
>   reg = <0xf1000000 0x4>;
> 
>   /* Clock gating control with one bit at bit position 0
>      enable with (1<<0), disable with (0<<0) */
>   cgctrl_usb0: cgc_usb0 {
>     clock-gating-control,shift = <0>;
>     clock-gating-control,mask = <1>;
>     clock-gating-control,enable = <1>;
>     clock-gating-control,disable = <0>;
>   };
> 
>   /* Clock gating control with two bits at bit position 1-2
>      enable with (2<<1), disable with (0<<1) */
>   cgctrl_sata: cgc_sata {
>     clock-gating-control,shift = <1>;
>     clock-gating-control,mask = <3>;
>     clock-gating-control,enable = <2>;
>     clock-gating-control,disable = <0>;
>   };
> };
> 
> /* Generic clock gate description that can be used with
>    any clock gating controller */
> cg_usb0: clockgate at 0 {
>   compatible = "gated-clock";
>   #clock-cells = <0>;
>   clocks = <&osc>;
>   clock-gate-control = <&cgctrl_usb0>;
> };
> 


-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
