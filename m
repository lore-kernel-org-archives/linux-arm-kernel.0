From: michael.williamson@criticallink.com (Mike Williamson)
Date: Wed, 13 Apr 2011 19:04:34 -0400
Subject: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
	<f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
Message-ID: <BANLkTikskhqNk3NihqJ5kZhFqn1YpJEN9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 11:10 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
>
> Hi Ben,
>
> On Wed, Apr 06, 2011 at 03:08:09, Ben Gardiner wrote:
> > Both the da850 and da830 have an I2C controller which has the ICPFUNC
> > registers. Indicate this for all da830 and da850 boards by setting the
> > has_pfunc flag true in the da8xx utility setup routine for registering the
> > I2C controller
> >
> > Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> >
> > ---
> > ?arch/arm/mach-davinci/devices-da8xx.c | ? ?6 ++++++
> > ?1 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> > index beda8a4..da01558 100644
> > --- a/arch/arm/mach-davinci/devices-da8xx.c
> > +++ b/arch/arm/mach-davinci/devices-da8xx.c
> > @@ -324,6 +324,12 @@ int __init da8xx_register_i2c(int instance,
> > ? ? ? else
> > ? ? ? ? ? ? ? return -EINVAL;
> >
> > + ? ? /*
> > + ? ? ?* Both the DA850 and DA830 have an I2C controller which has the
> > + ? ? ?* ICPFUNC et. al. registers
> > + ? ? ?*/
> > + ? ? pdata->has_pfunc = 1;
>
> The I2C driver implements a default platform data
> so it should actually be legal for a DA8x board to
> pass NULL platform data. In that case this line
> will crash. You should either check for pdata to
> be NULL or just let each board choose whether it
> needs recovery (I think the better option).
>

I actually had a problem with using NULL for pdata with davinci I2C
and had submitted a patch here that sort of fell on the floor.  The
problem was that the i2c_davinci_calc_clk_dividers is using
platform_data without a check as described above.  So at the moment
using NULL doesn't really work, best as I can tell...

https://lkml.org/lkml/2010/9/4/119

FWIW.

-Mike
