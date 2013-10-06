From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Oct 2013 10:29:17 +0200
Subject: [linux-sunxi] [PATCH 0/4] Add support for the Allwinner A31
 Reset Controllers
In-Reply-To: <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
References: <1380983960-11087-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAPNxggaUW1B8Ea-gSo+XV2P9s4MRa1L25_ZAvOWyLN6VqQ6wsQ@mail.gmail.com>
Message-ID: <20131006082917.GD3106@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roman,

On Sun, Oct 06, 2013 at 01:32:13AM +0200, Arokux X wrote:
> On Sat, Oct 5, 2013 at 4:39 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi everyone,
> >
> > This patchset adds support for the reset controllers found in the Allwinner A31
> > SoCs. Since these controllers are pretty simple, basically just a few MMIO
> > registers, with a single bit controlling the reset state of the other devices
> > it asserts in reset, the driver is quite simple as well.
> 
> I think we need something smarter here. There are reset bits all over
> the place. After a hint by Emilio and small chat with Oliver I've
> realized I have 3 reset bits in USB host clock module [0].

I wasn't aware there were other IPs behaving like this in older SoCs.
Thanks for pointing this out.

Something smarter in what sense? It's just one bit to put in one
register, I don't really see how it can be "smart".

> Maybe implementation like this one [1] where a mask can be passed as a
> parameter will be more appropriate? (Those reset bits behave the same
> as gatable clocks really.)

No, they don't behave like gatable clocks, and they shouldn't be
implemented with the clock framework. Whenever you disable a clock, the
child device will retain its configuration, while with the reset part,
well, it will just be reset. This makes one huge difference.

We have a shiny new reset framework for this, made exactly for these
cases, why not use it?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131006/a347db60/attachment.sig>
