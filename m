From: ospite@studenti.unina.it (Antonio Ospite)
Date: Thu, 12 Nov 2009 15:41:06 +0100
Subject: [PATCH 1/3 v3] Add camera support for A780 and A910 EZX phones
In-Reply-To: <Pine.LNX.4.64.0911111857430.4072@axis700.grange>
References: <Pine.LNX.4.64.0911101037280.5074@axis700.grange>
	<1257937317-16655-1-git-send-email-ospite@studenti.unina.it>
	<Pine.LNX.4.64.0911111857430.4072@axis700.grange>
Message-ID: <20091112154106.a00bbb95.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2009 19:02:11 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> Hi Antonio
> 
> Still one more nitpick:
>

Comments below.

> On Wed, 11 Nov 2009, Antonio Ospite wrote:
> 
[...]
> >  
> > +/* camera */
> > +static int a780_camera_init(void)
> 
> This function returns an error but...
> 
> > +{
> > +	int err;
> > +
> > +	/*
> > +	 * GPIO50_nCAM_EN is active low
> > +	 * GPIO19_GEN1_CAM_RST is active on rising edge
> > +	 */
> > +	err = gpio_request(GPIO50_nCAM_EN, "nCAM_EN");
> > +	if (err) {
> > +		pr_err("%s: Failed to request nCAM_EN\n", __func__);
> > +		goto fail;
> > +	}
[...]
> > +	return err;
> > +}
> > +
[...]
> >  static void __init a780_init(void)
> > @@ -699,6 +782,9 @@ static void __init a780_init(void)
> >  
> >  	pxa_set_keypad_info(&a780_keypad_platform_data);
> >  
> > +	a780_camera_init();
> 
> ...it is not used. So, I would either make it void, or check the return 
> code, and maybe even not register the camera since it's going to be 
> useless anyway? Same for a910.
>

Actually I was keeping returning an error just in case there would be a
soc-camera .init() someday. But it's indeed a good idea to check the
return value once that we have it.

I am inlining here only the incremental change for a faster review,
I am going to send v4 of the patch separately for you ACK, hopefully :).

Note, now the return value of platform_device_register is ignored but
this is not grave, I guess.

Thanks for your time,
   Antonio

diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 74423a6..1a73b7b 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -767,7 +767,6 @@ static struct platform_device a780_camera = {
 
 static struct platform_device *a780_devices[] __initdata = {
 	&a780_gpio_keys,
-	&a780_camera,
 };
 
 static void __init a780_init(void)
@@ -782,8 +781,10 @@ static void __init a780_init(void)
 
 	pxa_set_keypad_info(&a780_keypad_platform_data);
 
-	a780_camera_init();
-	pxa_set_camera_info(&a780_pxacamera_platform_data);
+	if (a780_camera_init() == 0) {
+		pxa_set_camera_info(&a780_pxacamera_platform_data);
+		platform_device_register(&a780_camera);
+	}
 
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a780_devices));
@@ -1026,7 +1027,6 @@ static struct platform_device a910_camera = {
 
 static struct platform_device *a910_devices[] __initdata = {
 	&a910_gpio_keys,
-	&a910_camera,
 };
 
 static void __init a910_init(void)
@@ -1041,8 +1041,10 @@ static void __init a910_init(void)
 
 	pxa_set_keypad_info(&a910_keypad_platform_data);
 
-	a910_camera_init();
-	pxa_set_camera_info(&a910_pxacamera_platform_data);
+	if (a910_camera_init() == 0) {
+		pxa_set_camera_info(&a910_pxacamera_platform_data);
+		platform_device_register(&a910_camera);
+	}
 
 	platform_add_devices(ARRAY_AND_SIZE(ezx_devices));
 	platform_add_devices(ARRAY_AND_SIZE(a910_devices));


-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091112/ff2fa21b/attachment.sig>
