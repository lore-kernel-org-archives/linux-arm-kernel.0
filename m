From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 16 May 2016 17:34:26 +0900
Subject: [PATCH v9 2/2] gpio: move clps711x, moxart,
 ts4800 and gpio-ge =?iso-8859-1?Q?into_gpio-mmio?=
In-Reply-To: <1626318.aFfl1tphqe@debian64>
References: <cover.1462911225.git.chunkeey@googlemail.com>
 <85c74586dbd0023306f012764b85d6aa168b4ae7.1462911225.git.chunkeey@googlemail.com>
 <3c67e0ca-43eb-4a77-90ef-f8e2757c8edd@gmail.com>
 <1626318.aFfl1tphqe@debian64>
Message-ID: <0447d450-b538-4dbe-9290-98ad9dfcd3b1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 12, 2016 10:07:06 PM JST, Christian Lamparter wrote:
> On Thursday, May 12, 2016 07:30:05 PM Alexandre Courbot wrote:
>> On Wednesday, May 11, 2016 6:34:35 PM JST, Christian Lamparter wrote: ...
> [...]
>>> ...
>> Ouch, I don't like this. Also the probability that the "if (!res->name || 
>> ...)" condition is not met is so small that I would not bother 
>> with it and 
>> do the kstrdup unconditionally. But maybe we can remove this altogether - 
>> see below... ...
>
> The !res->name check is simply there because the kernel's strcmp doesn't
> check for NULL... the res->name will be coming from the device tree.
> Yes it should always be initialized but again: it's not within 
> the functions 
> control so it better be prepared for it. The "dir_reg_name" is part of the
> function so we can guarantee that it's not NULL or a invalid string. 
>
> About the leakage: I use devm_kstrdup unlike the dump strdup, it does bind
> the dupped string to the device. This way the resource is not leaked even
> if the module is loaded and unloaded, it stays with the device. (Until
> it is destroyed).

What I wanted to point out is that it is probably ok to just duplicate the 
string at all times, since the probability that res->name will not be NULL 
*and* the string will already match what we expect is very low (and could 
only come from a device tree that is aware of this patch).

Leakage is not a concern thanks to devm, as you have pointed out.

>  
> Note: The strcmp is there to check if resource name was already updated
> so even if the module was loaded multiple times it will dup the string
> just once.

Mmm, is this how things really work? My understanding is that 
devm-allocated resources will be freed after the driver's remove function 
is called (see slides 11/12 of 
http://haifux.org/lectures/323/haifux-devres.pdf). I.e. when the module is 
unloaded, your string will be destroyed. So unless I am missing something 
you would still need to duplicate it the next time the device is probed.

So here it seems to me that to be on the safe side you either need to 
restore the previous value of res->name on device destruction, or always 
duplicate the string when probing it. But with this later solution there is 
still the risk that if you then load *another* driver to probe this device, 
which will then find a valid pointer on res->name, only to find invalid 
content when following it... So in the end I'd recommend against messing 
with resources like that - it just creates potential for invalid states.

Hopefully is my following suggestion is valid, you won't need to.

>
> Doing a direct assignment like I did in the earlier versions would lead
> to issues since the device resources are part of the the device and not
> with the driver module.
>
>>> ...
>> Ok, so this is getting quite complex, with two of_device_id 
>> tables and two 
>> levels of hooks, mainly because you want to use the bgpio_pdev_probe() 
>> function which relies on named memory resources. ...
> I think I need more here. The bgpio_pdev_probe() also sets up 
> the bgpio_maps()
> (there are 6 and I'm using 4 at the moment for all compat chips). 
> The bgpio_pdev_probe() also deals with devm_gpiochip_add_data() 
> and allocates
> the memory for the gpiochip structure... as well as  and the error handling.
> etc...
>
> That's why I reused the existing code as much as possible.
> (But let's get to the main issue here:)
>> This function is here for basic platform devices, and you are not obliged 
>> to rely on it for DT. Feel free to write your own function (or 
>> rather split 
>> bgpio_pdev_probe() in two code paths) if it can reduce the 
>> amount of black 
>> magic you need to do (especially the renaming of resources on-the-fly).
>> 
>> At the end of the day what you want is a function that calls 
>> bgpio_init()  ...
>
> The main issue why this got so complicated was keeping compatibility with
> the existing drivers.
>
> If you look at "clps711x_parse_dt". You will see that it supports 5 GPIOs.
> The thing that makes it really ugly is that it uses the dt alias as a way
> to identify each port (A-E). The Port is then used to encode the number of
> gpios the controller has and whenever it is dirin or dirout... 
> I argued that this information should be put in the dts and I made patch
> for it. But updating the dts was not the way to go. as Rob explained
> in <http://www.spinics.net/lists/devicetree/msg124538.html>.
>
> This means that unless you can make a single structure that would encode
> everything these compat drivers do, (look at the call_back functions of
> the other drivers, each of the compat drivers also has a little bit of
> extra code associated to setup stuff like a label or have an extra ngpios
> property parser, etc...). I cannot see how you could make this any better
> without breaking compatibility. This was the sole reason why there are
> these individual parsers. (In RFC v4? I had that parser in their original
> files - I don't know if this would have worked any better, but feedback
> indicated that everything should be moved to the gpio-mmio.c). 
>
> So, what's your take on it?

I think your problem can be summarized as follows: for each device, you 
need to call bgpio_init() with the proper parameters. Your goal is to infer 
the right parameters for a variety a devices that make a different use of 
the device tree.

Because of this, you *will* need device-specific DT-parsing functions, and 
your current patch already contains them (like clps711x_parse_dt()). My 
suggestion is to not rely on bgpio_pdev_probe() for these specific devices, 
as this function expects resources, and forces you to so some unclear 
hacking. Instead, how about something like the following (warning, this is 
dirty and just to let you get the idea):

/* Params to bgpio_init()  */
struct bgpio_params {
    unsigned long sz;
    void __iomem *dat;
    void __iomem *set;
    void __iomem *clr;
    void __iomem *dirout;
    void __iomem *dirin;
    unsigned long flags;

    struct bgpio_pdata pdata;
};

static int clps711x_parse_dt(struct platform_device *pdev,
		struct bgpio_params *params)
{
	struct device_node *np = pdev->dev.of_node;
	struct resource *res;
	void __iomem *mem;
	int id = np ? of_alias_get_id(np, "gpio") : pdev->id;

	params->pdata.base = id * 8;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res)
		return -EINVAL;
	params->dat = devm_ioremap_resource(&pdev->dev, res);

	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	if (!res)
		return -EINVAL;
	mem = devm_ioremap_resource(&pdev->dev, res);

	switch (id) {
	case 0:
	case 1:
	case 2:
		pdata->ngpio = 0; /* determined by register width */
		params->dirout = mem;
		break;
	case 3:
		pdata->ngpio = 0; /* determined by register width */
		/* PORTD is inverted logic for direction register */
		params->dirin = mem;
		break;
	case 4:
		pdata->ngpio = 3; /* PORTE is 3 lines only */
		params->dirout = mem;
		break;
	default:
		return -ENODEV;
	}

	return 0;
}

static int bgpio_pdev_probe(struct platform_device *pdev)
{
    /* clear params out */
    struct bgpio_params params = { 0 };
    const int (*parse_dt)(struct platform_device *,
                          struct bgpio_params *);

    parse_dt = of_device_get_match_data(&pdev->dev);
    /* We are not instanciated from the DT, do regular probe using 
resources */
    if (!parse_dt) {
        struct resource *r;

        r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
        if (!r)
                return -EINVAL;

        params.sz = resource_size(r);

        params.dat = bgpio_map(pdev, "dat", sz);
        if (IS_ERR(params.dat))
                return PTR_ERR(params.dat);

        /* etc, fill in params by doing what bgpio_pdev_probe initially did 
*/
    } else {
        /* instanciated from DT, fill in params with the device-specific 
function */
        parse_dt(pdev, &params);
        pdata = &params.pdata;
    }

    ....
 
    err = bgpio_init(gc, dev, params.sz, params.dat, params.set, 
params.clr, params.dirout, params.dirin, params.flags);
    ....
}

... or something like that, it is probably possible to make this cleaner by 
refactoring the code a bit (bgpio_pdata and my new params structure can 
probably be merged, for instance).

You get the same result, but without messing with resources in dangerous 
ways, and also removing one level of callback (and some hard-to-follow 
macros). Of course parse_dt functions can be shared across devices when 
they are compatible. Feel also free to adopt another approach (like 
returning the struct resource in bgpio_params instead of the mapped 
resource so you can call a modified bgpio_map() on them in 
bgpio_pdev_probe()) if you find this more elegant. The idea I want to 
convey is that you don't need to rely on the named resources at all times.

Hope this clarifies!

Alex.
