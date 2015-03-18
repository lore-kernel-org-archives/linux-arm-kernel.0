From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Mar 2015 16:51:16 +0000
Subject: [STLinux Kernel] [PATCH 2/6] pinctrl: st: Introduce a 'get pin
 function' call
In-Reply-To: <5509AAAB.8090906@st.com>
References: <1426675899-19882-1-git-send-email-lee.jones@linaro.org>
 <1426675899-19882-3-git-send-email-lee.jones@linaro.org>
 <5509AAAB.8090906@st.com>
Message-ID: <20150318165116.GR3318@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Mar 2015, Maxime Coquelin wrote:

> 
> 
> On 03/18/2015 11:51 AM, Lee Jones wrote:
> >This call fetches the numerical function value a specified pin is
> >currently operating in.  Function zero is more often than not the
> >GPIO function.  Greater than zero values represent an alternative
> >function.  You'd need to either look those up in the Device Tree
> >sources or the Programmer's Manual.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  drivers/pinctrl/pinctrl-st.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> >diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> >index 9e5ec00..5362e45 100644
> >--- a/drivers/pinctrl/pinctrl-st.c
> >+++ b/drivers/pinctrl/pinctrl-st.c
> >@@ -460,6 +460,20 @@ static void st_pctl_set_function(struct st_pio_control *pc,
> >  	regmap_field_write(alt, val);
> >  }
> >+static unsigned int st_pctl_get_pin_function(struct st_pio_control *pc, int pin)
> >+{
> >+	struct regmap_field *alt = pc->alt;
> >+	unsigned int val;
> >+	int offset = pin * 4;
> >+
> >+	if (!alt)
> >+		return 0;
> Shouldn't we print something if alt is NULL?
> Else we can think we are on alternate 0.

That is the assumption that I've made.  Is there isn't an alt, then a
pin can only be on Alt-0.  Have I made the incorrect assumption here?

> >+
> >+	regmap_field_read(alt, &val);
> >+
> >+	return (val >> offset) & 0xf;
> >+}
> >+
> >  static unsigned long st_pinconf_delay_to_bit(unsigned int delay,
> >  	const struct st_pctl_data *data, unsigned long config)
> >  {
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
