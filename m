From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 18:20:18 -0800
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page I/O
 support
In-Reply-To: <20131106011351.GH11759@localhost>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105190432.GQ20061@ld-irv-0074.broadcom.com>
 <20131106011351.GH11759@localhost>
Message-ID: <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 5:13 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On Tue, Nov 05, 2013 at 11:04:32AM -0800, Brian Norris wrote:
>> On Tue, Nov 05, 2013 at 09:55:29AM -0300, Ezequiel Garcia wrote:
>> > --- a/drivers/mtd/nand/pxa3xx_nand.c
>> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
>> > @@ -1155,7 +1306,30 @@ static int armada370_ecc_init(struct pxa3xx_nand_info *info,
>> >                           struct nand_ecc_ctrl *ecc,
>> >                           int strength, int page_size)
>> >  {
>> > -   /* Unimplemented yet */
>> > +   if (strength == 4 && page_size == 4096) {
>>
>> You compare only to ecc_strength_ds, and not ecc_step_ds. While it is
>> likely that a 4-bit ECC NAND will have a 512-byte ECC step size, you
>> should probably check this.
>
> OK.
>
>> What about strength < 4? Shouldn't you be able to support a 1-bit ECC
>> NAND with your 4-bit ECC?
>>
>
> Yes, probably. The rationale behind these xxx_ecc_init() functions is
> to only validate the devices I've tested or that are known to work.
>
> That said, maybe I'm being too paranoid.

No, maybe paranoid is fine. I was just bringing it up. Being too
liberal in what you accept can create compatibility problems later. So
if you wait to handle generalities until you see them in practice, you
can potentially save yourself some problems.

>> Also, do you plan to support non-ONFI NAND?
>
> Not for the time being. (Are there any new non-ONFI NAND devices?)

Sure there are. I've been seeing non-ONFI parts from Toshiba and
Macronix, at least (I think Macronix is moving to ONFI soon, though).
Samsung is around still, too.

>> Remember that nand_base
>> doesn't guarantee giving you a non-zero ECC strength. You might need a
>> DT binding to specify this, if it's not automatically detectable.
>>
>
> Given this series is already long and complex, I'd like to push as much
> features as possible to follow-up patches. That way we can support the
> current boards out there now (Mirabox's a relevant example) and add support
> for more later, gradually.

Right, I agree with a follow-up, and only if necessary. I was just
trying to plant the seeds of thought for you, so we don't run into a
maintenance problem such as Huang's gpmi-nand has. And as long as you
can plan a reasonable forward/backward-compatible solution for any
currently-supported configurations, then you don't need to add the DT
binding at all, if you don't currently need it. This is where the
paranoid approach can help you, too.

>> > +           ecc->mode = NAND_ECC_HW;
>> > +           ecc->size = 512;
>> > +           ecc->layout = &ecc_layout_4KB_bch4bit;
>> > +           ecc->strength = 4;
>> > +
>> > +           info->ecc_bch = 1;
>> > +           info->chunk_size = 2048;
>> > +           info->spare_size = 32;
>> > +           info->ecc_size = 32;
>> > +           return 1;
>> > +
>> > +   } else if (strength == 8 && page_size == 4096) {
>> > +           ecc->mode = NAND_ECC_HW;
>> > +           ecc->size = 512;
>> > +           ecc->layout = &ecc_layout_4KB_bch8bit;
>> > +           ecc->strength = 8;
>>
>> These ECC parameters (8-bit per 512 and 4-bit per 512) sound reasonable
>> and consistent with other ECC schemes I've seen. But I'm still not clear
>> if we are 100% certain that matches the actual hardware implementation.
>> Did you do any further research since the last time we talked about
>> this?
>>
>
> Yes, and I tried to answer your questions in detail in the cover letters
> (which now is in a patch for Documentation/mtd/nand/...) and in past
> discussion.

I don't see a patch for Documentation/mtd/nand/... Am I missing something?

> See for instance: http://permalink.gmane.org/gmane.linux.drivers.mtd/48895.

My memory fails me, I guess. You did answer some of my questions, but
I was still left with some more. I failed to follow up properly...

>From the linked response:

"So, if you set the controller to transfer 2048B you can correct up to
16 bits on this 2048B region, or 4 bits per 512B, hence BCH-4."

Well, "16 bits per 2048" is at least as good as BCH-4 over 512B, but
it is not exactly the same. A true "16 bits per 2048" would be able to
correct 16 bitflips concentrated in a 512B region, whereas BCH-4/512B
would not.

But unless we can get better documentation/experiments with the
controller, it's hard to tell which is the case, and it's probably not
a big deal at this point. Your current code looks OK, I think.

> Feel free to ask any further clarification about how the ECC engine
> works. If you think it'll help, I can write a separate mail describing
> it (to the best of my knowledge) and we can discuss there.
>
> In particular, the above link contains a question that is still
> unanswered and that would help me understand this better.
> I'll copy-paste it here:
>
> """
> Regarding this: I'd really like to understand better this 'step' concept
> and it applicability on this controller. So any clarification is welcome
> :)
>
> As far as I can see: currently the hardware does ECC corrections in a
> completely transparent fashion and merely 'reports' the no. of corrected
> bits through some IRQ plus some registers.
> Therefore, it implements the ecc.{read,write}_page() functions.
>
> So, why should I tell the NAND core any of the ECC details?

Because MTD/NAND now implements a bitflip threshold based on the
reported ECC strength and step size. See commit:

  commit edbc4540e02c201bdd4f4d498ebb6ed517fd36e2
  Author: Mike Dunn <mikedunn@newsguy.com>
  Date:   Wed Apr 25 12:06:11 2012 -0700

      mtd: driver _read() returns max_bitflips; mtd_read() returns -EUCLEAN

and some of the other related code and documentation, such as in this commit:

  commit d062d4ede877fcd2ecc4c6262abad09a6f32950a
  Author: Mike Dunn <mikedunn@newsguy.com>
  Date:   Wed Apr 25 12:06:08 2012 -0700

      mtd: bitflip_threshold added to mtd_info and sysfs

If you don't have the correct strength, then this may not work as
intended. (I realized now that the ECC step size doesn't play a part
in the bitflip threshold process; only the strength is required to be
correct.)

...and now that I bring this up, I see that pxa3xx_nand.c has not been
updated to report 'max_bitflips' via return code from
pxa3xx_nand_read_page_hwecc(). This needs fixed. I wonder how many
other drivers are similarly broken. I just realized that my
out-of-tree driver is broken for this feature :(

> I see other drivers need to implement some of the functions in the
> nand_ecc_ctrl struct, such as: hwctl(), calculate() or correct().
> However, I can't see how any of that applies on this controller.
> """

I was not suggesting you need to implement these functions.

If I've missed any other important questions, please bear with me and
repeat them.

Thanks,
Brian
