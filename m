From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 1 Jun 2015 17:21:11 +0200
Subject: Please revert 3eea8b5d68c801fec788b411582b803463834752 as it
 breaks touchscreen on n900.
In-Reply-To: <20150601145825.GA20557@lukather>
References: <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd> <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost> <20150529203456.GC22083@amd>
 <20150601095556.GH17267@lukather> <20150601140605.GA26908@amd>
 <20150601145825.GA20557@lukather>
Message-ID: <20150601152111.GA14015@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> > > > The 3eea8b5d68c801fec788b411582b803463834752 is just bad.
> > > 
> > > You were very welcome to review this patch at the time and/or suggest
> > > a fix that pleases everyone.
> > 
> > You should be the one that should suggest fixes, as you broke it in
> > the first place. But clearly you don't understand that.
> 
> You actually never asked for a fix, and went head first calling this
> patch "bad" and asking for nothing but reverting it.

Date: Fri, 29 May 2015 21:08:16 +0200
Subject: 4.1 touchscreen regression on n900 -- pinpointed [was Re:
linux-n900
...
Maxime, can you suggest a fix?
...


> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> index b82b5207c78b..7e98c2e443ab 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -14,10 +14,10 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  
> -static u32 of_get_optional_u32(struct device_node *np,
> +static int of_get_optional_u32(struct device_node *np,
>  			       const char *property)
>  {
> -	u32 val = 0;
> +	int val = -1;
>  
>  	of_property_read_u32(np, property, &val);
>  
> @@ -42,8 +42,12 @@ static void touchscreen_set_params(struct input_dev *dev,
>  	}
>  
>  	absinfo = &dev->absinfo[axis];
> -	absinfo->maximum = max;
> -	absinfo->fuzz = fuzz;
> +
> +	if (max >= 0)
> +		absinfo->maximum = max;
> +
> +	if (fuzz >= 0)
> +		absinfo->fuzz = fuzz;
>  }
>  
>  /**
> @@ -57,7 +61,7 @@ static void touchscreen_set_params(struct input_dev *dev,
>  void touchscreen_parse_of_params(struct input_dev *dev)
>  {
>  	struct device_node *np = dev->dev.parent->of_node;
> -	u32 maximum, fuzz;
> +	int maximum, fuzz;
>  
>  	input_alloc_absinfo(dev);
>  	if (!dev->absinfo)
> -- >8 --
> 
> That reduces the max size of the screens, but I don't really expect the screen
> size to reach that order of magnitude before a few years...

Umm. Won't you have to update

-     if (maximum || fuzz)
+     if (maximum >= 0 || fuzz >= 0)

? Thanks,

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
