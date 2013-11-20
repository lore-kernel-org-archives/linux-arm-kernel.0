From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Nov 2013 00:20:08 +0000
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
Message-ID: <20131120002007.GR16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 09:24:31PM +0100, Linus Walleij wrote:
> On Tue, Nov 19, 2013 at 4:17 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
> > On 11/19/2013 05:00 PM, Linus Walleij wrote:
> 
> >> And that happens before the GPIO driver gets registered -> crash.
> >
> > That is not the issue. The real issue is h3xxx using those gpio's without
> > previously calling gpio_request.
> 
> Really? But that wasn't done before this patch either.
> 
> It is basically OK to use the gpio_* functions before or
> without requesting the GPIOs, it won't look nice but it
> works.

Using gpio_* functions without first having the GPIO requested causes
a complaint at boot time... so it's really undesirable to do this.

Also note that we _do_ have sa11x0 platforms which request their GPIOs
in their arch_initcall callback, so the sa11x0 GPIO driver better be
around at that point otherwise things *will* fail.

I suspect that means the SA11x0 GPIO driver must be initialised early.
