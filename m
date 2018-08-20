From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 20 Aug 2018 21:06:21 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <CAMRc=McwEjofZKP93DxPa8vJLE6NceLLGfcbcK9-Pfk-dav_Zg@mail.gmail.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <CAMRc=McwEjofZKP93DxPa8vJLE6NceLLGfcbcK9-Pfk-dav_Zg@mail.gmail.com>
Message-ID: <20180820210621.5ffe3866@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2018 20:50:55 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> 2018-08-20 20:20 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Mon, 20 Aug 2018 11:43:34 +0100
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >  
> >>
> >> Overall am still not able to clear visualize on how MTD bindings with
> >> nvmem cells would look in both partition and un-partition usecases?
> >> An example DT would be nice here!!  
> >
> > Something along those lines:
> >
> >         mtdnode {
> >                 nvmem-cells {
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> >
> >                         cell at 0 {
> >                                 reg = <0x0 0x14>;
> >                         };
> >                 };
> >
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >                         #address-cells = <1>;
> >                         #size-cells = <1>;
> >
> >                         partition at 0 {
> >                                 reg = <0x0 0x20000>;
> >
> >                                 nvmem-cells {
> >                                         #address-cells = <1>;
> >                                         #size-cells = <1>;
> >
> >                                         cell at 0 {
> >                                                 reg = <0x0 0x10>;
> >                                         };
> >                                 };
> >                         };
> >                 };
> >         };  
> 
> If there'll be an agreement on the bindings: will you be willing to
> merge Alban's patch even without support in the code for the above
> (with the assumption that it will be added later)?

No, because Alban's patch actually allows people to define and
reference nvmem cells in a DT, but without documenting it (see my first
reply).

> My use-case is on
> non-DT systems and creating nvmem devices corresponding to MTD
> partitions if fine by me.

What you propose is option #1 in my list of proposals, and it requires
some changes to avoid automatically assigning nvmem->dev.of_node to
parent->of_node (which will be != NULL when the MTD device has been
instantiated from a DT node).

> I also don't have the means to test the
> support for these bindings if I were to actually write them myself.

And that's the very reason I proposed #1. I don't want to block this
stuff, but in its current state, I'm not willing to accept it either.
Either we agree on the binding and patch the nvmem framework to support
this new binding, or we find a way to hide the fact that the mtd
device (the nvmem parent) has a DT node attached to it.
