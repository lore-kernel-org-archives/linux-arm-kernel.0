From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 17 Jul 2015 14:22:20 +0300
Subject: [PATCH 2/2] ARM: OMAP2+: Remove legacy booting support for Pandora
In-Reply-To: <20150717045405.GQ17550@atomide.com>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
 <1437047951-22300-3-git-send-email-tony@atomide.com>
 <CANOLnOPQHOY5Up8+uKQn-JTK4zN=iK+owSN2KjhJGNFLVzN9yQ@mail.gmail.com>
 <20150716162616.GO17550@atomide.com>
 <20150717045405.GQ17550@atomide.com>
Message-ID: <CANOLnOPxteeZ7dkd0wrZKCRzf=0qiW7-kcG-aup2S=XME8v0VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 7:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [150716 09:28]:
>> * Grazvydas Ignotas <notasas@gmail.com> [150716 07:16]:
>> > Hi,
>> >
>> > On Thu, Jul 16, 2015 at 2:59 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > > We've been moving all omap2+ based systems to boot in device tree only
>> > > mode for a few years now. Only omap3 has legacy booting support
>> > > remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
>> > > files for booting with device tree.
>> > >
>> > > This board has support for device tree based booting, and we've been
>> > > printing warnings about the legacy booting being deprecated for a
>> > > few merge cycles now. Let's attempt to remove the legacy booting
>> > > for it.
>> > >
>> > > The reason for removing the legacy booting support now rather than
>> > > later is we can simply revert this patch if necessary if we run
>> > > into some unexpected issues that are not trivial to fix for the
>> > > device tree based booting.
>> >
>> > It seems we lose wifi, backlight, audio and usb host mainline support
>> > with this as pandora's .dts currently lacks all that stuff.
>
> More on that later on, but a question on the vendor kernel first..
>
>> > That said I'm not aware of any mainline users (everyone seems to be on
>> > our "vendor" kernel), so maybe we can add those later.
>
> What all is keeping people from using mainline kernel on pandora?
> Is it the sgx or are there other reasons too remaining?

There are multiple things, besides SGX:
- lack of 1GHz support due to lack of ABB/AVS. Meanwhile we have been
running all pandoras at 1GHz for years without ABB/AVS on our kernel
and no problems have been reported by users.
- overclocking support. It seems most DM3730s can do 1.2GHz and all
can do 1.1GHz, running the device at that clock noticeably speeds up
things, so we provide that functionality out of the box. No instances
of SoC damage were reported over the years.
- using aufs for software packages, aufs wasn't merged and probably
will never be
- keypad Fn key handling in the driver to simulate hardware Fn (not
allowed in mainline)
- lack of driver for analog nubs

That said there probably are some people who can live without the
above and prefer new features of new mainline kernels.

>> Hmm wifi should be easy, isn't that just libertas_sdio?
>
> Nope wl1251, we can initialize with pdata-quirks.c for now if it
> does not yet support device tree except for the SPI version.
> The same goes for the other devices too if needed, I'd assume
> the the EHCI is similar to beagle though.

Yeah maybe I should try to come up with a patch...

> And of course we can still wait on removing the pandora board file
> if you want to. Sounds like that may not be needed though because of
> people using "vendor" kernel in this case even with the legacy
> booting?

Yes if it interferes with other mainline work just go ahead and remove it.

>
> Regards,
>
> Tony

Gra?vydas
