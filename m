From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 17 Apr 2015 13:49:37 +0100
Subject: [PATCH] clocksource: arm_global_timer: Detect if gt is usable
 with CPU_FREQ
In-Reply-To: <552CCA7A.3090306@st.com>
References: <552BFED9.3020105@adapteva.com> <552CC490.4010002@linaro.org>
 <552CCA7A.3090306@st.com>
Message-ID: <20150417124937.GA32388@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini, Ola, Maxime,

On Tue, 14 Apr 2015, Maxime Coquelin wrote:
> On 04/14/2015 09:41 AM, Srinivas Kandagatla wrote:
> >+Adding Pete and Maxime

Thanks Srini, as I wouldn't have seen this otherwise.

<snip>
> >>+
> >
> >This patch would not let the SOC like STiH415/416 or zynq with
> >"tied-to-cpu-freq" property to boot with multi_v7_defconfig. Which
> >is not correct thing to do, as STi SOC's do not use cpufreq driver
> >however the tick is tied to this clocksource.
> Yes, you are right, but I don't see any cleaner way to do this.
> 
> On STi, we have another timer we can use as a clocksource when doing
> CPU Freq, the ST LPC timer.
> It is not upstreamed yet, but we will try to have it for next release.

I just sent a series to add the ST LPC timer to LKML, see here 
https://lkml.org/lkml/2015/4/17/181. I've tested this on stih410 and it works ok.

> I propose we set the "tied-to-cpu-freq" in GT node of STi family as
> soon as we enable the LPC timer one.
> Doing that, the STi boot won't break in multi_v7 config.

However this lpc timer IP does not exist on stih415/6 SoCs, and I can't (so far at least)
see any other timer which we could use. So basically we would still have a breakage on
stih415/6 STi platforms with this proposed change.

Upstreaming st_lpc.c timer is still worthwhile though as it paves the way for adding cpufreq
support upstream for stih407 family.

regards,

Peter.
