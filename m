From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Dec 2011 09:00:44 -0600
Subject: [PATCH V3 4/7] cpufreq: add generic cpufreq driver
In-Reply-To: <20111219143913.GI2351@totoro>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
 <1324264903-15395-5-git-send-email-richard.zhao@linaro.org>
 <20111219100512.GC2459@totoro> <20111219141925.GA1789@richard-laptop>
 <20111219143913.GI2351@totoro>
Message-ID: <4EEF519C.4090808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2011 08:39 AM, Jamie Iles wrote:
> On Mon, Dec 19, 2011 at 10:19:29PM +0800, Richard Zhao wrote:
>> On Mon, Dec 19, 2011 at 10:05:12AM +0000, Jamie Iles wrote:
>>> Hi Richard,
>>>
>>> On Mon, Dec 19, 2011 at 11:21:40AM +0800, Richard Zhao wrote:
>>>> It support single core and multi-core ARM SoCs. But currently it assume
>>>> all cores share the same frequency and voltage.
>>>>
>>>> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/cpufreq/generic-cpufreq    |    7 +
>>>>  drivers/cpufreq/Kconfig                            |    8 +
>>>>  drivers/cpufreq/Makefile                           |    2 +
>>>>  drivers/cpufreq/generic-cpufreq.c                  |  251 ++++++++++++++++++++
>>>>  4 files changed, 268 insertions(+), 0 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/generic-cpufreq
>>>>  create mode 100644 drivers/cpufreq/generic-cpufreq.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/cpufreq/generic-cpufreq b/Documentation/devicetree/bindings/cpufreq/generic-cpufreq
>>>> new file mode 100644
>>>> index 0000000..15dd780
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/cpufreq/generic-cpufreq
>>>> @@ -0,0 +1,7 @@
>>>> +Generic cpufreq driver
>>>> +
>>>> +Required properties in /cpus/cpu at 0:
>>>> +- compatible : "generic-cpufreq"
>>>
>>> I'm not convinced this is the best way to do this.  By requiring a 
>>> generic-cpufreq compatible string we're encoding Linux driver 
>>> information into the hardware description.  The only way I can see to 
>>> avoid this is to provide a generic_clk_cpufreq_init() function that 
>>> platforms can call in their machine init code to use the driver.

Agreed on the compatible string. It's putting Linux specifics into DT.

You could flip this around and have the module make a call into the
kernel to determine whether to initialize or not. Then platforms could
set a flag to indicate this.

>> It'll prevent the driver from being a kernel module.
> 
> Hmm, that's not very nice either!  I guess you _could_ add an 
> of_machine_is_compatible() check against a list of compatible machines 
> in the driver but that feels a little gross.  Hopefully Rob or Grant 
> have a good alternative!
> 

What does cpufreq core do if multiple drivers are registered? Perhaps a
ranking is needed and this would only get enabled if there are no other
drivers and other conditions like having the clock "cpu" present are met.

Rob

>> Hi Grant & Rob,
>>
>> Could you comment?
>>
>>>
>>>> +- cpu-freqs : cpu frequency points it support
>>>> +- cpu-volts : cpu voltages required by the frequency point at the same index
>>>> +- trans-latency :  transition_latency
>>>> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>>>> index e24a2a1..216eecd 100644
>>>> --- a/drivers/cpufreq/Kconfig
>>>> +++ b/drivers/cpufreq/Kconfig
>>>> @@ -179,6 +179,14 @@ config CPU_FREQ_GOV_CONSERVATIVE
>>>>  
>>>>  	  If in doubt, say N.
>>>>  
>>>> +config GENERIC_CPUFREQ_DRIVER
>>>> +	bool "Generic cpufreq driver using clock/regulator/devicetree"
>>>> +	help
>>>> +	  This adds generic CPUFreq driver. It assumes all
>>>> +	  cores of the CPU share the same clock and voltage.
>>>> +
>>>> +	  If in doubt, say N.
>>>
>>> I think this needs dependencies on HAVE_CLK, OF and REGULATOR.
>> right, Thanks. I can not check clk before generic clock framework
>> come in.
>> Added:
>> 	depends on OF && REGULATOR
>> 	select CPU_FREQ_TABLE
> 
> You can still use HAVE_CLK.  That symbol has been around for ages and 
> any platform implementing the clk API should select it so it's fine to 
> depend on it even before there is a generic struct clk.
> 
> Jamie
