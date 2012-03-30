From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Mar 2012 09:53:38 +0800
Subject: [PATCH V2 1/4] Input: pxa27x_keypad keep clock on as wakeup source
In-Reply-To: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
Message-ID: <CAN1soZydBRqAChxKPKfz5pN8JSKKKbWBYua5KLfnQR8ZnQL-EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 9:58 AM, Chao Xie <chao.xie@marvell.com> wrote:
> When the keypad is used as wake up source, the clock can not
> be disabled. Or it can not detect key pressing.
> If the keypad is used as wake up source, when resume back,
> do not enable the clock and configure it again because the
> register content is retained.
>
> Signed-off-by: Chao Xie <chao.xie@marvell.com>
> ---
> ?drivers/input/keyboard/pxa27x_keypad.c | ? 27 ++++++++++++++++++---------
> ?1 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 29fe1b2..1c5752f 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
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
> + ? ? ? ? ? ? ? clk_disable(keypad->clk);
I prefer to add one patch to use clk_prepare_enable() &
clk_disable_unprepare() in keypad driver.

>
> ? ? ? ?return 0;
> ?}
> @@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *dev)
> ? ? ? ?struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
> ? ? ? ?struct input_dev *input_dev = keypad->input_dev;
>
> + ? ? ? /*
> + ? ? ? ?* If the keypad is used as wake up source, the clock is not turned
> + ? ? ? ?* off. So do not need configure it again.
> + ? ? ? ?*/
> ? ? ? ?if (device_may_wakeup(&pdev->dev))
> ? ? ? ? ? ? ? ?disable_irq_wake(keypad->irq);
> + ? ? ? else {
> + ? ? ? ? ? ? ? mutex_lock(&input_dev->mutex);
>
> - ? ? ? mutex_lock(&input_dev->mutex);
> + ? ? ? ? ? ? ? if (input_dev->users) {
> + ? ? ? ? ? ? ? ? ? ? ? /* Enable unit clock */
> + ? ? ? ? ? ? ? ? ? ? ? clk_enable(keypad->clk);
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
