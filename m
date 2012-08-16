From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 17 Aug 2012 00:10:00 +0200
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <CADhrpJ7geSRc3pow-DQWiA3rZ=f0i2WSws_QuKSDk7uZx1VSRQ@mail.gmail.com>
References: <20120815215237.GF15830@lunn.ch>
 <CADhrpJ7ANwD4asN4-D9OeicGA_V5-9DZoV9G6dDFZ9taN7AZsg@mail.gmail.com>
 <20120815221613.GH15830@lunn.ch>
 <CADhrpJ66ncpT74ATyvJDXTuJC-zrmh8vQ99RPg0t=XuQ_2RcVA@mail.gmail.com>
 <CADhrpJ4sH9krkrWSoFjCg5jrkompgFY=G8iiXo0xy8_iCKeKxA@mail.gmail.com>
 <CADhrpJ7=5QbivftpcuVdhmcKxp3rjiuKQ4Lrf3NckBwL6YNmPQ@mail.gmail.com>
 <20120815234159.GK22226@titan.lakedaemon.net>
 <CADhrpJ4EMCuvuynF9x+q-PkNPRBaCD_G_YWbcYVj0UrGRQk5dg@mail.gmail.com>
 <CADhrpJ5UF6r2N027nOS6xmJtu21UbDxfzLninCZ7O-A+G3ALgg@mail.gmail.com>
 <CADhrpJ7geSRc3pow-DQWiA3rZ=f0i2WSws_QuKSDk7uZx1VSRQ@mail.gmail.com>
Message-ID: <20120816221000.GG18145@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> the problem seems to be in this comming from this line:
> 
> button->gpio = of_get_gpio_flags(pp, 0, &flags);
> 
> in the function :
> 
> /*
>  * Translate OpenFirmware node properties into platform_data
>  */
> static struct gpio_keys_platform_data * __devinit
> 
> of the gpio_keys.c file or whatever that line links to. It does not
> know how to deal with some NULL reference as far as i can tell.

Do you mean this piece of code:

       while ((pp = of_get_next_child(node, pp))) {
                enum of_gpio_flags flags;

                if (!of_find_property(pp, "gpios", NULL)) {
                        pdata->nbuttons--;
                        dev_warn(dev, "Found button without gpios\n");
                        continue;
                }
                buttons[i].gpio = of_get_gpio_flags(pp, 0, &flags);

This would fit with:

[    5.981782] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
  
since gpio is at offset 4 in buttons. What is the value of i when it
oppses? What is buttons[i]?

	Andrew
