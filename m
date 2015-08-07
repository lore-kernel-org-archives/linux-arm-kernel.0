From: robdclark@gmail.com (Rob Clark)
Date: Thu, 6 Aug 2015 21:19:31 -0400
Subject: [PATCH v1 4/7] ARM: dts: apq8064: Add MDP support
In-Reply-To: <55C2B801.1030806@codeaurora.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088049-17479-1-git-send-email-srinivas.kandagatla@linaro.org>
 <55C2B801.1030806@codeaurora.org>
Message-ID: <CAF6AEGtFM-_boOYsnzp5DXSSATFkBiJ5Bj=PVTXy=-ZzXi1x5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 5, 2015 at 9:27 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/28/2015 05:54 AM, Srinivas Kandagatla wrote:
>>
>> @@ -618,5 +633,77 @@
>>                         compatible = "qcom,tcsr-apq8064", "syscon";
>>                         reg = <0x1a400000 0x100>;
>>                 };
>> +
>> +               hdmi: qcom,hdmi-tx at 4a00000 {
>> +                       compatible = "qcom,hdmi-tx-8960";
>> +                       reg-names = "core_physical";
>> +                       reg = <0x04a00000 0x1000>;
>> +                       interrupts = <GIC_SPI 79 0>;
>> +                       clock-names =
>> +                           "core_clk",
>> +                           "master_iface_clk",
>> +                           "slave_iface_clk";
>> +                       clocks =
>> +                           <&mmcc HDMI_APP_CLK>,
>> +                           <&mmcc HDMI_M_AHB_CLK>,
>> +                           <&mmcc HDMI_S_AHB_CLK>;
>> +                       qcom,hdmi-tx-ddc-clk = <&tlmm_pinmux 70
>> GPIO_ACTIVE_HIGH>;
>> +                       qcom,hdmi-tx-ddc-data = <&tlmm_pinmux 71
>> GPIO_ACTIVE_HIGH>;
>> +                       qcom,hdmi-tx-hpd = <&tlmm_pinmux 72
>> GPIO_ACTIVE_HIGH>;
>
>
> These should use standard "-gpios" syntax. Please fix the binding/driver.

With this, and a couple of the other bindings, I'd chosen to follow to
follow the downstream bindings simply because I still need to use
downstream kernel on a handful of devices (for example, I have no a4xx
device which runs anything close to an upstream kernel, yet still
quite a lot of work to do in userspace/mesa there)..  this might be a
scenario that other kernel dev's in other subsystems aren't really
familiar with, but when it comes to gpu's, really only 10% or less of
the driver is in the kernel.  There is a massive sh**-ton of
complexity in terms of cmdstream building in userspace.

But if the change to do things upstream is not too intrusive I'd be
willing to carry the 'revert' patch as a downstream patch on top of
upstream.. or if we could reasonably support both bindings, that is
also an option.  Mostly I just haven't had time to look into it, since
unlike other drivers, when it comes to gpu stuff, the kernel is only
the tip of the (inverted) iceberg..

>> +                       pinctrl-names = "default";
>> +                       pinctrl-0 = <&hdmi_pinctrl>;
>> +               };
>> +
>> +               gpu: qcom,adreno-3xx at 4300000 {
>> +                       compatible = "qcom,adreno-3xx";
>> +                       reg = <0x04300000 0x20000>;
>> +                       reg-names = "kgsl_3d0_reg_memory";
>> +                       interrupts = <GIC_SPI 80 0>;
>> +                       interrupt-names = "kgsl_3d0_irq";
>> +                       clock-names =
>> +                           "core_clk",
>> +                           "iface_clk",
>> +                           "mem_clk",
>> +                           "mem_iface_clk";
>
>
> Please drop "_clk" and fix driver code as we've done for all other drivers.
>
>> +                       clocks =
>> +                           <&mmcc GFX3D_CLK>,
>> +                           <&mmcc GFX3D_AHB_CLK>,
>> +                           <&mmcc GFX3D_AXI_CLK>,
>> +                           <&mmcc MMSS_IMEM_AHB_CLK>;
>> +                       qcom,chipid = <0x03020002>;
>> +                       qcom,gpu-pwrlevels {
>> +                               compatible = "qcom,gpu-pwrlevels";
>> +                               qcom,gpu-pwrlevel at 0 {
>> +                                       qcom,gpu-freq = <450000000>;
>> +                               };
>> +                               qcom,gpu-pwrlevel at 1 {
>> +                                       qcom,gpu-freq = <27000000>;
>> +                               };
>> +                       };
>
>
> These should be OPPs. I see in the cover-letter we're asking to ignore this
> part of the binding. When is the binding and driver going to be fixed? The
> dts has been out of tree for quite some time and I assume work has been
> progressing on the driver even without this dts being in mainline so it
> doesn't make sense how pushing half-baked dts upstream is going to help. In
> fact, it's going to make things worse if someone complains that we're not
> maintaining backwards compatibility and then have to hack up driver code to
> work both ways. At which point there's practically zero incentive to change
> anything in the binding or driver. It's better to fix the driver now and
> avoid these sorts of problems entirely.

again, it is a bit awkward thanks to having to deal with downstream
kernels while upstream catches up..

It does seem interesting to move to cpufreq for managing the gpu
speed, and maybe doing something more clever than all-or-nothing freq
scaling..  but yet again something where I really haven't had time to
investigate beyond "yeah, that seems like a good idea"..

It would be *really* nice if we had some mechanism to mark bindings
that we are not ready yet to call ABI, since on one hand we have an
upstream gpu driver and corresponding userspace to actually have some
interesting some interesting (ie. not just buildroot and serial
console) stuff running on an upstream kernel on actual devices.  And
that is a nice situation that I wouldn't have even thought possible a
few years ago.  But otoh, I agree that we shouldn't call these
bindings final abi.

Anyways, patches welcome.. bonus points if they are not too intrusive
to revert (for the downstream kernels I have to deal with) or if they
continue to support the downstream bindings (for now, until I don't
have to care about downstream kernels)..

BR,
-R


> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
