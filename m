From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 15:08:27 +0200
Subject: [PATCH v2] pinmux: add a driver for the CSR SiRFprimaII pinmux
In-Reply-To: <CAGsJ_4xpYMzHGi09jt2Y9xCocYJ0iHYRfdvwCzcH65uaF2sP0g@mail.gmail.com>
References: <1314843744-2910-1-git-send-email-Baohua.Song@csr.com>
	<CACRpkdbb_5EZHT3=SNePbW-=NYjLSLzJgjEdEaBV7X=s6gxydw@mail.gmail.com>
	<CAGsJ_4xpYMzHGi09jt2Y9xCocYJ0iHYRfdvwCzcH65uaF2sP0g@mail.gmail.com>
Message-ID: <3712698.4MAZQPafzW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 19:58:23 Barry Song wrote:
> > You can probably simplify this and other things with
> > preprocessor macros if you want to, like:
> >
> > #define SIRF_FUNC_ENTRY(a) \
> > { .name = "##a##", .pins = ##a##_pins, .num_pins =
> > ARRAY_SIZE(##a##_pins), .padmux = &##a##_padmux }
> >
> > Then just:
> >
> > static const struct sirfsoc_pinmux_func sirfsoc_pinmux_funcs[] = {
> >     SIRF_FUNC_ENTRY(lcd_16bits),
> >
> >
> > The macro syntax is probably wrong, the preprocessor always
> > craze me out, but you get the idea.
> 
>  :-)  .name = "##a##"  should be changed to .name = #a
> 
> #name will convert name into a string "name"
> 

Better don't use string concatenation at all if you can avoid it.

A generic macro like

#define SIRF_PINMUX(_name, _pins, _padmux) \
	{ .name = (_name), .pins = (_pins), \
	  .num_pins = ARRAY_SIZE(_pins), padmux = (_padmux), }

is both very easy to understand for someone reading it casually and
lets you actually grep for where the identifiers are being used.

> static const struct sirfsoc_pinmux_func sirfsoc_pinmux_funcs[] = {
>     SIRF_FUNC_ENTRY(lcd_16bits),

for the first time, you have no clue what that does, but

static const struct sirfsoc_pinmux_func sirfsoc_pinmux_funcs[] = {
	SIRF_PINMUX("lcd_16bits", lcd_16bits_pins, &lcd_16bits_padmux),
	...
};

Makes it very clear what you are referencing here and needs no extra lines.

	Arnd
