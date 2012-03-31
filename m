From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 01 Apr 2012 01:47:10 +0400
Subject: [PATCH V2 1/4] Input: pxa27x_keypad keep clock on as wakeup source
In-Reply-To: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
Message-ID: <4F777B5E.5080500@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-03-2012 5:58, Chao Xie wrote:

> When the keypad is used as wake up source, the clock can not
> be disabled. Or it can not detect key pressing.
> If the keypad is used as wake up source, when resume back,
> do not enable the clock and configure it again because the
> register content is retained.

> Signed-off-by: Chao Xie<chao.xie@marvell.com>
> ---
>   drivers/input/keyboard/pxa27x_keypad.c |   27 ++++++++++++++++++---------
>   1 files changed, 18 insertions(+), 9 deletions(-)

> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 29fe1b2..1c5752f 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
[...]
> @@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *dev)
>   	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
>   	struct input_dev *input_dev = keypad->input_dev;
>
> +	/*
> +	 * If the keypad is used as wake up source, the clock is not turned
> +	 * off. So do not need configure it again.
> +	 */
>   	if (device_may_wakeup(&pdev->dev))
>   		disable_irq_wake(keypad->irq);
> +	else {

    According to CodingStyle, {} should be an all branches of *if* statement, 
if it's used at least in one branch.

WBR, Sergei
