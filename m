From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 28 Aug 2013 18:21:35 +0200 (CEST)
Subject: [PATCH v2 4/7] V4L: s5k6a3: Add support for asynchronous subdev
 registration
In-Reply-To: <1377705360-12197-5-git-send-email-s.nawrocki@samsung.com>
References: <1377705360-12197-1-git-send-email-s.nawrocki@samsung.com>
 <1377705360-12197-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <Pine.LNX.4.64.1308281819520.22743@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

Just one doubt below

On Wed, 28 Aug 2013, Sylwester Nawrocki wrote:

> This patch converts the driver to use v4l2 asynchronous subdev
> registration API an the clock API to control the external master
> clock directly.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/media/i2c/s5k6a3.c |   36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/s5k6a3.c b/drivers/media/i2c/s5k6a3.c
> index ba86e24..f65a4f8 100644
> --- a/drivers/media/i2c/s5k6a3.c
> +++ b/drivers/media/i2c/s5k6a3.c

[snip]

> @@ -282,7 +297,7 @@ static int s5k6a3_probe(struct i2c_client *client,
>  	pm_runtime_no_callbacks(dev);
>  	pm_runtime_enable(dev);
>  
> -	return 0;
> +	return v4l2_async_register_subdev(sd);

If the above fails - don't you have to do any clean up? E.g. below you do 
disable runtime PM and clean up the media entity.

Thanks
Guennadi

>  }
>  
>  static int s5k6a3_remove(struct i2c_client *client)
> @@ -290,6 +305,7 @@ static int s5k6a3_remove(struct i2c_client *client)
>  	struct v4l2_subdev *sd = i2c_get_clientdata(client);
>  
>  	pm_runtime_disable(&client->dev);
> +	v4l2_async_unregister_subdev(sd);
>  	media_entity_cleanup(&sd->entity);
>  	return 0;
>  }
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
