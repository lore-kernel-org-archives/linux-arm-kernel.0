From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 15 Jul 2015 08:57:54 -0500
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <20150715072307.GM4119@tiger>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
 <20150715072307.GM4119@tiger>
Message-ID: <CAHrpEqT3GGoZTpM03Mo=YwxhxCQ=Z277d5X6EOY_dV=3c21L6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 2:23 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Jul 07, 2015 at 02:02:05PM -0500, Adrian Alonso wrote:
>> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
>> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>>   previous iMX SoC generation and iomuxc-lpsr which provides
>>   low power state rentetion capabilities on gpios that are part of
>>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
>> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>>   properly configure iomuxc/iomuxc-lpsr settings.
>>
>> Signed-off-by: Adrian Alonso <aalonso@freescale.com>
>
> It took me quite some time to understand what the patch does.  Before I
> gave specific comments on your implementation, I would discuss if there
> is a better solution, as I do not like the idea of encoding these
> artificial pin id of LPSR pads in the input_val.
>
> Ideally, the LPSR controller should be implemented as a second instance
> of IOMUXC.  But the problem seems to be the select input register is
> shared between these two instances.  Is my understanding correct?

There are two problem.
1. LPSR IOMUX share input select with IOMUX.
2. If use two instance,  the pin ID will be the same.  If there are a group
mix use LPSR IOMUX and normal IOMUX,  system will be confused.
For example:

UART_pin:
{
          LPSR_IOMUX_RX,
          NORMAL_IOMUX_TX,
}

IOMUX driver don't distinguish it.

best regards
Frank Li

>
> How select input register is shared?  With different bits in a single
> register which is only laid on normal IOMUXC controller?
>
> I need more details to understand the problem.
>
> Shawn
