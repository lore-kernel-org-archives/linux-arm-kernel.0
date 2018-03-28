From: peda@axentia.se (Peter Rosin)
Date: Wed, 28 Mar 2018 12:03:39 +0200
Subject: [PATCH] drm/atmel-hlcdc: add command line option to specify
 preferred depth
In-Reply-To: <20180328093454.4149fa3b@bbrezillon>
References: <20180326073502.19259-1-peda@axentia.se>
 <20180328093454.4149fa3b@bbrezillon>
Message-ID: <ce723d9f-6858-0bad-bffb-85ab036510ee@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-28 09:34, Boris Brezillon wrote:
> Hi Peter,
> 
> On Mon, 26 Mar 2018 09:35:02 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> I have an sama5d31-based system with 64MB of memory and a 1920x1080
>> LVDS display wired for 16-bpp. When I enable legacy fbdev support,
>> the contiguous memory allocator invariably fails with the order-11
>> allocation for a 1920x1080 at 24-bpp buffer (~6MB). But this HW can never
>> make any good use of RGB888, so that is a wasted attempt anyway that
>> would also waste precious memory should it succeed.
>>
>> Sure, I could rewrite user-space to go directly to KMS etc, and that
>> makes the (attempted) order-11 allocation go away, replacing it with
>> one order-10 allocation per application restart for a 1920x1080 at 16-bpp
>> buffer (<4MB). But after a few restarts, order-10 allocations start to
>> fail as well, which is only to be expected AFAIU.
>>
>> So, I'd rather not change user-space (which was originally written
>> to target a smaller display) so that I at the same time get the
>> benefit of an early pre-allocated fbdev frame-buffer that can be
>> reused over and over. But to do that I need to tell the driver that
>> 16-bpp is the preferred depth. Add a module parameter to do just that.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> I found some inspiration regarding naming and implementation here:
>> https://patchwork.kernel.org/patch/9848631/
>>
>> I have found no feedback on that patch though, which makes me wonder if
>> I'm perhaps barking up the wronig tree?
> 
> Hm, isn't that something you can already overload with the video=
> parameter?
> 
> 	video=<output>:<resolution>[-<bpp>]

Heh, you are right...

> AFAIR, <bpp> encodes the color depth, so what is the benefit of adding
> this new property to overload the default depth?

...but hhhmmm, I think I will have to have to encode the display size
in the bootargs so I will have to use distinct barebox environments
depending on the panel, but that's no biggie.

Splendid, please throw away the patch!

Cheers,
Peter

> Maybe I'm wrong and the default depth param is actually useful, but in
> this case we should probably make it generic since other drivers seems
> to need it too, and we might want to attach it to a specific display
> engine instance.
> 
> Thanks,
> 
> Boris
> 
>>
>> Cheers,
>> Peter
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index c1ea5c36b006..f0148627c221 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -29,6 +29,11 @@
>>  
>>  #define ATMEL_HLCDC_LAYER_IRQS_OFFSET		8
>>  
>> +static int atmel_hlcdc_preferred_depth __read_mostly;
>> +
>> +MODULE_PARM_DESC(preferreddepth, "Set preferred bpp");
>> +module_param_named(preferreddepth, atmel_hlcdc_preferred_depth, int, 0400);
>> +
>>  static const struct atmel_hlcdc_layer_desc atmel_hlcdc_at91sam9n12_layers[] = {
>>  	{
>>  		.name = "base",
>> @@ -590,6 +595,7 @@ static int atmel_hlcdc_dc_modeset_init(struct drm_device *dev)
>>  	dev->mode_config.min_height = dc->desc->min_height;
>>  	dev->mode_config.max_width = dc->desc->max_width;
>>  	dev->mode_config.max_height = dc->desc->max_height;
>> +	dev->mode_config.preferred_depth = 24;
>>  	dev->mode_config.funcs = &mode_config_funcs;
>>  
>>  	return 0;
>> @@ -658,7 +664,7 @@ static int atmel_hlcdc_dc_load(struct drm_device *dev)
>>  
>>  	platform_set_drvdata(pdev, dev);
>>  
>> -	drm_fb_cma_fbdev_init(dev, 24, 0);
>> +	drm_fb_cma_fbdev_init(dev, atmel_hlcdc_preferred_depth, 0);
>>  
>>  	drm_kms_helper_poll_init(dev);
>>  
>> @@ -756,6 +762,16 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
>>  	struct drm_device *ddev;
>>  	int ret;
>>  
>> +	switch (atmel_hlcdc_preferred_depth) {
>> +	case 0: /* driver default */
>> +	case 8:
>> +	case 16:
>> +	case 24:
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>>  	ddev = drm_dev_alloc(&atmel_hlcdc_dc_driver, &pdev->dev);
>>  	if (IS_ERR(ddev))
>>  		return PTR_ERR(ddev);
> 
> 
> 
