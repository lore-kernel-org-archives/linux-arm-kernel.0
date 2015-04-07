From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 7 Apr 2015 14:46:34 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <5523C5F5.6000604@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>
 <1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>
 <551976F1.1000605@collabora.co.uk>
 <CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>
 <551AFCCE.4050404@collabora.co.uk> <551BD07E.2090506@samsung.com>
 <551BDA0A.7010704@collabora.co.uk> <551C2B6D.4010001@samsung.com>
 <551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
 <5523B878.8040304@collabora.co.uk>
 <5523C5F5.6000604@collabora.co.uk>
Message-ID: <CA+Ln22FrvQQ_pX7ELG-jYriGkQHmtX3aUHYqsc_-CRXcc4zxbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-07 13:56 GMT+02:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> So I disabled the sss clock before trying a S2R:
>
> # devmem 0x10018800 32 0xFFFFFFFB
> (CLK_SSS in CLK_GATE_IP_G2D is gated)
>
> and S2R worked anyways but I see that CLK_GATE_IP_G2D is reset to
> its default value on S2R so maybe that is why it works anyways?

Does the driver restore its value on resume (i.e. has it in the
save/restore array)? Remember that suspend causes all clock registers
to be reset. Then some of them will be configured by the lowest
bootloader stage after wake-up reset, but the kernel needs to restore
all of them.

>
> # devmem 0x10018800
> 0xFFFFFFFF (all CLK_GATE_IP_G2D clocks enabled including CLK_SSS)
>
> Does this shed any more light? Could the problem be that the sss
> clock parent (aclk266_g2d) is gated during S2R? Is the SSS module
> required for S2R or is just that CLK_SSS prevents the parent to
> be gated and so it is another red herring?

Does the board use secure firmware? If yes, it might require to do
some encryption on suspend, so if the firmware is broken and doesn't
control the clock itself, it might need the SSS clock to be running,
when the SLEEP SMC operation is called.

Anyway, I just realized that Exynos4 also need several clocks to be
ungated on suspend and this is handled by code [1] based on arrays
[2].

[1] http://lxr.free-electrons.com/source/drivers/clk/samsung/clk-exynos4.c#L309
[2] http://lxr.free-electrons.com/source/drivers/clk/samsung/clk-exynos4.c#L276

Could this method work for your case as well? There would be no need
to call any clock API at all, just low level register writes, which is
okay, since this is a low level driver anyway.

Best regards,
Tomasz
