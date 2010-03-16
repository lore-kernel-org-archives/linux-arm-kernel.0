From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 16 Mar 2010 22:55:48 +0100
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9F8A2B.9020307@st.com>
References: <4B9DB823.1040809@st.com>
	<63386a3d1003151055v6d3e2ee0q848fcbb4c7a29a06@mail.gmail.com>
	<4B9F8A2B.9020307@st.com>
Message-ID: <63386a3d1003161455x4c67cddcnbb9d00b95884bdaa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(CC to Martin who wrote the nice padmux code in case he wants to add
something.)

2010/3/16 Shiraz HASHIM <shiraz.hashim@st.com>:

> I was trying to go through u300 code and it looks clean enough. I need your
> help in understanding it better. In your case you try to configure the pin mux
> and then, even if it fails the device (through amba_device_register) is registered.
> Now if the driver is enabled in the kernel (or it is insmod) then the driver in
> its "probe" would stuck somewhere.

Yep it's because it's not going to fail in current system configs. We request to
mux in MMC/SD + SPI pins, then the rest of the settings (which are vast)
are left untouched.

> Do we need to handle such scenarios. Am I missing something?

No you're correct, but these circumstances does not occur currently on the
U300. But the framework is prepared to handle them.

> Further, if you can describe what is onmask field (of pmx) and what
> devices/options are multiplexed with (say) spi, it would help me better understand
> the code.

.onmask should be something like .bits really, it's tuples of mask+bits to
be set in registers to activate the selected padmux setting. It's all
specific to the DB3xxx system controller, nothing you should worry too
much about really.

>> We've actually seen usecases where you need to dynamically remux while
>> drivers are running but these have been rare and on older chips I think.
>
> You mean to say dynamically remapping pins to achieve some function with
> the same driver? or taking out one driver and inserting another after changing
> mux config.

Actually switching back and forth between using pins in one way and then
in another way for different usecases. Not like every microsecond, but on
minute interval. We tried to avoid it and on the Linux port this was never
the case.

> In any case one of the objective is to keep same linux image for different
> configurations/boards. Isn't it ?

That's more of a side effect. We did have compile-time dependencies that
cannot even be avoided with the devicetree code. For example the U300 series
had physical RAM at different addresses depending on model, that can *never*
be handled with a single kernel image, so we could just give up that idea
immediately....

Linus
