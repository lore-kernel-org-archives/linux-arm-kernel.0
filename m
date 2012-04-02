From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Apr 2012 17:37:05 +0800
Subject: [PATCH V3 1/4] Input: pxa27x_keypad keep clock on as wakeup source
In-Reply-To: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
> When the keypad is used as wake up source, the clock can not
> be disabled. Or it can not detect key pressing.
> If the keypad is used as wake up source, when resume back,
> do not enable the clock and configure it again because the
> register content is retained.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?drivers/input/keyboard/pxa27x_keypad.c | ? 33 ++++++++++++++++++++-----------
> ?1 files changed, 21 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 29fe1b2..b07771e 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -399,7 +399,7 @@ static int pxa27x_keypad_open(struct input_dev *dev)
> ? ? ? ?struct pxa27x_keypad *keypad = input_get_drvdata(dev);
>
> ? ? ? ?/* Enable unit clock */
> - ? ? ? clk_enable(keypad->clk);
> + ? ? ? clk_prepare_enable(keypad->clk);
> ? ? ? ?pxa27x_keypad_config(keypad);
>
> ? ? ? ?return 0;
> @@ -410,7 +410,7 @@ static void pxa27x_keypad_close(struct input_dev *dev)
> ? ? ? ?struct pxa27x_keypad *keypad = input_get_drvdata(dev);
>
> ? ? ? ?/* Disable clock unit */
> - ? ? ? clk_disable(keypad->clk);
> + ? ? ? clk_disable_unprepare(keypad->clk);
> ?}
>
> ?#ifdef CONFIG_PM
> @@ -419,10 +419,14 @@ static int pxa27x_keypad_suspend(struct device *dev)
> ? ? ? ?struct platform_device *pdev = to_platform_device(dev);
> ? ? ? ?struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
>
> - ? ? ? clk_disable(keypad->clk);
> -
> + ? ? ? /*
> + ? ? ? ?* If the keypad is used a wake up source, clock can not be disabled.
> + ? ? ? ?* Or it can not detect the key pressing.
> + ? ? ? ?*/
> ? ? ? ?if (device_may_wakeup(&pdev->dev))
> ? ? ? ? ? ? ? ?enable_irq_wake(keypad->irq);
> + ? ? ? else
> + ? ? ? ? ? ? ? clk_disable_unprepare(keypad->clk);
>
> ? ? ? ?return 0;
> ?}
> @@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *dev)
> ? ? ? ?struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> ? ? ? ?struct input_dev *input_dev = keypad->input_dev;
>
> - ? ? ? if (device_may_wakeup(&pdev->dev))
> + ? ? ? /*
> + ? ? ? ?* If the keypad is used as wake up source, the clock is not turned
> + ? ? ? ?* off. So do not need configure it again.
> + ? ? ? ?*/
> + ? ? ? if (device_may_wakeup(&pdev->dev)) {
> ? ? ? ? ? ? ? ?disable_irq_wake(keypad->irq);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? mutex_lock(&input_dev->mutex);
>
> - ? ? ? mutex_lock(&input_dev->mutex);
> + ? ? ? ? ? ? ? if (input_dev->users) {
> + ? ? ? ? ? ? ? ? ? ? ? /* Enable unit clock */
> + ? ? ? ? ? ? ? ? ? ? ? clk_prepare_enable(keypad->clk);
> + ? ? ? ? ? ? ? ? ? ? ? pxa27x_keypad_config(keypad);
> + ? ? ? ? ? ? ? }
>
> - ? ? ? if (input_dev->users) {
> - ? ? ? ? ? ? ? /* Enable unit clock */
> - ? ? ? ? ? ? ? clk_enable(keypad->clk);
> - ? ? ? ? ? ? ? pxa27x_keypad_config(keypad);
> + ? ? ? ? ? ? ? mutex_unlock(&input_dev->mutex);
> ? ? ? ?}
>
> - ? ? ? mutex_unlock(&input_dev->mutex);
> -
> ? ? ? ?return 0;
> ?}
>
> --
> 1.7.0.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi Dmitry,

I just found that you're not looped in this mail thread. Could I merge
them into arch-pxa tree?

Best Regards
Haojian
