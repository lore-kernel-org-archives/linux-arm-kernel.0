From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 18 Oct 2016 14:19:11 -0400
Subject: [BUG] LPC32xx gpio driver broken by commit 762c2e46 in 4.9-rc1
In-Reply-To: <6e71451a-9392-92cf-c7f5-a5bcbf9d4dd1@mleia.com>
References: <1476807799.10214.25.camel@localhost>
 <6e71451a-9392-92cf-c7f5-a5bcbf9d4dd1@mleia.com>
Message-ID: <1476814751.24094.6.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Tue, 2016-10-18 at 21:06 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 18.10.2016 19:23, Sylvain Lemieux wrote:
> > Vladimir, Linus, Alexandre,
> > 
> > the current LPC32xx GPIO driver is broken by commit 762c2e46
> > (gpio: of: remove of_gpiochip_and_xlate() and struct gg_data).
> 
> I do confirm, as well I've noticed that the driver is broken on v4.9, 
> however I didn't find time to bisect the problematic commit, thank
> you to pinning it out.
> 
> > A call to "of_get_named_gpio" to retrieve the GPIO will
> > always return -EINVAL, except for the first GPIO bank.
> > 
> > Prior to this commit, the driver was working properly
> > because of the side-effect of the match function called by
> > "gpiochip_find" inside "of_get_named_gpiod_flags" function.
> > 
> > I think, the proper long-term solution is to replace the
> > LPC32xx GPIO driver; an initial version was previously
> > submitted, by Vladimir Zapolskiy, to the mailing list:
> > http://www.spinics.net/lists/linux-gpio/msg09746.html
> 
> I still cherish a hope for submitting v2 for v4.10, the difference
> from v1 is expected to be relatively big (e.g. there will be 5
> banks instead of 6, on hardware level banks P0 and P1 are on the
> single controller, there will be other lesser differences also).
> 
I will be available to test the new driver, once submitted
on the mailing list.

> > Is there any short-term solution that can be done with
> > the existing driver to keep the LPC32xx platform working
> > properly in the 4.9 mainline kernel?
> 
> Unfortunately I didn't spend enough time to fix the problem,
> but in two words the root cause is that from the OF description
> there is only one on-SoC GPIO controller, but the GPIO controller
> driver registers multiple gpiochips (6 in this particular case),
> consumers specify a bank as a value in the first cell.
> The referenced commit simplifies the matter by assuming that
> a number of gpiochips for consumers is the same as the number
> of registered GPIO controllers from OF description.
> 
> I don't think that the problem is specific only to the legacy
> LPC32xx GPIO controller driver, but at the moment I don't have
> any more examples to share. Probably another 3-cell GPIO
> controller driver gpio-etraxfs.c is also broken, a good enough
> implicit indicator for potentially broken drivers might be if
> you see gpiochip_add_data() call inside a loop:
> * gpio-sch311x.c
> * gpio-ml-ioh.c
> * gpio-etraxfs.c
> * gpio-htc-egpio.c
> * gpio-davinci.c
> * gpio-lpc32xx.c
> 
As a temporary solution, locally I reverted the following
commits to be able to have a working platform on 4.9-rc1:
* "gpio: of: factor out common code to a new helper function"
  (99468c1af913bb5662c223b68e783b4bf9200184)
* "gpio: of: remove of_gpiochip_and_xlate() and struct gg_data"
  (762c2e46c0591d207289105c8718e4adf29b2b34)


Regards,
Sylvain
