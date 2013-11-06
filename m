From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 6 Nov 2013 08:32:11 -0300
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page I/O
 support
In-Reply-To: <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105190432.GQ20061@ld-irv-0074.broadcom.com>
 <20131106011351.GH11759@localhost>
 <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
Message-ID: <20131106113210.GB2616@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 06:20:18PM -0800, Brian Norris wrote:
[..]
> 
> >> Also, do you plan to support non-ONFI NAND?
> >
> > Not for the time being. (Are there any new non-ONFI NAND devices?)
> 
> Sure there are. I've been seeing non-ONFI parts from Toshiba and
> Macronix, at least (I think Macronix is moving to ONFI soon, though).
> Samsung is around still, too.
> 

Right. Well, for now I would just add a pr_warn("Your device is not
supported. Please ask Ezequiel to add it") or something along those
lines.

BTW: So, I guess that for non-ONFI devices we must simply put the ECC
information in the DT (being a hardware parameter)?

Having followed (part) of the OMAP DT ECC discussion, I'm thinking:
wouldn't it be good to have an 'nand-ecc-strength' property in the DT?

It would match the ecc_strength_ds field. This way, the ECC mode
selection is left to the driver and not to the user.
On the other side, this can cause some severe incompatibilities
unless such driver *always* make the *same* selection.

Anyway, none of this matters in this patchset, for the time being.

[..]
> 
> From the linked response:
> 
> "So, if you set the controller to transfer 2048B you can correct up to
> 16 bits on this 2048B region, or 4 bits per 512B, hence BCH-4."
> 
> Well, "16 bits per 2048" is at least as good as BCH-4 over 512B, but
> it is not exactly the same. A true "16 bits per 2048" would be able to
> correct 16 bitflips concentrated in a 512B region, whereas BCH-4/512B
> would not.
> 

Indeed, 16-over-2048 is stronger than 4-over-512 :)

> But unless we can get better documentation/experiments with the
> controller, it's hard to tell which is the case, and it's probably not
> a big deal at this point. Your current code looks OK, I think.
> 

Ok, great.

> > Feel free to ask any further clarification about how the ECC engine
> > works. If you think it'll help, I can write a separate mail describing
> > it (to the best of my knowledge) and we can discuss there.
> >
> > In particular, the above link contains a question that is still
> > unanswered and that would help me understand this better.
> > I'll copy-paste it here:
> >
> > """
> > Regarding this: I'd really like to understand better this 'step' concept
> > and it applicability on this controller. So any clarification is welcome
> > :)
> >
> > As far as I can see: currently the hardware does ECC corrections in a
> > completely transparent fashion and merely 'reports' the no. of corrected
> > bits through some IRQ plus some registers.
> > Therefore, it implements the ecc.{read,write}_page() functions.
> >
> > So, why should I tell the NAND core any of the ECC details?
> 
> Because MTD/NAND now implements a bitflip threshold based on the
> reported ECC strength and step size. See commit:
> 
>   commit edbc4540e02c201bdd4f4d498ebb6ed517fd36e2
>   Author: Mike Dunn <mikedunn@newsguy.com>
>   Date:   Wed Apr 25 12:06:11 2012 -0700
> 
>       mtd: driver _read() returns max_bitflips; mtd_read() returns -EUCLEAN
> 
> and some of the other related code and documentation, such as in this commit:
> 
>   commit d062d4ede877fcd2ecc4c6262abad09a6f32950a
>   Author: Mike Dunn <mikedunn@newsguy.com>
>   Date:   Wed Apr 25 12:06:08 2012 -0700
> 
>       mtd: bitflip_threshold added to mtd_info and sysfs
> 
> If you don't have the correct strength, then this may not work as
> intended. (I realized now that the ECC step size doesn't play a part
> in the bitflip threshold process; only the strength is required to be
> correct.)
> 
> ...and now that I bring this up, I see that pxa3xx_nand.c has not been
> updated to report 'max_bitflips' via return code from
> pxa3xx_nand_read_page_hwecc(). This needs fixed. I wonder how many
> other drivers are similarly broken. I just realized that my
> out-of-tree driver is broken for this feature :(
> 

Hm.. I see. Well, it's just a matter of returning the corrected bits,
which are already obtained. Furthermore, one of the last patches in
this series, namely:

"mtd: nand: pxa3xx: Add ECC BCH correctable errors detection"

Takes care of obtaining the proper corrected bits number.

(Let me paste here your other reply to this same mail)

"""
> To clarify a bit further: the ECC step size doesn't play a part in
> nand_base when dealing with max_bitflips, but it is implicit in the
> specification: the driver should be returning the maximum number of
> bitflips corrected in a single ECC sector of the page that was read.
> So if your driver reports ECC strength of 8 over a 512 byte step, then
> you should report a number in the range of 0 to 8, representing
> bitflips in a 512B sector. If you don't have this granularity (which
> it looks like you might not?) then maybe your strength-per-sector
> should really be 16-per-2048B or 16-per-1024B, etc.
"""

So, if I understand correctly and assuming the controller works as the
specification says (sorry, it's not public yet) I think the 'step' is
the chunk size and the strength is 16 bytes:

	/* In BCH mode */
	ecc->size = chunk->size;
	ecc->strength = 16;

And maybe I could try to expand some more the ECC description in the
Documentation/mtd/nand/pxa3xx-nand.txt.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
