From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 08:22:12 -0600
Subject: [PATCH 3/8] ARM: imx5: adopt generic_chip irq_domain support
 for tzic
In-Reply-To: <20120213135106.GB2247@r65073-Latitude-D630>
References: <1328980472-11923-1-git-send-email-shawn.guo@linaro.org>
 <1328980472-11923-4-git-send-email-shawn.guo@linaro.org>
 <4F373291.7020407@gmail.com> <20120213135106.GB2247@r65073-Latitude-D630>
Message-ID: <4F391C94.4070202@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2012 07:51 AM, Shawn Guo wrote:
> On Sat, Feb 11, 2012 at 09:31:29PM -0600, Rob Herring wrote:
>> Shawn,
>>
>> On 02/11/2012 11:14 AM, Shawn Guo wrote:
>>> It adopts generic_chip irq_domain support for tzic, so that the
>>> irq_domain initialization for tzic in imx5 DT platform code can be
>>> removed.
>>>
>>
>> As I found in my attempt to re-factor this and we discussed, the init
>> flow is all wrong for mx5.
>>
> But if we put this from point of supporting DT and non-DT with less
> code churning, I would not way it's "wrong", or I would say I made
> it "wrong" on purpose.
> 
>> The mach .init_irq function should call of_irq_init. mx5 is initializing
>> tzic and then calling of_irq_init in the platform init calls which is
>> wrong. Ultimately the compatible list should probably include avic,
>> tzic, gic and any other secondary controllers you have. The of_irq_init
>> callbacks need to do ioremap and initialize the controller.
> 
> Yes, this is absolutely right for DT only support.  But we are
> supporting both DT and non-DT in a single image with the desire of
> less code churning.
> 

You're not saving anything, just delaying changes when you want to
remove the non-DT code paths in the future.

>> You're
>> basically removing the use of of_irq_init here.
>>
> The of_irq_init was added for hacking irqdomain initialization on imx5
> at the first place.  Now the hack is replaced by generic-chip irqdomain
> support, so the of_irq_init goes away here.  And I agree that we need
> it for separating DT from non-DT support, but that belongs to another
> series, and this series is just cleaning up irqdomain support.
> 

No. Those are completely orthogonal. The way it was added for mx5 was
certainly a hack though. of_irq_init has nothing to do with domains.
It's purpose is to initialize interrupt controllers in the right order.
You can't initialize secondary controllers before primary controllers.
It removes the init ordering knowledge from the kernel and uses
knowledge that's already present in the DT.

>> Some more comments below.
>>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/imx51.dtsi            |    6 +++++
>>>  arch/arm/boot/dts/imx53.dtsi            |    6 +++++
>>>  arch/arm/mach-mx5/clock-mx51-mx53.c     |    4 +-
>>>  arch/arm/mach-mx5/imx51-dt.c            |    8 -------
>>>  arch/arm/mach-mx5/imx53-dt.c            |    8 -------
>>>  arch/arm/plat-mxc/include/mach/common.h |    2 +
>>>  arch/arm/plat-mxc/tzic.c                |   32 ++++++++++++++++--------------
>>>  7 files changed, 33 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
>>> index 6663986..a5fda43 100644
>>> --- a/arch/arm/boot/dts/imx51.dtsi
>>> +++ b/arch/arm/boot/dts/imx51.dtsi
>>> @@ -171,6 +171,12 @@
>>>  				status = "disabled";
>>>  			};
>>>  
>>> +			gpt at 73fa0000 {
>>> +				compatible = "fsl,imx51-gpt", "fsl,gpt";
>>> +				reg = <0x73fa0000 0x4000>;
>>> +				interrupts = <39>;
>>> +			};
>>> +
>>>  			uart1: uart at 73fbc000 {
>>>  				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
>>>  				reg = <0x73fbc000 0x4000>;
>>> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
>>> index 5dd91b9..05e6412 100644
>>> --- a/arch/arm/boot/dts/imx53.dtsi
>>> +++ b/arch/arm/boot/dts/imx53.dtsi
>>> @@ -173,6 +173,12 @@
>>>  				status = "disabled";
>>>  			};
>>>  
>>> +			gpt at 53fa0000 {
>>> +				compatible = "fsl,imx53-gpt", "fsl,gpt";
>>> +				reg = <0x53fa0000 0x4000>;
>>> +				interrupts = <39>;
>>> +			};
>>> +
>>>  			uart1: uart at 53fbc000 {
>>>  				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
>>>  				reg = <0x53fbc000 0x4000>;
>>> diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
>>> index 4cb2769..c558cb1 100644
>>> --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
>>> +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
>>> @@ -1593,7 +1593,7 @@ int __init mx51_clocks_init(unsigned long ckil, unsigned long osc,
>>>  
>>>  	/* System timer */
>>>  	mxc_timer_init(&gpt_clk, MX51_IO_ADDRESS(MX51_GPT1_BASE_ADDR),
>>> -		MX51_INT_GPT);
>>> +		       tzic_irq_create_mapping(MX51_INT_GPT));
>>
>> In the DT case, you should be calling irq_of_parse_and_map to setup the
>> timer irq.
>>
>> I really think you need to separate DT and non-DT init functions. You
>> need to ultimately be getting both the base address and the irq from the
>> dts. This applies to both timer and irq controllers.
> 
> Yes, I agree with you I need to do those at some point when we fully
> support DT and get ready to remove the non-DT support completely.  But
> we are not there yet.  Can I cook another series to do that when we
> get there, so that we make this series stay clean and focusing?
> 

Removing non-DT support has nothing to do with having full DT support.

>> If you make the
>> init code better separated, then you won't have the problems with legacy
>> vs. linear domains.
>>
> I do not have any problem here, since both DT and non-DT are using
> linear domain.  Isn't this something encouraged to do?

You are making things harder on yourself trying to get linear domains to
work for non-DT. Just use legacy.

Rob
