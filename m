From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 May 2012 14:08:01 +0100
Subject: [PATCH 2/2] regulator: Add support for MAX77686.
In-Reply-To: <CAKew6eVZuOUH8RHQbffCGX7i=6dM-qOJXojoKrOsM3V5ugEjHA@mail.gmail.com>
References: <1336580695-1184-1-git-send-email-yadi.brar@samsung.com>
 <1336580695-1184-3-git-send-email-yadi.brar@samsung.com>
 <20120509184709.GC32037@sirena.org.uk>
 <CAKew6eVZuOUH8RHQbffCGX7i=6dM-qOJXojoKrOsM3V5ugEjHA@mail.gmail.com>
Message-ID: <20120516130800.GC26337@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 07:17:11PM +0530, Yadwinder Singh Brar wrote:
> On Thu, May 10, 2012 at 12:17 AM, Mark Brown
> > On Wed, May 09, 2012 at 09:54:55PM +0530, Yadwinder Singh wrote:

> >> + ? ? if (iodev->dev->of_node) {
> >> + ? ? ? ? ? ? ret = max77686_pmic_dt_parse_pdata(iodev, pdata);
> >> + ? ? ? ? ? ? if (ret)
> >> + ? ? ? ? ? ? ? ? ? ? return ret;

> > This ought to use of_regulator_match().

> While using it I am seeing that though it reduces few lines of code in
> our driver , it adds a huge array(of_regulator_match[])in which we
> have to populate the strings(name) which we already have in
> regulator_desc[ ], Isn't it overhead ?

Well, I think half the problem here is that you're only instantiating
things you find in the device tree.  If you were unconditionally
instantiating all the regulators then suddenly this becomes a lot
neater.

> >> + ? ? ? ? ? ? rdev[i] = regulator_register(&regulators[id], max77686->dev,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?pdata->regulators[i].initdata,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?max77686, NULL);

> > No, you should unconditionally register all regulators the device
> > physically has. ?This is useful for debug and simplifies the code.

> If we have to use only 2 or 3 regulators on our board out off 36 or
> lets take a case if our chip supports 50/100 regulators, I think i
> will a overhead to register all unused regulators as well as
> populating all the regulators in DT or platform data.

This isn't really a terribly realistic situation - if there are were
that many unused regulators the part selection is clearly not
appropriate to the system and most hardware engineers just wouldn't do
it.

Having information about all the regulators also allows us to do things
like power off any unused regulators which were left on after boot (eg,
due to bootloader or the PMIC defaults).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/19a52f25/attachment.sig>
