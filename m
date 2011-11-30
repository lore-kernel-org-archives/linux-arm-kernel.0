From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 Nov 2011 13:00:43 +0100
Subject: [PATCH 1/7] pinctrl: enable pxa3xx pinmux
In-Reply-To: <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdY=zvObTkLkzVRWVoh3YVVkV5g78sTWGH0VygUdmmCTLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

I thought about this last night:

On Sat, Nov 26, 2011 at 12:08 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> +/* These 135 pins exists in PXA300, PXA310 & PXA320 */
> +#define PXA3XX_COMMON_PINS() ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
> + ? ? ? PINCTRL_PIN(0, "GPIO0"), ? ? ? ?PINCTRL_PIN(1, "GPIO1"), ? ? ? ?\
(...)
+#ifdef CONFIG_ARCH_PXA
+static struct pinctrl_pin_desc pxa300_pads[] = {
+       PXA3XX_COMMON_PINS(),
+       PINCTRL_PIN(128, "GPIO0_2"),    PINCTRL_PIN(129, "GPIO1_2"),

Defining a huge macro like PXA3XX_COMMON_PINS() and reusing
all over the place doesn't scale.

The real fix is that I fix so that you can call
pinmux_register_mappings() more than one time.

So it will look like this or similar:

pinmux_register_mappings(common_pins);
if (plat->is_pxa)
  pinmux_register_mappings(pxa_pins);
if (plat->is_mmp)
  pinmux_register_mappings(mmp_pins);

etc.

Since I'm anyway fixing up this function I'll see if
I can simply fit this in as patch 2/2 and send out
ASAP.

Yours,
Linus Walleij
