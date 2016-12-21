From: bernhard.nortmann@web.de (Bernhard Nortmann)
Date: Wed, 21 Dec 2016 16:11:11 +0100
Subject: [linux-sunxi] Problems to Allwinner H3's eFUSE/SID
In-Reply-To: <136061482160932@web34j.yandex.ru>
References: <136061482160932@web34j.yandex.ru>
Message-ID: <da626646-3fdf-30e1-48d3-54f225a37d20@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Side note:

Am 19.12.2016 um 16:22 schrieb Icenowy Zheng:
> [...]
>
> According to some facts:
> - The register based access to SID is weird: it needs ~5 register
>    operations per word of SID.
> [...]
>

My experiments seem to indicate that Allwinner's implementation might be
overly complicated. I have used an alternative approach and did not notice
any issues so far.

They start by reading SID_PRCTL and use bit mask operations to get in the
key index value (PG_INDEX), then use a second write to set OP_LOCK and
READ_START. As far as I can tell, it's sufficient to construct (and write)
a single value from these three components. Allwinner finally clears out
the used bits by another mask operation, simply writing zero seems to get
that job done equally well.

My implementation can be seen in
https://github.com/n1tehawk/sunxi-tools/blob/20161220_sid-fix/uart0-helloworld-sdboot.c#L242-L256
or as assembler code in
https://github.com/n1tehawk/sunxi-tools/blob/20161220_sid-fix/sid_read_root.S#L43-L65

A corresponding PR is at 
https://github.com/linux-sunxi/sunxi-tools/pull/91 ,
or you may clone my branch directly
("git clone https://github.com/n1tehawk/sunxi-tools.git -b 
20161220_sid-fix").

Testers would be very welcome.

Regards, B. Nortmann
