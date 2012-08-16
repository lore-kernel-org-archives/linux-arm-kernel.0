From: alanbutty12@gmail.com (alan butler)
Date: Thu, 16 Aug 2012 11:36:55 +0100
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <CADhrpJ5UF6r2N027nOS6xmJtu21UbDxfzLninCZ7O-A+G3ALgg@mail.gmail.com>
References: <20120815211517.GA15830@lunn.ch>
 <CADhrpJ7+MoKF9qbeh9RBHo3j-m22574pi=cuHfQ9-KeVNX=mzw@mail.gmail.com>
 <20120815213221.GE15830@lunn.ch>
 <CADhrpJ4eAUdDaLF8OXvjRf6oA6ya0na-SHYs43eoNwdoEJETpA@mail.gmail.com>
 <20120815215237.GF15830@lunn.ch>
 <CADhrpJ7ANwD4asN4-D9OeicGA_V5-9DZoV9G6dDFZ9taN7AZsg@mail.gmail.com>
 <20120815221613.GH15830@lunn.ch>
 <CADhrpJ66ncpT74ATyvJDXTuJC-zrmh8vQ99RPg0t=XuQ_2RcVA@mail.gmail.com>
 <CADhrpJ4sH9krkrWSoFjCg5jrkompgFY=G8iiXo0xy8_iCKeKxA@mail.gmail.com>
 <CADhrpJ7=5QbivftpcuVdhmcKxp3rjiuKQ4Lrf3NckBwL6YNmPQ@mail.gmail.com>
 <20120815234159.GK22226@titan.lakedaemon.net>
 <CADhrpJ4EMCuvuynF9x+q-PkNPRBaCD_G_YWbcYVj0UrGRQk5dg@mail.gmail.com>
 <CADhrpJ5UF6r2N027nOS6xmJtu21UbDxfzLninCZ7O-A+G3ALgg@mail.gmail.com>
Message-ID: <CADhrpJ7geSRc3pow-DQWiA3rZ=f0i2WSws_QuKSDk7uZx1VSRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 August 2012 01:00, alan butler <alanbutty12@gmail.com> wrote:
> On 16 August 2012 00:52, alan butler <alanbutty12@gmail.com> wrote:
>> On 16 August 2012 00:41, Jason Cooper <jason@lakedaemon.net> wrote:
>>> On Thu, Aug 16, 2012 at 12:34:46AM +0100, alan butler wrote:
>>>> On 16 August 2012 00:12, alan butler <alanbutty12@gmail.com> wrote:
>>>> > On 16 August 2012 00:02, alan butler <alanbutty12@gmail.com> wrote:
>>>> >> On 15 August 2012 23:16, Andrew Lunn <andrew@lunn.ch> wrote:
>>>> >>> On Wed, Aug 15, 2012 at 10:57:27PM +0100, alan butler wrote:
>>>> >>>> On 15 August 2012 22:52, Andrew Lunn <andrew@lunn.ch> wrote:
>>>> >>>> >> That would be great i just need to recreate the patch with those
>>>> >>>> >> changes but i was talking with jason cooper i believe and he said to
>>>> >>>> >> put the buttons for the device in the dts file and im working on that
>>>> >>>> >> but the kernel panics
>>>> >>>> >
>>>> >>>> > Please show us the panic.
>>>> >>>> >
>>>> >>>> >        Andrew
>>>> >>>>
>>>> >>>> i sent it to jason a lil bit earlier but i guess i must of forgotten
>>>> >>>> to cc the list on the last message or 2 but here is the panic again:
>>>> >>>>
>>>> >>>> [    5.976074] Key type dns_resolver registered
>>>> >>>> [    5.981782] Unable to handle kernel NULL pointer dereference at
>>>> >>>> virtual address 00000004
>>>> >>>> [    5.989932] pgd = c0004000
>>>> >>>> [    5.992649] [00000004] *pgd=00000000
>>>> >>>> [    5.996247] Internal error: Oops: 805 [#1] ARM
>>>> >>>> [    6.000707] Modules linked in:
>>>> >>>> [    6.003780] CPU: 0    Not tainted  (3.6.0-rc1-next-20120814 #13)
>>>> >>>> [    6.009822] PC is at gpio_keys_probe+0x110/0x6d4
>>>> >>>
>>>> >>> You might want to scatter some printk() in gpio_keys_probe() and see
>>>> >>> where it panics. It will probably then be clear what is wrong.
>>>> >>>
>>>> >>>       Andrew
>>>> >>
>>>> >> where do i find the gpio_keys_probe() ?
>>>> >
>>>> > i found the gpio_keys_probe() and it seems that it is failing in this
>>>> > piece of code i put a printk() before and after it and it didnt reach
>>>> > the printk after it:
>>>> >
>>>> > if (!pdata) {
>>>> >                 pdata = gpio_keys_get_devtree_pdata(dev);
>>>> >                 if (IS_ERR(pdata))
>>>> >                         return PTR_ERR(pdata);
>>>> >         }
>>>> >
>>>> >         ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
>>>> >                         pdata->nbuttons * sizeof(struct gpio_button_data),
>>>> >                         GFP_KERNEL);
>>>> >         input = input_allocate_device();
>>>> >         if (!ddata || !input) {
>>>> >                 dev_err(dev, "failed to allocate state\n");
>>>> >                 error = -ENOMEM;
>>>> >                 goto fail1;
>>>> >         }
>>>>
>>>> actualy it seems to not be getting past this piece of code in what i
>>>> posted before:
>>>>
>>>> if (!pdata) {
>>>>               pdata = gpio_keys_get_devtree_pdata(dev);
>>>>               if (IS_ERR(pdata))
>>>>                       return PTR_ERR(pdata);
>>>>       }
>>>
>>> That means gpio_keys_get_devtree_pdata() is returning an error.  Have
>>> you tried 'linux,input-type = <0x05>;' ?
>>>
>>> thx,
>>>
>>> Jason.
>>
>> 'inux,input-type = <0x05>' instead of 'linux,code = <...>' in the dts?
>> no i havent tried will give it a try now.
>
> with the buttons setup as follows:
> gpio-keys {
>                 compatible = "gpio-keys";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 iomotb {
>                         label = "OTB Button";
>                         linux,input-type = <133>;
>                         gpios = <&gpio1 3 1>;
>                         debounce-interval = <100>;
>                 };
>                 iomreset {
>                         label = "Reset";
>                         linux,input-type = <0x198>;
>                         gpios = <&gpio0 12 1>;
>                         debounce-interval = <100>;
>                 };
>         };
>
> it errors at the following:
>
> button->gpio = of_get_gpio_flags(pp, 0, &flags);
> button->active_low = flags & OF_GPIO_ACTIVE_LOW;

with the buttons setup like this:

gpio_keys {
		compatible = "gpio-keys";
		#address-cells = <1>;
		#size-cells = <0>;
		button at 1 {
			label = "Reset Button";
			linux,code = <116>;
			gpios = <&gpio0 12 1>;
		};
		button at 2 {
			label = "Power-on Switch";
			linux,code = <116>;
			gpios = <&gpio0 14 1>;
		};
		button at 3 {
			label = "OTB Switch";
			linux,code = <142>;
			gpios = <&gpio1 3 1>;
		};
	};

the problem seems to be in this comming from this line:

button->gpio = of_get_gpio_flags(pp, 0, &flags);

in the function :

/*
 * Translate OpenFirmware node properties into platform_data
 */
static struct gpio_keys_platform_data * __devinit

of the gpio_keys.c file or whatever that line links to. It does not
know how to deal with some NULL reference as far as i can tell.
