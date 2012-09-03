From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Sep 2012 14:28:50 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <CACRpkdZvWkH2gQQuNvCkNuB-faT8qHAjyiULSqPKrn+FCktvLg@mail.gmail.com>
References: <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
 <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
 <CAF2Aj3j25w1Nn9O6hV+=i-j1ts_p_Ucswk_M7r04S7i5BzPkHg@mail.gmail.com>
 <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
 <20120903123424.GA31163@gmail.com>
 <CACRpkdZvWkH2gQQuNvCkNuB-faT8qHAjyiULSqPKrn+FCktvLg@mail.gmail.com>
Message-ID: <20120903132844.GD31163@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 03:19:13PM +0200, Linus Walleij wrote:
> On Mon, Sep 3, 2012 at 2:34 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > When booting DT booting take a different path and no platform data
> > is passed. We can't boot DT AND register devices with platform data
> > or else we will double probe every device. The only way to pass
> > pdata when booting with DT is with AUX_DATA() and that's a hack to
> > get around things we don't have support for yet. Up until now that
> > has been DMA bindings, clock and pinctrl names and call-backs.
> 
> So if we pass some augmented platform data using AUX_DATA()
> that appears as pdata in this case, and gets discarded.
> 
> Thus we cannot use AUX_DATA() to override a broken, as in
> "the interrupt number is wrong" device tree.

No, you cannot to that. You'd have to fix it in DT (which is easier).

> > If DT is corrupt or missing the kernel will boot using platform
> > data, but np will always be NULL, so we don't have the problem you
> > were alluding to above.
> 
> That was not the problem I had in mind.
> 
> I had a valid, but incorrect device tree in mind. I.e the device
> is there, but with wrong base address, or wrong IRQ number.
> 
> If pdata takes precedence, we can use AUX_DATA() to
> override such errors from the platform, since drivers/of/platform.c
> helpfully pokes in the auxdata as the platform data.

Yes, that's what happens.

> I thought this was one of the reasons why auxdata exist
> at all.

I don't think so. I've been told that AUXDATA is just a hack. My
aim is to rid the boardfile of all AUXDATA entries.

> Or is the proper solution to runtime-patch the device tree
> per se in such cases? How is that actually done then?

No, you can't do that either. DT is only read once at boot-time.

The correct solution would be to fix the broken DT.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
