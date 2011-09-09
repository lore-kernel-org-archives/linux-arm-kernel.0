From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 8 Sep 2011 19:46:10 -0700
Subject: [PATCH] ARM: imx: move pwm driver to use platform device id table
In-Reply-To: <CAOMZO5AyQQu3z063yHyDrG3qg_cSMtDWVF0btFw+ZwcUHdmGkw@mail.gmail.com>
References: <1315524142-10566-1-git-send-email-eric.miao@linaro.org>
	<CAOMZO5AybMLPK2Q8RrE9cAemHjGgsz-+Z0-VCtOB5t=rxFrN4w@mail.gmail.com>
	<CAMPhdO-k7yJxnqYdB+N4ZbyTxoASnwaXrWxHzyAR8sB+sJMjQg@mail.gmail.com>
	<CAOMZO5AyQQu3z063yHyDrG3qg_cSMtDWVF0btFw+ZwcUHdmGkw@mail.gmail.com>
Message-ID: <CAMPhdO8LrV+x+k8wQZLR9JqoKGgknL5KOx9taKKB3NN5MheBiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 6:29 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Sep 8, 2011 at 9:49 PM, Eric Miao <eric.miao@linaro.org> wrote:
>> On Thu, Sep 8, 2011 at 5:42 PM, Fabio Estevam <festevam@gmail.com> wrote:
>>> On Thu, Sep 8, 2011 at 8:22 PM, Eric Miao <eric.miao@linaro.org> wrote:
>>>> Signed-off-by: Eric Miao <eric.miao@linaro.org>
>>>> ---
>>>> ?arch/arm/mach-imx/clock-imx25.c ? ? ? ? ? ? ?| ? ?8 ++++----
>>>> ?arch/arm/mach-imx/clock-imx27.c ? ? ? ? ? ? ?| ? ?2 +-
>>>> ?arch/arm/mach-imx/devices-imx25.h ? ? ? ? ? ?| ? ?2 +-
>>>> ?arch/arm/mach-mx5/clock-mx51-mx53.c ? ? ? ? ?| ? ?4 ++--
>>>> ?arch/arm/mach-mx5/devices-imx51.h ? ? ? ? ? ?| ? ?2 +-
>>>> ?arch/arm/plat-mxc/devices/platform-mxc_pwm.c | ? ?4 ++--
>>>> ?arch/arm/plat-mxc/pwm.c ? ? ? ? ? ? ? ? ? ? ?| ? 19 ++++++++++++++++---
>>>> ?7 files changed, 27 insertions(+), 14 deletions(-)
>>>
>>> Looks like you missed mx1, mx21, mx31, mx27, mx35 and mx53.
>>
>> Did a search of 'mxc_pwm' string, but they didn't seem to be there?
>> which is a bit strange.
>
> The PWM clock are currently registered differently for each SoC:
>
> On MX21: _REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])

The NULL pointer should be fixed first then.

> On MX25: _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
> On MX27: _REGISTER_CLOCK("mxc_pwm.0", NULL, pwm_clk)
> On MX31: _REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> On MX35: _REGISTER_CLOCK(NULL, "pwm", pwm_clk)
> On MX51: ?_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
>

Another git grep of the imx_add_mxc_pwm shows:

linux-2.6$ git grep imx_add_mxc_pwm
arch/arm/mach-imx/devices-imx25.h:      imx_add_mxc_pwm("imx25-pwm",
&imx25_mxc_pwm_data[id])
arch/arm/mach-mx5/devices-imx51.h:      imx_add_mxc_pwm("imx51-pwm",
&imx51_mxc_pwm_data[id])
arch/arm/plat-mxc/devices/platform-mxc_pwm.c:struct platform_device
*__init imx_add_mxc_pwm(const char *name,
arch/arm/plat-mxc/include/mach/devices-common.h:struct platform_device
*__init imx_add_mxc_pwm(

So I assume only imx25 and imx51 boards are registering the pwm
device. If other i.mx are registering the mxc_pwm device, they should
have turned up in the 'git grep mxc_pwm' list then, but unfortunately
I didn't find them. Unless it's using even opaque code for the registration??


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
