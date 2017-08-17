From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 16 Aug 2017 18:10:42 -0700
Subject: [PATCH 2/3] w1: d1w: Provide callback for ds1wm read/write
In-Reply-To: <1502905525-5646-3-git-send-email-scott.branden@broadcom.com>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
 <1502905525-5646-3-git-send-email-scott.branden@broadcom.com>
Message-ID: <992bd68a-d63a-fead-e7ea-b613263bb3c6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/16/2017 10:45 AM, Scott Branden wrote:
> From: Shreesha Rajashekar <shreesha@broadcom.com>
> 
> DS1WM core registers are accessed by reading from and writing to a group of
> registers in iproc SOC's.
> 
> By default the read and write function uses
> __raw_readb() and __raw_writeb(), which wouldnt work for iproc.
> hence modifying to provide callbacks for read and write functions.

It's only obvious once you look at patch 3, and that's because you use
MFD, might be worth adding to this commit message here.

> 
> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/w1/masters/ds1wm.c | 18 ++++++++++++++++--
>  include/linux/mfd/ds1wm.h  |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
> index fd2e9da..9fadc39 100644
> --- a/drivers/w1/masters/ds1wm.c
> +++ b/drivers/w1/masters/ds1wm.c
> @@ -115,12 +115,26 @@ struct ds1wm_data {
>  static inline void ds1wm_write_register(struct ds1wm_data *ds1wm_data, u32 reg,
>  					u8 val)
>  {
> -	__raw_writeb(val, ds1wm_data->map + (reg << ds1wm_data->bus_shift));
> +	struct device *dev = &ds1wm_data->pdev->dev;
> +	struct ds1wm_driver_data *pdata = dev_get_platdata(dev);
> +
> +	if (pdata->write)
> +		pdata->write(ds1wm_data->map, reg, val);

Should not this be pdata && pdata->write otherwise are not you just
causing a NULL pointer dereference for any driver other than the
Broadcom iProc d1w?

Also, you may not have any bus shift, but it sounds like this should
either be clarified in a header file that the platform data I/O accessor
is responsible for shifting, or that the shift should be applied here
(and because you set it to 0, nothing happens).
-- 
Florian
