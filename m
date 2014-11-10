From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 10 Nov 2014 13:58:06 +0100
Subject: dtb size limit? was Re: Tiny dts change breaks boot on n900
In-Reply-To: <20141110123118.GA31134@amd>
References: <20141110123118.GA31134@amd>
Message-ID: <20141110125806.GA16650@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2014-11-10 13:31:18, Pavel Machek wrote:
> Hi!
> 
> I'm confused:
> 
> This fixes boot on n900. Strange thing is ... adp1653 driver is not
> even compiled in -- it is module.
> 
> It looks like tiny change in dts noone should care about breaks
> boot... I don't even have adp1653 device parsing code written.
> 
> Something similar happened before -- change in device tree order broke
> boot.
> 
> Any ideas? What is going on?

If I replace the blog below with

 a = <1>;
 b = <2>;
 c = <3>;
 d = <4>;

Resulting kernel boots. Replacing it with

 a-really-long-attribute-name-hopefully-this-breaks-stuff = <1>;
 b = <2>;
 c = <3>;
 d = <4>;

Breaks the boot. I'm using dtb append option. Any ideas? Nonbooting
dtb is 68910 bytes.

pavel at amd:/data/l/linux-n900$ ls -al arch/arm/boot/dts/omap3-n900.dtb 
-rw-r--r-- 1 pavel pavel 68910 Nov 10 13:52 arch/arm/boot/dts/omap3-n900.dtb

I removed some "smsc,lan91c94" settings, and it boots again. Weird.

> 								Pavel
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index f3118bf..557a19e 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -565,11 +565,6 @@
>  	adp1653: adp1653 at 30 {
>  		compatible = "ad,adp1653";
>  		reg = <0x30>;
> -
> -		max-flash-timeout-usec = <500000>;
> -		max-flash-intensity-mA = <0>;
> -		max-torch-intensity-mA = <0>;
> -		max-indicator-intensity-uA = <0>;
>  	};
>  };
>  
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
