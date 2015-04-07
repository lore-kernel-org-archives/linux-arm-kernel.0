From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 07 Apr 2015 13:56:37 +0200
Subject: [RFC PATCH v3 2/2] clk: exynos5420: Make sure MDMA0 clock is
 enabled during suspend
In-Reply-To: <5523B878.8040304@collabora.co.uk>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>	<1427730803-28635-3-git-send-email-javier.martinez@collabora.co.uk>	<CA+Ln22FBpuzR06qCsVc7SXtLX2mhf901vDE5D-mT1+ijZ2G3sg@mail.gmail.com>	<551976F1.1000605@collabora.co.uk>	<CAM4voanL3A=dS8Z-ovi_-EDi9ctyaxZkvjajp+3ZjyNAnqR1aQ@mail.gmail.com>	<551AFCCE.4050404@collabora.co.uk>	<551BD07E.2090506@samsung.com>	<551BDA0A.7010704@collabora.co.uk>	<551C2B6D.4010001@samsung.com>	<551C71A5.1070903@collabora.co.uk>
 <CAM4voakS8PnatqRTW5gkD0NNKD9gW9Tuv5p-ekxFhKN5NcuBCQ@mail.gmail.com>
 <5523B878.8040304@collabora.co.uk>
Message-ID: <5523C5F5.6000604@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2015 12:59 PM, Javier Martinez Canillas wrote:
> 
> So IIUC the CG_STATUS0 bits were a red herring and the real problem
> is that the aclk266_g2d needs to be enabled during suspend (although
> we still don't know why).
> 
> It seems were are at a dead end now. Without being able to ask the HW
> Samsung folks we would never know what's going on here...
> 

Ok, I found another interesting data point. ACLK_266_G2D has as
constraints that CG_STATUS0[21:22] needs to be 0 before gating
the clock and as I mentioned before those are associated with
the SSS and SSS_SLIM HW crypto modules according the docs I've.

So I looked at the clock used by the SSS module and found that
CLK_SSS parent is ACLK_266_G2D but CLK_SSS is never requested
since drivers/crypto/s5p-sss.c isn't built for exynos_defconfig.

Enabling CONFIG_CRYPTO_DEV_S5P makes the system to resume without
any patches since the sss clock prevents aclk266_g2d to be gated.

But I wanted to know if it was really aclk266_g2d that was needed
or the actual sss clock since the kernel didn't manage that clock
without the driver enabled.

So I disabled the sss clock before trying a S2R:

# devmem 0x10018800 32 0xFFFFFFFB
(CLK_SSS in CLK_GATE_IP_G2D is gated)

and S2R worked anyways but I see that CLK_GATE_IP_G2D is reset to
its default value on S2R so maybe that is why it works anyways?

# devmem 0x10018800
0xFFFFFFFF (all CLK_GATE_IP_G2D clocks enabled including CLK_SSS)

Does this shed any more light? Could the problem be that the sss
clock parent (aclk266_g2d) is gated during S2R? Is the SSS module
required for S2R or is just that CLK_SSS prevents the parent to
be gated and so it is another red herring?

Best regards,
Javier
