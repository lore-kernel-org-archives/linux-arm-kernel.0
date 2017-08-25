From: mickael.guene@st.com (Mickael GUENE)
Date: Fri, 25 Aug 2017 06:23:44 +0000
Subject: [PATCH v2 0/8] ELF-FDPIC support for ARM
In-Reply-To: <alpine.LFD.2.20.1708241114090.14288@knanqh.ubzr>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
 <20170817083716.GN20805@n2100.armlinux.org.uk>
 <alpine.LFD.2.20.1708231158090.14288@knanqh.ubzr>
 <38b1d822-345d-0b79-6d44-b78649e46efb@arm.com>
 <alpine.LFD.2.20.1708240834210.14288@knanqh.ubzr>
 <770523b1-49f6-2033-ff68-027dae1d53fc@st.com>
 <alpine.LFD.2.20.1708241114090.14288@knanqh.ubzr>
Message-ID: <dcc24d72-c081-c1b6-3677-37087f715837@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

  Thanks for explanation.

Regards
Mickael

On 08/24/2017 05:48 PM, Nicolas Pitre wrote:
> On Thu, 24 Aug 2017, Mickael GUENE wrote:
> 
>> Hi Nicolas,
>>
>>> The first one is.
>>    It also seems to me that 'Add tls support for cortex-m cpu family'
>> patch is missing. There is the one that add the get_tls syscall but
>> not this one which enable usage for cortex-m family.
> 
> The patch titled "Add tls support for cortex-m cpu family" in your
> repository does 3 things:
> 
> - It defines switch_tls to switch_tls_none. Without the patch the
>    default is switch_tls_software. But this has no purpose as on Cortex-M
>    targets there is simply no switch_tls usage at all. The switch_tls
>    macro is invoked in entry-armv.S within __switch_to whereas Cortex-M
>    uses a different implementation of __switch_to in entry-v7m.S.
> 
> - The patch also defines has_tls_reg to 0. That's the same as de default
>    without the patch.
> 
> - It also defines tls_emu to 1. That makes no sense as this is for ARMv6
>    that lack the dedicated CP15 register and is completely wrong for
>    Cortex-M. I suspect the actual reason for defining this to 1 was a
>    dubious workaround to prevent set_tls() from storing the TLS value at
>    the absolute address 0xffff0ff0. In recent kernels that particular
>    code is properly conditioned on CONFIG_KUSER_HELPERS instead.
> 
> So in the current mainline kernel this patch is useless. This is why I
> didn't consider it.
> 
> 
> Nicolas
> 
