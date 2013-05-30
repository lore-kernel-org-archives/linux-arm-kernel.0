From: jp.francois@cynove.com (jean-philippe francois)
Date: Thu, 30 May 2013 10:49:51 +0200
Subject: [PATCH v2 0/1] ARM: omap3: Fix regression in dpll4 child clock
 frequency setting.
Message-ID: <CAGGh5h3fjXkmsZDvQVGJ6ehdz7SUghhHcBU-rCcRq_7HQSWN6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patch fixes a wrong container_of usage for omap3630.
All sub clock of dpll4 that do not use a reset value as divider are
affected.

For instance CAM_MCLK is 216 MHz instead of the asked 172,8 MHz
Any user of this clock is affected. This is the case for instance if
CAM_XCLKA is used to provide clock for an external camera.

Beyond wrong frequency setting, this is also a potential oops waiting
to bite any omap3isp user, since a wrong pointer is dereferenced, and
content of this pointer is used to do __raw_writel / __raw_readl.

v2 :
Follow Mike Turquette's comment and use clock framework instead of
directly accessing register.

Regards,
Jean-Philippe Fran?ois
