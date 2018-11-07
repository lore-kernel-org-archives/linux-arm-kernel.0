From: natechancellor@gmail.com (Nathan Chancellor)
Date: Wed, 7 Nov 2018 01:55:03 -0700
Subject: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
In-Reply-To: <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
Message-ID: <20181107085503.GA31517@flashbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
> On 01. 11. 18 1:57, Nathan Chancellor wrote:
> > Clang warns when one enumerated type is implicitly converted to another:
> > 
> > drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
> > enumeration type 'enum zynq_pin_config_param' to different enumeration
> > type 'enum pin_config_param' [-Wenum-conversion]
> >         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> >         ~               ^~~~~~~~~~~~~~~~~~~~~
> > drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
> > enumeration type 'enum zynq_pin_config_param' to different enumeration
> > type 'enum pin_config_param' [-Wenum-conversion]
> >         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
> >             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
> > macro 'PCONFDUMP'
> >         .param = a, .display = b, .format = c, .has_arg = d     \
> >                  ^
> > 2 warnings generated.
> 
> This is interesting. I have never tried to use llvm for building the
> kernel. Do you have any description how this can be done?
> 

Depending on what version of Clang you have access to, it is usually just as
simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.

Clang 7.0+ is recommended but 6.0 might work too.

> 
> > 
> > It is expected that pinctrl drivers can extend pin_config_param because
> > of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
> > isn't an issue. Most drivers that take advantage of this define the
> > PIN_CONFIG variables as constants, rather than enumerated values. Do the
> > same thing here so that Clang no longer warns.
> > 
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/pinctrl/pinctrl-zynq.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> > index a0daf27042bd..57046c221756 100644
> > --- a/drivers/pinctrl/pinctrl-zynq.c
> > +++ b/drivers/pinctrl/pinctrl-zynq.c
> > @@ -972,14 +972,11 @@ enum zynq_io_standards {
> >  };
> >  
> >  /**
> > - * enum zynq_pin_config_param - possible pin configuration parameters
> 
> This is wrong. kernel-doc is reporting issue with it.
> 
> drivers/pinctrl/pinctrl-zynq.c:975: warning: Cannot understand  *
> @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the
> argument to
>  on line 975 - I thought it was a doc line
> 1 warnings
> 

Ah yes, I forgot to send a v2 of this patch when someone pointed out
this problem in a different patch. I'll send that now, thanks for the
review!

> 
> >   * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
> >   *	this parameter (on a custom format) tells the driver which alternative
> >   *	IO standard to use.
> >   */
> > -enum zynq_pin_config_param {
> > -	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
> > -};
> > +#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
> >  
> >  static const struct pinconf_generic_params zynq_dt_params[] = {
> >  	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
> > 
> 
> This change is fine.
> 
> Thanks,
> Michal
