From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 26 Oct 2018 11:07:25 +0300
Subject: [PATCH RFC 04/11] staging: vchiq_arm: Fix platform device
 unregistration
In-Reply-To: <1540481375-15952-5-git-send-email-stefan.wahren@i2se.com>
References: <1540481375-15952-1-git-send-email-stefan.wahren@i2se.com>
 <1540481375-15952-5-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20181026080725.vzm7cxj6bcpdisym@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 05:29:28PM +0200, Stefan Wahren wrote:
> In error case platform_device_register_data would return an ERR_PTR
> instead of NULL. So we better check this before unregistration.
> 
> Fixes: 37b7b3087a2f ("staging/vc04_services: Register a platform device for the camera driver.")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index ea78937..d7d7c2f0 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -3672,7 +3672,8 @@ static int vchiq_probe(struct platform_device *pdev)
>  
>  static int vchiq_remove(struct platform_device *pdev)
>  {
> -	platform_device_unregister(bcm2835_camera);
> +	if (!IS_ERR(bcm2835_camera))
> +		platform_device_unregister(bcm2835_camera);

This wouldn't be needed if we checked for platform_device_register_data()
errors in probe.  That would be a better fix.

This is obviously a bug, but is it a real life bug, btw?  I would be
surprised if platform_device_register_data() actually failed.

regards,
dan carpenter
