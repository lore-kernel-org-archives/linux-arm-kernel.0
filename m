From: ray.jui@broadcom.com (Ray Jui)
Date: Fri, 19 Feb 2016 17:23:33 -0800
Subject: [02/11] video: ARM CLCD: support DT signal inversion flags
In-Reply-To: <CACRpkdbGCidu_3qbTYf7WSoAhafU4Z5W0jDs4CGtH5XwSf14aA@mail.gmail.com>
References: <1454594660-7532-3-git-send-email-linus.walleij@linaro.org>
 <0cebf93a-ee0a-3637-3242-8aed266df091@broadcom.com>
 <CACRpkdbGCidu_3qbTYf7WSoAhafU4Z5W0jDs4CGtH5XwSf14aA@mail.gmail.com>
Message-ID: <ac0739e5-4339-7fc5-1179-73af722beb08@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 2/19/2016 12:46 AM, Linus Walleij wrote:
> On Wed, Feb 17, 2016 at 7:10 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>
>> A somewhat related question, how do you see the CLKSEL bit in the TIM2
>> register will be supported in the future? There are some cases where the
>> CLKSEL bit needs to be set, and therefore the "CLCDCLK" instead of "HCLK"
>> reference clock source is selected.
>
> I think it's very simple:
>
> The DT node usually looks like so:
>
> display at 10120000 {
>         compatible = "arm,pl110", "arm,primecell";
> (...)
>         clocks = <&oscclk4>, <&pclk>;
>         clock-names = "clcd", "apb_pclk";
>
> Just add a custom attribute pointing to the
> reference clock in this array:
>
> clcd-reference-clock = <0>;
>
> If this is set to <1> "apb_pclk" (i.e. HCLK) is
> the reference, and that bit in TIM2 gets set.

This looks good!

>
> Do you have a system that needs this?
>

Yah, we have a system (Cygnus) that can either use the HCLK, or an 
external clock generated from a PLL. To get certain pixel clock 
frequencies (depending on the LCD panel we use), we need to use the 
external clock source with the PLL configured to a particular VCO frequency.

We have not enabled full LCD/video support on that platform in the 
mainline kernel, but we'll eventually get to it.

> Yours,
> Linus Walleij
>

Thanks,

Ray
