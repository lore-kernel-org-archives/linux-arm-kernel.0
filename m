From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 06 Jul 2011 16:05:22 +0400
Subject: [PATCH V2 3/6] mpcore_wdt: Fix WDIOC_SETOPTIONS handling
In-Reply-To: <1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
References: <1286185540-19569-1-git-send-email-vkuzmichev@mvista.com>
	<1309892440-3260-4-git-send-email-vkuzmichev@mvista.com>
Message-ID: <4E144F82.8060300@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05-07-2011 23:00, Vitaly Kuzmichev wrote:

> According to the include/linux/watchdog.h WDIOC_SETOPTIONS is
> classified as 'read from device' ioctl call:
>    #define WDIOC_SETOPTIONS        _IOR(WATCHDOG_IOCTL_BASE, 4, int)

> However, the driver 'mpcore_wdt' performs 'copy_from_user' only if
> _IOC_WRITE is set, thus the local variable 'uarg' which is used in
> WDIOC_SETOPTIONS handling remains uninitialized.

> The proper way to fix this is to bind WDIOC_SETOPTIONS to _IOW,
> but this will break compatibility.
> So adding additional condition for performing 'copy_from_user'.

> Signed-off-by: Vitaly Kuzmichev<vkuzmichev@mvista.com>
> ---
>   drivers/watchdog/mpcore_wdt.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)

> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index 7a3d6b2..b330a0a 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
> @@ -240,7 +240,8 @@ static long mpcore_wdt_ioctl(struct file *file, unsigned int cmd,
>   	if (_IOC_DIR(cmd)&&  _IOC_SIZE(cmd)>  sizeof(uarg))
>   		return -ENOTTY;
>
> -	if (_IOC_DIR(cmd) & _IOC_WRITE) {
> +	if (_IOC_DIR(cmd) & _IOC_WRITE

    I think you need parens around this.

> +			|| cmd == WDIOC_SETOPTIONS) {
>   		ret = copy_from_user(&uarg, (void __user *)arg, _IOC_SIZE(cmd));
>   		if (ret)
>   			return -EFAULT;

WBR, Sergei
