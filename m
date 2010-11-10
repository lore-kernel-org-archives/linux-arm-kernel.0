From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 10 Nov 2010 12:14:10 +0530
Subject: [PATCH V2 21/69] Keyboard: Adding support for spear-keyboard
In-Reply-To: <20101006061652.GA14609@core.coreip.homeip.net>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<584e4ecc7883807e1fae0e6c53b2837954935e53.1285933331.git.viresh.kumar@st.com>
	<20101005154737.GA19730@core.coreip.homeip.net>
	<4CABF3E0.8010909@st.com>
	<20101006061652.GA14609@core.coreip.homeip.net>
Message-ID: <4CDA3F3A.6040203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry,

On 10/06/2010 11:46 AM, Dmitry Torokhov wrote:
> -       /* program keyboard */
> -       val |= SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK;
> -       writew(val, kbd->io_base + MODE_REG);
> +       input_dev->keycode = kbd->keycodes;
> +       input_dev->keycodesize = sizeof(kbd->keycodes[0]);
> +       input_dev->keycodemax = ARRAY_SIZE(kbd->keycodes);
> 
> -       writeb(1, kbd->io_base + STATUS_REG);
> +       matrix_keypad_build_keymap(keymap, ROW_SHIFT,
> +                       input_dev->keycode, input_dev->keybit);
> 
> -       device_init_wakeup(&pdev->dev, 1);
> +       input_set_drvdata(input_dev, kbd);
> +
> +       /* ensure device is shut off */
> +       spear_kbd_close(input_dev);

Since, clock to keyboard is not enabled at this time (during probe),
this function call is not required. This tries to disable clock which
is never enabled.

I have removed this function call and tested your patch and was
working fine.

--
viresh
