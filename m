From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 5 Nov 2013 18:27:25 -0800
Subject: [PATCH v3 22/28] mtd: nand: pxa3xx: Introduce multiple page I/O
 support
In-Reply-To: <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383656135-8627-23-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131105190432.GQ20061@ld-irv-0074.broadcom.com>
 <20131106011351.GH11759@localhost>
 <CAN8TOE_ZmcsvShKY273KQCaopJEXgtXVR1XY9pP5EKkUK+bUbA@mail.gmail.com>
Message-ID: <CAN8TOE8ogqQqFoPN0=tjOmf-jMzeSPA8iwqGSy9hcUE6ODFGFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 6:20 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Tue, Nov 5, 2013 at 5:13 PM, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
>> So, why should I tell the NAND core any of the ECC details?
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

To clarify a bit further: the ECC step size doesn't play a part in
nand_base when dealing with max_bitflips, but it is implicit in the
specification: the driver should be returning the maximum number of
bitflips corrected in a single ECC sector of the page that was read.
So if your driver reports ECC strength of 8 over a 512 byte step, then
you should report a number in the range of 0 to 8, representing
bitflips in a 512B sector. If you don't have this granularity (which
it looks like you might not?) then maybe your strength-per-sector
should really be 16-per-2048B or 16-per-1024B, etc.

Brian
