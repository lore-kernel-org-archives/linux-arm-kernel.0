From: davem@davemloft.net (David Miller)
Date: Sat, 26 Jun 2010 21:07:28 -0700 (PDT)
Subject: [RFC 9/9] crypto: Add Samsung crypto engine driver
In-Reply-To: <4C129341.2060407@gmail.com>
References: <cover.1276284559.git.mcuelenaere@gmail.com>
	<4C129341.2060407@gmail.com>
Message-ID: <20100626.210728.90806559.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Fri, 11 Jun 2010 21:49:21 +0200

> This patch adds support for the Samsung crypto engine driver available in the
> S3C64XX and S5PC100 SoCs. Currently this supports AES and (T)DES with ECB and
> CBC block ciphers (also CTR for AES). Support for (HMAC)-SHA1 acceleration is
> also available in this engine, but isn't used in the driver yet.
> 
> Support for DMA has been added in the code but is currently disabled due to
> issues with data transfers.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

I would personally queue up new crypto requests directly when there are
no queued up requests and ->cur_req is NULL, instead of doing all of
that work to do the submission in the tasklet.  I would also do the
completion and queue running directly in the hw IRQ handler.

The tasklet is just pure overhead.

Basically, when doing async crypto, every cycle that is consumed just
to implement crypto job submission and completion takes away from the
gains you get by doing it in hw at all.

You can see this clearly if you do performance comparisons between the
synchronous crypto routines and your async ones done in HW.
