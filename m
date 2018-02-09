From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Feb 2018 21:23:02 -0200
Subject: [PATCH RFC] ARM: imx: avic: set low-power interrupt mask for imx25
In-Reply-To: <1518180203-9698-1-git-send-email-martin@kaiser.cx>
References: <1518180203-9698-1-git-send-email-martin@kaiser.cx>
Message-ID: <CAOMZO5DQ-nUULrX4255RNiWpkPMQj66Sp08MYA1ZmQmFt7XhXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Fri, Feb 9, 2018 at 10:43 AM, Martin Kaiser <martin@kaiser.cx> wrote:
> imx25 contains two registers (LPIMR0 and 1) to define which interrupts
> are enabled in low-power mode. As of today, those two registers are
> configured to enable all interrupts. Before going to low-power mode, the
> AVIC's INTENABLEH and INTENABLEL registers are configured to enable only
> those interrupts which are used as wakeup sources.
>
> It turned out that this approach is not sufficient if we want the imx25
> to go into stop mode during suspend-to-ram. (Stop mode is the low-power
> mode that consumes the least power. The peripheral master clock is
> switched off in this mode). For stop mode to work, the LPIMR0 and 1
> registers have to be configured with the set of interrupts that are
> allowed in low-power mode. Fortunately, the bits in the LPIMR registers
> are assigned to the same interrups as the bits in INTENABLEH and
> INTENABLEL. However, LPIMR uses 1 to mask an interrupt whereas the
> INTENABLE registers use 1 to enable an interrupt.
>
> This patch sets the LPIMR registers to the inverted bitmask of the
> INTENABLE registers during suspend and goes back to "all interrupts
> masked" when we wake up again. We also make this the default at startup.
>
> As far as I know, the other supported imx architectures have no similar
> mechanism. Since the LPIMR registers are part of the CCM module, we
> query the device tree for an imx25 ccm node in order to detect if we're
> running on imx25.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>
> Dear all,
>
> could you have a look at this first draft? The approach to detect imx25
> looks a bit hackish, I'd appreciate your suggestions how to do this
> properly.

The way you did to detect mx25 looks good.

Thanks
