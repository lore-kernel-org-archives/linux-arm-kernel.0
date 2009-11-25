From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 16:59:45 +0000
Subject: [PATCH 05/17] ARM: pxa/raumfeld: add rotary encoder support
In-Reply-To: <4B0D4CAE.50709@compulab.co.il>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-6-git-send-email-daniel@caiaq.de>
	<4B0D4CAE.50709@compulab.co.il>
Message-ID: <20091125165945.GE5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 05:26:38PM +0200, Mike Rapoport wrote:
> Daniel Mack wrote:
> > @@ -174,6 +197,12 @@ static void __init raumfeld_common_init(void)
> >  
> >  static void __init raumfeld_controller_init(void)
> >  {
> > +	struct platform_device *raumfeld_controller_devices[] = {
> > +		&rotary_encoder_device,
> > +	};
> 
> Any reason to keep the devices array inside the function? I think it makes the
> code less readable.

Also, non-static initialized structures and arrays inside functions are
a waste of space.  You might as well write it like this, because the
following is exactly what the compiler will be doing for you:

static const struct platform_device *__raumfeld_controller_devices[] = {
	&rotary_encoder_device,
};

static void __init raumfeld_controller_init(void)
{
	struct platform_device *raumfeld_controller_devices[ARRAY_SIZE(__raumfeld_controller_devices)];
	memcpy(raumfeld_controller_devices, __raumfeld_controller_devices, sizeof(__raumfeld_controller_devices));
	...
}
