From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 11 Oct 2016 12:01:15 -0400
Subject: [PATCH] clk: lpc32xx: add a quirk for PWM and MS clock dividers
In-Reply-To: <1475803015-4067-1-git-send-email-vz@mleia.com>
References: <1475803015-4067-1-git-send-email-vz@mleia.com>
Message-ID: <1476201675.7075.24.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Fri, 2016-10-07 at 04:16 +0300, Vladimir Zapolskiy wrote:
> In common clock framework CLK_DIVIDER_ONE_BASED or'ed with
> CLK_DIVIDER_ALLOW_ZERO flags indicates that
> 1) a divider clock may be set to zero value,
> 2) divider's zero value is interpreted as a non-divided clock.
> 
> On the LPC32xx platform clock dividers of PWM and memory card clocks
> comply with the first condition, but zero value means a gated clock,
> thus it may happen that the divider value is not updated when
> the clock is enabled and the clock remains gated.
> 
> The change adds one-shot quirks, which check for zero value of divider
> on initialization and set it to a non-zero value, therefore in runtime
> a gate clock will work as expected.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

This patch resolved the issue reported in the following post:
https://www.spinics.net/lists/arm-kernel/msg534048.html

Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com> 

> ---
>  drivers/clk/nxp/clk-lpc32xx.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
[...]
