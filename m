From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 14 Oct 2015 08:50:23 +0200
Subject: [BUG] broken mixer after second resume from mem
In-Reply-To: <561DEE43.5040309@samsung.com>
References: <561CDC33.7050103@collabora.com> <561DEE43.5040309@samsung.com>
Message-ID: <CAAObsKCubVgXTCdLJOZZ3nSXZjdL3G9SjWWuVYPcxLgh5poV6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2015 at 07:55, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 13.10.2015 19:25, Tomeu Vizoso wrote:
>> Hi,
>>
>> have been hunting down a bug on exynos5250-snow which caused both HDMI
>> and LVDS output to be broken after the second resume (with suspend to
>> mem, but not to idle).
>>
>> What I have found is that when powering down the DISP1 power domain
>> while suspending for the second time, the contents of the SRC_TOP3
>> register change from 0x1110550 to 0x1110500. IIUIC, this means that
>> ACLK_200_DISP1 is reparented to XXTI.
>>
>> When the CPU comes up again, that register contains 0x1110550 again, but
>> it's set to 0x1110500 by the code that restores clk registers when resuming:
>>
>> First suspend:
>>
>> exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
>> exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - after
>> exynos5250_clk_suspend: SRC_TOP3 1110550
>> exynos5250_clk_resume: SRC_TOP3 1110550 - before
>> exynos5250_clk_resume: SRC_TOP3 1110550 - after
>> exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
>> exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - after
>>
>>
>> Second suspend:
>>
>> exynos_pd_power: SRC_TOP3 1110550 disp1-power-domain at 100440A0 - before
>> exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - after
>> exynos5250_clk_suspend: SRC_TOP3 1110500
>> exynos5250_clk_resume: SRC_TOP3 1110550 - before
>> exynos5250_clk_resume: SRC_TOP3 1110500 - after
>> exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - before
>> exynos_pd_power: SRC_TOP3 1110500 disp1-power-domain at 100440A0 - after
>>
>
> I am assuming you are talking about current linux-next. The actual
> reparent happens in exynos_pd_power which would indicate the exynos pd
> clock reparenting code. However the domains for Exynos5250 don't have
> any clocks set up for reparenting... which actually might be the issue.
> These clocks should be probably reparented - as it is done for other
> platforms - look at 5420 example (they are glitch-free on both of SoCs).
>
> I've seen a such issues before. The problem is that after some time I
> tend to forget the needed workaround and solution. :)
>
> Try with reparenting necessary clocks. On other platform for some kind
> of similar issue the reset was required for the IP block - DECON
> (actually the mux could not stabilize there which can be observed in one
> of STATUS registers for mux).
>
> Let me know if explanation above is not detailed enough.

Thanks for the reply, I looked at downstream and saw that two clocks
are being reparented and that seems to fix things. Will send a patch
later today.

Regards,

Tomeu

>> I have no idea of why it happens on the second suspend, and also don't
>> know why it doesn't happen when suspending to idle.
>
> As for the idle - domains are probably not gated so the problems just
> does not exist.
>
> BTW as this is display, you can CC some Samsung guys from DRM... they
> know a lot on these stuff. :)
>
> Best regards,
> Krzysztof
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
