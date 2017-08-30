From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Aug 2017 16:17:30 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio
 before querying its direction"
In-Reply-To: <87ziah2m3f.fsf@free-electrons.com>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com>
Message-ID: <20170830161730.41919554@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 30 Aug 2017 15:59:00 +0200, Gregory CLEMENT wrote:

> > When gpiochip_add_data() calls chip->request, what function is that
> > calling?  
> 
> the request callback is gpiochip_generic_request so I would be surprised
> that there was a bug in it.

The call chain leading to the problem is:

 gpiochip_add_data()
  chip->request() == gpiochip_generic_request()
   pinctrl_request_gpio()
    pinmux_request_gpio()
     pin_request()
      ops->gpio_request_enable() == mvebu_pinmux_gpio_request_enable()
       mvebu_pinconf_group_set()
        grp->ctrl->mpp_set() == mvebu_regmap_mpp_ctrl_set()

So what Timur is saying perhaps is that
mvebu_pinmux_gpio_request_enable() shouldn't be changing the type of
muxing, and therefore shouldn't be calling mvebu_pinconf_group_set().

However, even the "reference" pinctrl-single.c implementation does it,
in pcs_request_gpio().

Am I missing something ?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
