From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 26 Feb 2014 01:37:57 +0100
Subject: [PATCH v3 1/3] Fix hibernation restore hang in freeze_processes
In-Reply-To: <1393372920-3896-2-git-send-email-sebastian.capella@linaro.org>
References: <1393372920-3896-1-git-send-email-sebastian.capella@linaro.org>
 <1393372920-3896-2-git-send-email-sebastian.capella@linaro.org>
Message-ID: <3879011.h2KX4caCrF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 25, 2014 04:01:58 PM Sebastian Capella wrote:
> During restore, pm_notifier chain are called with
> PM_RESTORE_PREPARE.  The firmware_class driver handler
> fw_pm_notify does not have a handler for this.  As a result,
> it keeps a reader on the kmod.c umhelper_sem.  During
> freeze_processes, the call to __usermodehelper_disable tries to
> take a write lock on this semaphore and hangs waiting.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Acked-by: Ming Lei <ming.lei@canonical.com>
> Cc: Russ Dill <Russ.Dill@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Since this is a -stable candidate patch, I've queued it up as a fix for 3.14.

The other two patches are ARM mostly, so I'd prefer them to be merged through
the ARM arch tree.  The changes in suspend.h made by [3/3] are fine by me.

Thanks!

> ---
>  drivers/base/firmware_class.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
> index eb8fb94..e2b51f8 100644
> --- a/drivers/base/firmware_class.c
> +++ b/drivers/base/firmware_class.c
> @@ -1541,6 +1541,7 @@ static int fw_pm_notify(struct notifier_block *notify_block,
>  	switch (mode) {
>  	case PM_HIBERNATION_PREPARE:
>  	case PM_SUSPEND_PREPARE:
> +	case PM_RESTORE_PREPARE:
>  		kill_requests_without_uevent();
>  		device_cache_fw_images();
>  		break;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
