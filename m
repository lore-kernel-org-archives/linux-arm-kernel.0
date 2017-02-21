From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 21 Feb 2017 11:26:41 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon>
 <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
Message-ID: <20170221112641.6276c001@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Feb 2017 12:03:45 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Feb 21, 2017 at 10:06 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Tue, 21 Feb 2017 01:54:37 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> >> On Tue, Feb 21, 2017 at 1:40 AM, Andy Shevchenko
> >> <andy.shevchenko@gmail.com> wrote:  
> >> > On Mon, Feb 20, 2017 at 10:50 PM, Boris Brezillon
> >> > <boris.brezillon@free-electrons.com> wrote:  
> >> >> On Mon, 20 Feb 2017 21:38:03 +0100
> >> >> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
> >> >>  
> >> >>> On Mon, 20 Feb 2017 22:27:17 +0200
> >> >>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >> >>>  
> >> >>> > On Mon, Feb 20, 2017 at 2:28 PM, Boris Brezillon
> >> >>> > <boris.brezillon@free-electrons.com> wrote:
> >> >>> >  
> >> >>> > >  drivers/mtd/nand/atmel/nand-controller.c | 2269 +++++++++++++++++++++++++++
> >> >>> > >  drivers/mtd/nand/atmel_nand.c            | 2479 ------------------------------  
> >> >>> >
> >> >>> > Does -M -C help you?
> >> >>> > At least it would help reviewers
> >> >>> >  
> >> >>>
> >> >>> No it doesn't, because files were not just moved around using git mv,
> >> >>> it's a complete rewrite of the driver. IIUC, you're about to review
> >> >>> this submission, or are you just trolling like last time?  
> >> >>
> >> >> My bad, I mistaken you with someone else. Sorry for being harsh, but my
> >> >> explanation stands ;-).  
> >> >
> >> > No problem. I was asking since it so big and on first glance looks
> >> > like a partial copy (I dunno if parameter to -C makes it somehow
> >> > useful), though I can't review this. It's too big to me. Sorry I'm
> >> > really not trolling, just didn't read commit message carefully.  
> >>
> >> Okay, I very quickly looked into the code, what I noticed
> >> - you like extra parens and empty lines in some cases (not big deal)  
> >
> > Can you point specific places where you think these are not needed?  
> 
> 1. For example,
> 
> #define ATMEL_NFC_CMD(pos, cmd)                        ((cmd) <<
> (((pos) * 8) + 2))

Well, I like to explicitly put parenthesis even when operator
precedence guarantees the order of the calculation ('*' is preceding
'+').

For the parenthesis around (cmd) and (pos), they are required to
guarantee that things like ATMEL_NFC_CMD(x + y, cmd) are working
correctly.

> 
>  *events ^= (status & *events);

I agree with this one, it's uneeded.

> 
>  (((x) * 0x4) + 0x28)

See my comment about ATMEL_NFC_CMD().

> 
>   memset(&si[1], 0, sizeof(s16) * ((2 * strength) - 1));

Ditto.

> 
> Perhaps more in the code. I'm not a LISP programmer.
> 
> 2. For empty lines it's solely matter of style, I don't care. My motto
> "less LOC better, but keep common sense in mind".
> 
> >> - some functions perhaps might have been refactored to have common
> >> pieces in error handling, though I didn't read core carefully.  
> >
> > Again, be more precise.  
> 
> 3. I don't remember anymore, sorry. Something I would refactor.
> 
> >> Most important part I have noticed is a GPIO request.
> >> I didn't get why you almost repeat gpiod_get() in case of platform data?
> >> Shouldn't we have GPIO look up table?
> >> Can we use builtin device properties (for GPIO and/or overall)?  
> >
> > Sorry but I don't get it. Can give an example of what you'd like me to
> > do?
> >  
> 
> 4. First of all, why do you need this function in the first place?
> 
> +struct gpio_desc *
> +atmel_nand_pdata_get_gpio(struct atmel_nand_controller *nc, int gpioid,
> +                         const char *name, bool active_low,
> +                         enum gpiod_flags flags)

Because I don't want to duplicate the code done in
atmel_nand_pdata_get_gpio() each time I have to convert a GPIO number
into a GPIO descriptor, and that is needed to support platforms that
haven't moved to DT yet (in this case, avr32).

> 
> 5. BIT() macro:
> 
>    const unsigned int k = 1 << deg(poly);
>    unsigned int nn = (1 << mm) - 1;

Yes, I must admit I didn't polish the code in PMECC, and most of it has
been copied from the old driver.
We could probably use BIT() in a few places.

> 
> 6. Why this casting (unsigned int) ?
> 
>  dev_dbg(pmecc->dev,
>                        "Bit flip in %s area, byte %d: 0x%02x -> 0x%02x\n",
>                        area, byte, *ptr, (unsigned int)(*ptr ^ BIT(bit)));

Again, this has been copied from the old driver. I'll have a closer
look.

> 
> 7. Question to all that distribution or whatever functions, don't you
> have a common helper? Or each vendor requires different logic behind
> it?

What are you talking about? nand_chip hooks?

> 
> 8. Have you checked what kernel library provides?

I think so, but again, this is really vague, what kind of
open-coded functions do you think could be replaced with core libraries
helpers?

> 
> And I believe there are still issues like those. After, who is on
> topic, might even find some logical and other issues...
> 
> P.S. TBH, so big change is unreviewable in meaningful time. To have a
> comprehensive review I, for example, spend ~1h/250LOC, and
> ~2.5h/1000LOC, I would estimate ~4h/2000LOC. Imagine one to spend one
> day for this. Any volunteer? Not me.

I'm not asking you to review the whole driver, but you started to
comment on the code without pointing clearly to the things you wanted
me to address.
