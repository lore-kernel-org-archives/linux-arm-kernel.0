From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 10:26:02 +0000
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <1291630492.3151.14.camel@realization>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20101123101210.GA18170@n2100.arm.linux.org.uk>
	<20101123102632.GM4693@pengutronix.de>
	<1290521329.3901.14.camel@realization>
	<20101123141713.GQ4693@pengutronix.de>
	<20101124080214.GU4693@pengutronix.de>
	<20101206083306.GI10693@pengutronix.de>
	<1291630492.3151.14.camel@realization>
Message-ID: <20101206102602.GE29563@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 11:14:52AM +0100, Alberto Panizzo wrote:
> Uwe, the following function works for me:
> +static void __init mx31_3ds_reserve(void)
> +{
> +       long ret;
> +       /* reserve MX3_CAMERA_BUF_SIZE for mx3-camera */
> +       mx3_camera_base = memblock_alloc(MX3_CAMERA_BUF_SIZE,
> +                       /* ??? */ MX3_CAMERA_BUF_SIZE);
> +       memblock_free(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> +       memblock_remove(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> +       if (!mx3_camera_base) {
> +               pr_err("%s: Wrong base allocation\n", __func__);
> +               return;
> +       }
> +       ret = memblock_reserve(mx3_camera_base, MX3_CAMERA_BUF_SIZE);
> +       if (ret) {
> +               pr_err("%s: Memory not reserved\n", __func__);
> +               return;
> +       }
> +}
> 
> The basic Idea is: why a region allocated, freed and removed can
> be declared safely as dma memory for the camera in a second time?
> Instead, I used the reserve API on the previous region so I am
> sure that region is not used by someone else before declaring it
> ad dma region for camera.
> 
> The ugly part of this code is that memblock_reserve want a base address
> that I have to decide before and I am supposing that the base address
> resulting from the allocate/free/remove operations, can be safely fed 
> to it.

It really is not on to have a region of memory marked as being reserved
and at the same time tell memblock that it's not part of the memory map.
When we pass this information to bootmem, we will reserve a region which
does not exist in the memory map.

Try passing memblock=debug to get a display of the memblock information
at boot time - and debugging a bit further from there.
