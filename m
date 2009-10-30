From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 30 Oct 2009 01:24:32 +0100
Subject: S3C6410 board (SmartQ 7) USB host issues
Message-ID: <4AEA3240.10105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on getting mainline Linux working on the SmartQ 7, a Samsung 
S3C6410 board.

I'm having issues getting USB host to work, when I try to attach a 
device (Logitech mouse in this case) to it I get "device descriptor 
read/64, error -62" errors. Then it gets a new address assigned and gets 
back to the same error (this loops around 4 times, then Linux seems to 
give up).

This board doesn't have a separate 48M clock source, so I'm currently 
changing the USB host clock source to EPLL in my board config like this:


struct clk * usb_clock, * mout_epll;

usb_clock = clk_get(NULL, "usb-bus-host");
if(usb_clock == NULL) {
     pr_err("%s: failed to get usb-bus-host clock\n", __func__);
     return -ENXIO;
}
mout_epll = clk_get(NULL, "mout_epll");
if(mout_epll == NULL) {
     pr_err("%s: failed to get mout_epll clock\n", __func__);
     clk_put(usb_clock);
     return -ENXIO;
}

/* setup clock */
clk_set_parent(usb_clock, mout_epll);
clk_set_rate(usb_clock, 48000000);

clk_put(usb_clock);
clk_put(mout_epll);


Any ideas what I could be doing wrong?

Thanks,

Maurus Cuelenaere
