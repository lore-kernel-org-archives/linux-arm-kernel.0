From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 20 Jun 2011 16:58:09 +0900
Subject: [PATCH 1/2] Exynos4 NURI: configure regulators and PMIC
In-Reply-To: <20110618151227.GB25163@sirena.org.uk>
References: <1308215372-17420-1-git-send-email-myungjoo.ham@samsung.com>
	<20110618151227.GB25163@sirena.org.uk>
Message-ID: <BANLkTin6hSaNSDd+dEZdkk3F5O5nDYf9yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Sun, Jun 19, 2011 at 12:12 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jun 16, 2011 at 06:09:31PM +0900, MyungJoo Ham wrote:
>
[]
>
>> +static struct regulator_init_data nuri_max8997_ldo10_data = {
>> + ? ? .constraints ? ?= {
>
> You should be able to use __initdata for a lot of this by the way.
>


Anyway, I've got a question about using __initdata for platform_data entries.

Using __initdata on this entry and other max8997's platform_data did
not create any SECTION MISMATCH warnings.

"Documentation/DocBook/kernel-hacking.tmpl" says, __initdata means
that the content of it may be free'd after boot.


However, the MAX8997 driver uses platform_data's entry (variables
defined in "static struct max8997_platform_data __initdata
nuri_max8997_pdata)
in its normal functions other than its probe function, which are often
called after boot.

Probably, I'm thinking wrong in some place; however, it seems that
there should be SECTION MISMATCH warnings as the MAX8997 driver uses
the pdata, which is declared to be __initdata, in non-_init function.
Or, is it safe to use platform_data (by dev_get_platdata) out of probe
in drivers even if the platdata is declared to be __initdata in the
platform files?

I just can't sure whether I should let probe function copy
platform-data used by non-probe functions to its own local data
assuming that the content may be freed (assuming that the SECTION
MISMATCH warning is not "complete".) or just believe the completeness
of gcc's SECTION MISMATCH warning.


Cheers!

- MyungJoo


-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
