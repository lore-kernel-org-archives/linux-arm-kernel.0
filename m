From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Aug 2015 18:16:49 +0300
Subject: [PATCH v4 1/6] media: get rid of unused "extra_links" param on
 media_entity_init()
In-Reply-To: <b0b576e0bfcc043b4fdab3a57665b525fc054add.1439563682.git.mchehab@osg.samsung.com>
References: <cover.1439563682.git.mchehab@osg.samsung.com>
 <b0b576e0bfcc043b4fdab3a57665b525fc054add.1439563682.git.mchehab@osg.samsung.com>
Message-ID: <3975256.nCAQDV8Exf@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Thank you for the patch.

On Friday 14 August 2015 11:56:38 Mauro Carvalho Chehab wrote:
> Currently, media_entity_init() creates an array with the links,
> allocated at init time. It provides a parameter (extra_links)
> that would allocate more links than the current needs, but this
> is not used by any driver.
> 
> As we want to be able to do dynamic link allocation/removal,
> we'll need to change the implementation of the links. So,
> before doing that, let's first remove that extra unused
> parameter, in order to cleanup the interface first.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> diff --git a/Documentation/media-framework.txt
> b/Documentation/media-framework.txt index f552a75c0e70..2cc6019f7147 100644
> --- a/Documentation/media-framework.txt
> +++ b/Documentation/media-framework.txt
> @@ -104,7 +104,7 @@ although drivers can allocate entities directly.
>  Drivers initialize entities by calling
> 
>  	media_entity_init(struct media_entity *entity, u16 num_pads,
> -			  struct media_pad *pads, u16 extra_links);
> +			  struct media_pad *pads);
> 
>  The media_entity name, type, flags, revision and group_id fields can be
>  initialized before or after calling media_entity_init. Entities embedded in

The extra_links parameter is documented later on in this file. Could you 
replace the paragraph

"Unlike the number of pads, the total number of links isn't always known in
advance by the entity driver. As an initial estimate, media_entity_init
pre-allocates a number of links equal to the number of pads plus an optional
number of extra links. The links array will be reallocated if it grows beyond
the initial estimate."

with

"Unlike the number of pads, the total number of links isn't always known in
advance by the entity driver. As an initial estimate, media_entity_init
pre-allocates a number of links equal to the number of pads. The links array 
will be reallocated if it grows beyond the initial estimate."

?

[snip]

> diff --git a/drivers/media/media-entity.c b/drivers/media/media-entity.c
> index 4d8e01c7b1b2..78440c7aad94 100644
> --- a/drivers/media/media-entity.c
> +++ b/drivers/media/media-entity.c
> @@ -30,7 +30,6 @@
>   * media_entity_init - Initialize a media entity
>   *
>   * @num_pads: Total number of sink and source pads.
> - * @extra_links: Initial estimate of the number of extra links.
>   * @pads: Array of 'num_pads' pads.
>   *
>   * The total number of pads is an intrinsic property of entities known by
> the

Similarly here, I would rewrite the documentation as

 * The total number of pads is an intrinsic property of entities known by the
 * entity driver, while the total number of links depends on hardware design
 * and is an extrinsic property unknown to the entity driver. However, in most
 * use cases the number of links can safely be assumed to be equal to or
 * larger than the number of pads.
 *
 * For those reasons the links array can be preallocated based on the number
 * of pads and will be reallocated later if extra links need to be created.
 *
 * This function allocates a links array with enough space to hold at least
 * 'num_pads' elements. The media_entity::max_links field will be set to the
 * number of allocated elements.

With that fixed,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And feel free to merge this patch for v4.3 independently of the rest.

> @@ -52,10 +51,10 @@
>   */
>  int
>  media_entity_init(struct media_entity *entity, u16 num_pads,
> -		  struct media_pad *pads, u16 extra_links)
> +		  struct media_pad *pads)
>  {
>  	struct media_link *links;
> -	unsigned int max_links = num_pads + extra_links;
> +	unsigned int max_links = num_pads;
>  	unsigned int i;
> 
>  	links = kzalloc(max_links * sizeof(links[0]), GFP_KERNEL);

-- 
Regards,

Laurent Pinchart
