From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Oct 2017 15:33:23 +0100
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: Add OPPs table for cpu devices
In-Reply-To: <CAMuHMdVbQMGG92sAnWUDzBisSHEdedoSNLWxokv_BTj4eER64Q@mail.gmail.com>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
 <1507209984-17123-3-git-send-email-horms+renesas@verge.net.au>
 <e2e31fd8-b5f8-40a8-df3d-e7726bb8a8e1@arm.com>
 <CAMuHMdVbQMGG92sAnWUDzBisSHEdedoSNLWxokv_BTj4eER64Q@mail.gmail.com>
Message-ID: <381aa5b0-16c4-e826-6556-85ce9a9155e5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/10/17 12:57, Geert Uytterhoeven wrote:
> Hi Sudeep,
> 
> On Thu, Oct 5, 2017 at 5:04 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 05/10/17 14:26, Simon Horman wrote:
>>> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
>>>
>>> Current, OPP tables are defined temporary,
>>> they are being evaluated and adjust in future.
> 
>>> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
>>> @@ -46,6 +46,8 @@
>>>                       power-domains = <&sysc R8A7796_PD_CA57_CPU0>;
>>>                       next-level-cache = <&L2_CA57>;
>>>                       enable-method = "psci";
>>> +                     clocks =<&cpg CPG_CORE R8A7796_CLK_Z>;
>>> +                     operating-points-v2 = <&cluster0_opp>;
>>>               };
>>>
>>>               a57_1: cpu at 1 {
>>> @@ -55,6 +57,7 @@
>>>                       power-domains = <&sysc R8A7796_PD_CA57_CPU1>;
>>>                       next-level-cache = <&L2_CA57>;
>>>                       enable-method = "psci";
>>
>> Just curious why clocks are not specified in secondaries ?
> 
> Thanks for noticing, it would indeed be good to describe the clock dependency
> for all CPU cores.
> 
>> Does this continue work if I hotplug out CPUs in ascending order and
>> then hotplug back in descending order ? Also the current driver or OS
>> may deal with that but not a good assumption when write DT
> 
> Yes that works, as Linux doesn't handle CPU hotplug details.
> CPU hotplug is controlled by PSCI, i.e. out of control of the Linux kernel.
> So it doesn't matter at all what is described here ;-)
> 

Ah no, sorry for not being clear earlier. I was referring to below code
snippet in drivers/cpufreq/cpufreq-dt.c

162         cpu_clk = clk_get(cpu_dev, NULL);

163         if (IS_ERR(cpu_clk)) {

164                 ret = PTR_ERR(cpu_clk);

165                 dev_err(cpu_dev, "%s: failed to get clk: %d\n",
__func__, ret);
166                 return ret;

167         }

Now on systems using r8a7796.dtsi, if you hotplug out all A53s and
hotplug back in A53_3 first, that should trigger cpufreq_driver->init
from cpufreq_online which should result in execution above code.

If that takes patch of__of_clk_get_by_name, then that may be problem.
I was originally point at this when I referred hotplug and was not PSCI
related.

-- 
Regards,
Sudeep
