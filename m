From: eric@anholt.net (Eric Anholt)
Date: Wed, 30 May 2018 12:51:12 -0700
Subject: [PATCH 04/13] staging: vc04_services: no need to check debugfs
 return values
In-Reply-To: <20180529142947.3250-4-gregkh@linuxfoundation.org>
References: <20180529142947.3250-1-gregkh@linuxfoundation.org>
 <20180529142947.3250-4-gregkh@linuxfoundation.org>
Message-ID: <874lioorbj.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Clean up the vchiq_arm code by not caring about the value of debugfs
> calls.  This ends up removing a number of lines of code that are not
> needed.
>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Keerthi Reddy <keerthigd4990@gmail.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../interface/vchiq_arm/vchiq_arm.c           | 13 +---
>  .../interface/vchiq_arm/vchiq_debugfs.c       | 72 +++----------------
>  .../interface/vchiq_arm/vchiq_debugfs.h       |  4 +-
>  3 files changed, 15 insertions(+), 74 deletions(-)
>

> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> index 766b4fe5f32c..103fec955e2c 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c

> @@ -314,31 +284,13 @@ void vchiq_debugfs_remove_instance(VCHIQ_INSTANCE_T instance)
>  	debugfs_remove_recursive(node->dentry);
>  }
>  
> -int vchiq_debugfs_init(void)
> +void vchiq_debugfs_init(void)
>  {
> -	BUG_ON(debugfs_info.vchiq_cfg_dir != NULL);
> -
>  	debugfs_info.vchiq_cfg_dir = debugfs_create_dir("vchiq", NULL);
> -	if (debugfs_info.vchiq_cfg_dir == NULL)
> -		goto fail;
> -

I think now that we allow successful probe with this value NULL, module
remove could vchiq_debugfs_deinit() -> vchiq_debugfs_top() -> BUG_ON().
I think the right solution would be to just drop that BUG_ON().  With
that change (and probably just garbage-collecting that function), this
will be enthusiastically:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/2fb101af/attachment-0001.sig>
