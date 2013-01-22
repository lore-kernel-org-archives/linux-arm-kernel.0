From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 22 Jan 2013 10:21:04 +0000
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <CAD6h2NQ68PpT2z5WkCOdkznhe+ZFOhaZ9=Zpgsy9_Da_2eha=g@mail.gmail.com>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
 <1358785488.6590.33.camel@hornet>
 <CAD6h2NQ68PpT2z5WkCOdkznhe+ZFOhaZ9=Zpgsy9_Da_2eha=g@mail.gmail.com>
Message-ID: <1358850064.6590.70.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-01-21 at 23:33 +0000, Haojian Zhuang wrote:
> The sequence of module probe is pinctrl --> gpio --> mmc. So the dependance
> of mmc on gpio isn't broken.

I don't think you can guarantee the "gpio --> mmc" sequence if both
drivers use module_init (the order could be completely random, generally
it depends on what Kbuild is doing), but if gpio_request() behaves as
Linus said, the sequence in the problematic scenario would be "pinctrl
--> mmc --> EPROBE_DEFER --> gpio --> mmc" which is fine (subject to
mmci driver fix, but it's a separate issue).

Pawe?
